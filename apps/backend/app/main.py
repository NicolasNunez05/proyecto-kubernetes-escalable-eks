"""
🎯 QUÉ HACE: Inicia la aplicación FastAPI
📍 CUÁNDO SE USA: Primer archivo que ejecuta uvicorn
"""
from fastapi import FastAPI
from app.api.routes import gpus, auth, favorites, admin
from app.config import settings
import os

# ✅ 12-FACTOR: Lee de ENV, no de boto3
DATABASE_URL = os.getenv("DATABASE_URL")

app = FastAPI(
    title="GpuChile API",
    description="API para e-commerce de GPUs",
    version="1.0.0"
)

# Configuración permisiva para desarrollo, restrictiva para prod
origins = [
    "http://localhost:3000",          # React local
    "http://localhost:8080",          # Nginx local
    "https://gpuchile.com",           # Prod (futuro)
    "https://www.gpuchile.com"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],  # Permitir GET, POST, DELETE, OPTIONS
    allow_headers=["*"],  # Permitir Authorization header (JWT)
)

# Registrar rutas
app.include_router(gpus.router, prefix="/api", tags=["GPUs"])
app.include_router(auth.router, prefix="/api/auth", tags=["Auth"])
app.include_router(favorites.router, prefix="/api/favorites", tags=["Favorites"])
app.include_router(admin.router, prefix="/api/admin", tags=["Admin"])

@app.get("/health")
async def health():
    return {"status": "healthy"}