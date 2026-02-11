from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response
from prometheus_client import Counter, Histogram, generate_latest
from sqlalchemy import text
from datetime import datetime
from pydantic import BaseModel
import time
import logging

from app.core.config import settings
from app.db.database import engine, Base, SessionLocal
from app.api.routes import gpus, auth, cart
from app.api.routes.cart import redis_client
from app.services.ai_service import ai_service  # ⬅️ NUEVO

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Función para crear tablas con retry logic
def create_tables_with_retry(max_retries=3, delay=2):
    for attempt in range(max_retries):
        try:
            logger.info(
                f"Attempt {attempt + 1}/{max_retries}: Creating database tables..."
            )
            Base.metadata.create_all(bind=engine)
            logger.info("✅ Database tables created successfully")
            return True
        except Exception as e:
            logger.error(f"❌ Error: {e}")
            if attempt < max_retries - 1:
                time.sleep(delay)
    return False

# Inicializar FastAPI
app = FastAPI(
    title="GpuChile API",
    description="Production-grade GPU e-commerce API with EKS architecture + AI",
    version="1.1.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

# Evento de inicio
@app.on_event("startup")
async def startup_event():
    """Inicializar recursos al arrancar"""
    logger.info("🚀 Starting GpuChile API...")
    success = create_tables_with_retry()
    if not success:
        logger.error("❌ Failed to create database tables after retries")
    else:
        logger.info("✅ API ready to receive traffic")

# Configuración CORS
origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
    "http://frontend:5173",
    "*",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Prometheus Metrics
request_count = Counter(
    "http_requests_total", "Total HTTP requests", ["method", "endpoint", "status"]
)
request_duration = Histogram(
    "http_request_duration_seconds", "HTTP request duration", ["method", "endpoint"]
)

@app.middleware("http")
async def track_metrics(request: Request, call_next):
    start_time = time.time()
    response = await call_next(request)
    duration = time.time() - start_time

    if request.url.path not in ["/health", "/metrics", "/healthz", "/readyz"]:
        request_count.labels(
            method=request.method,
            endpoint=request.url.path,
            status=response.status_code,
        ).inc()

        request_duration.labels(
            method=request.method, endpoint=request.url.path
        ).observe(duration)

    return response

# Rutas existentes
app.include_router(gpus.router, prefix="/api/gpus", tags=["GPUs"])
app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(cart.router, prefix="/api/cart", tags=["Cart"])

# ===== NUEVO: AI ENDPOINT =====
class QuestionRequest(BaseModel):
    query: str

@app.post("/api/v1/ask-ai", tags=["AI"])
async def ask_ai(request: QuestionRequest):
    """
    Endpoint de IA con RAG (Retrieval-Augmented Generation)
    Usa pgvector para búsqueda semántica + Groq (Llama-3)
    """
    if not ai_service.is_available():
        return {
            "error": "AI service not configured",
            "message": "Please set GROQ_API_KEY and ensure database has pgvector extension"
        }
    
    response = ai_service.ask_agent(request.query)
    return response


# System Endpoints
@app.get("/")
def root():
    return {
        "message": "Welcome to GpuChile API 🚀",
        "version": "1.1.0",
        "docs": "/docs",
        "environment": settings.ENVIRONMENT,
        "ai_enabled": ai_service.is_available()
    }

@app.get("/health", tags=["System"])
def health_check():
    """Health Check completo para Docker/Kubernetes"""
    try:
        db = SessionLocal()
        db.execute(text("SELECT 1"))
        db.close()
        db_status = "healthy"
    except Exception as e:
        db_status = f"unhealthy: {str(e)}"

    try:
        if redis_client:
            redis_client.ping()
            redis_status = "healthy"
        else:
            redis_status = "not configured"
    except Exception as e:
        redis_status = f"unhealthy: {str(e)}"

    status_code = 200 if db_status == "healthy" and redis_status == "healthy" else 503

    return {
        "status": "ok" if status_code == 200 else "error",
        "services": {
            "database": db_status,
            "redis": redis_status,
            "ai": "enabled" if ai_service.is_available() else "disabled"
        },
        "timestamp": datetime.utcnow().isoformat(),
    }

@app.get("/metrics", tags=["System"])
def metrics():
    """Endpoint para que Prometheus haga scraping"""
    return Response(content=generate_latest(), media_type="text/plain")

@app.get("/healthz", tags=["System"])
def liveness():
    """K8s Liveness Probe"""
    return {"status": "alive"}

@app.get("/readyz", tags=["System"])
def readiness():
    """K8s Readiness Probe"""
    return {"status": "ready"}
