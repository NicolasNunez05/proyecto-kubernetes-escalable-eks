"""
Script de Seeding para RAG con pgvector
Ejecutar: python -m apps.backend.scripts.seed_rag
"""
import sys
import os
from pathlib import Path

# Agregar path del proyecto
project_root = Path(__file__).parent.parent.parent.parent
sys.path.insert(0, str(project_root))

from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from sentence_transformers import SentenceTransformer
import logging

from apps.backend.app.models.product import Product
from apps.backend.app.db.database import Base

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configuración de DB (ajusta según tu entorno)
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://postgres:postgres@localhost:5432/gpuchile"
)

# GPU Catalog (10 productos de ejemplo)
GPU_CATALOG = [
    {
        "name": "NVIDIA RTX 4090",
        "description": "La GPU más potente del mercado. 24GB GDDR6X, ideal para gaming 4K, ray tracing extremo y workloads de IA. Arquitectura Ada Lovelace con DLSS 3.0.",
        "price": 1899.99,
        "stock": 15,
        "brand": "NVIDIA"
    },
    {
        "name": "NVIDIA RTX 4080 SUPER",
        "description": "GPU de alto rendimiento para gaming 4K y creación de contenido. 16GB GDDR6X, excelente balance precio/rendimiento con ray tracing.",
        "price": 1199.99,
        "stock": 25,
        "brand": "NVIDIA"
    },
    {
        "name": "NVIDIA RTX 4070 Ti",
        "description": "Perfecta para gaming 1440p y 4K. 12GB GDDR6X, arquitectura Ada con eficiencia energética superior. Ideal para streamers.",
        "price": 799.99,
        "stock": 30,
        "brand": "NVIDIA"
    },
    {
        "name": "NVIDIA RTX 4060 Ti",
        "description": "GPU mainstream para gaming 1080p y 1440p. 8GB GDDR6, DLSS 3 y bajo consumo. Excelente para presupuestos medios.",
        "price": 499.99,
        "stock": 50,
        "brand": "NVIDIA"
    },
    {
        "name": "AMD Radeon RX 7900 XTX",
        "description": "GPU tope de línea de AMD. 24GB GDDR6, arquitectura RDNA 3, competidor directo del RTX 4080. Excelente para gaming 4K y rasterización.",
        "price": 999.99,
        "stock": 20,
        "brand": "AMD"
    },
    {
        "name": "AMD Radeon RX 7900 XT",
        "description": "GPU de alta gama con 20GB GDDR6. Rendimiento excepcional en 1440p y 4K, tecnología FSR 3. Mejor relación precio/memoria.",
        "price": 849.99,
        "stock": 22,
        "brand": "AMD"
    },
    {
        "name": "AMD Radeon RX 7800 XT",
        "description": "Sweetspot de AMD para gaming 1440p. 16GB GDDR6, arquitectura RDNA 3, excelente para juegos AAA modernos con alto FPS.",
        "price": 649.99,
        "stock": 35,
        "brand": "AMD"
    },
    {
        "name": "AMD Radeon RX 7700 XT",
        "description": "GPU de gama media-alta con 12GB GDDR6. Ideal para gaming 1440p con alta calidad. Competidor del RTX 4060 Ti.",
        "price": 549.99,
        "stock": 40,
        "brand": "AMD"
    },
    {
        "name": "NVIDIA RTX 3060",
        "description": "GPU de generación anterior pero muy capaz. 12GB GDDR6, perfecta para gaming 1080p y trabajo creativo. Excelente relación calidad/precio.",
        "price": 329.99,
        "stock": 60,
        "brand": "NVIDIA"
    },
    {
        "name": "AMD Radeon RX 6700 XT",
        "description": "GPU RDNA 2 con 12GB GDDR6. Excelente para gaming 1440p y presupuestos ajustados. Buen overclocking y eficiencia.",
        "price": 379.99,
        "stock": 45,
        "brand": "AMD"
    }
]


def seed_database():
    """Seed de la base de datos con productos y embeddings"""
    
    # 1. Conectar a la DB
    engine = create_engine(DATABASE_URL)
    SessionLocal = sessionmaker(bind=engine)
    db = SessionLocal()
    
    try:
        # 2. Activar extensión pgvector
        logger.info("🔌 Activating pgvector extension...")
        db.execute(text("CREATE EXTENSION IF NOT EXISTS vector;"))
        db.commit()
        logger.info("✅ pgvector extension activated")
        
        # 3. Crear tablas
        logger.info("📊 Creating tables...")
        Base.metadata.create_all(bind=engine)
        logger.info("✅ Tables created")
        
        # 4. Limpiar productos existentes (opcional)
        logger.info("🗑️ Cleaning existing products...")
        db.query(Product).delete()
        db.commit()
        
        # 5. Cargar modelo de embeddings (384 dimensiones)
        logger.info("🤖 Loading embedding model (all-MiniLM-L6-v2)...")
        model = SentenceTransformer('all-MiniLM-L6-v2')
        logger.info("✅ Model loaded successfully")
        
        # 6. Insertar productos con embeddings
        logger.info("💾 Inserting products with embeddings...")
        for idx, gpu_data in enumerate(GPU_CATALOG, 1):
            # Generar embedding de la descripción
            description_text = gpu_data["description"]
            embedding_vector = model.encode(description_text).tolist()
            
            product = Product(
                name=gpu_data["name"],
                description=gpu_data["description"],
                price=gpu_data["price"],
                stock=gpu_data["stock"],
                brand=gpu_data["brand"],
                category="GPU",
                embedding=embedding_vector
            )
            
            db.add(product)
            logger.info(f"  [{idx}/10] ✅ {gpu_data['name']}")
        
        db.commit()
        logger.info("🎉 Seeding completed successfully!")
        
        # 7. Verificar
        count = db.query(Product).count()
        logger.info(f"📊 Total products in database: {count}")
        
    except Exception as e:
        logger.error(f"❌ Error during seeding: {e}")
        db.rollback()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    logger.info("🚀 Starting RAG Database Seeding...")
    seed_database()
