"""
Script de migraciones para ejecutar como Kubernetes Job.
Diseñado para ejecución idempotente y safe.
"""
import sys
import logging
import time
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError, OperationalError
from app.db.session import engine, SessionLocal, Base
from app.models.gpu import GPU
# from app.models.cart import CartItem # Comentado si no lo usas en el seed

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def wait_for_db(max_retries: int = 30, retry_interval: int = 2):
    for attempt in range(1, max_retries + 1):
        try:
            logger.info(f"🔄 Intento {attempt}/{max_retries}: Conectando a PostgreSQL...")
            with engine.connect() as conn:
                conn.execute(text("SELECT 1"))
            logger.info("✅ PostgreSQL está listo")
            return True
        except OperationalError as e:
            if attempt == max_retries:
                logger.error(f"❌ No se pudo conectar después de {max_retries} intentos: {e}")
                return False
            logger.warning(f"⏳ Reintentando en {retry_interval}s...")
            time.sleep(retry_interval)
    return False

def create_tables():
    try:
        logger.info("🔧 Creando/verificando tablas...")
        Base.metadata.create_all(bind=engine)
        logger.info("✅ Tablas listas")
        return True
    except Exception as e:
        logger.error(f"❌ Error al crear tablas: {e}")
        return False

def seed_gpus():
    db = SessionLocal()
    try:
        if db.query(GPU).count() > 0:
            logger.info("ℹ️  Datos ya existen. Saltando seed.")
            return True
        
        logger.info("🌱 Iniciando seed de GPUs...")
        gpus_data = [
            {"name": "NVIDIA GeForce RTX 4090", "brand": "NVIDIA", "model": "RTX 4090", "price": 1599990, "stock": 5, "vram": 24, "cuda_cores": 16384, "image_url": "https://dlcdnwebimgs.asus.com/gain/4B683935-4309-4087-9759-6F0949709E1E"},
            {"name": "NVIDIA GeForce RTX 4070", "brand": "Zotac", "model": "Twin Edge", "price": 599990, "stock": 10, "vram": 12, "cuda_cores": 5888, "image_url": "https://www.zotac.com/download/files/styles/w1024/public/product_main_image/graphics_cards/zt-d40700e-10m-image01.jpg"},
            {"name": "AMD Radeon RX 7900 XTX", "brand": "Sapphire", "model": "Nitro+", "price": 1099990, "stock": 3, "vram": 24, "cuda_cores": 0, "image_url": "https://cdn.shopify.com/s/files/1/0024/9803/5810/products/11322-01-20G_01_1024x1024.png"},
            {"name": "NVIDIA GeForce RTX 3060", "brand": "EVGA", "model": "XC3", "price": 329990, "stock": 20, "vram": 12, "cuda_cores": 3584, "image_url": "https://images.evga.com/products/gallery/png/12G-P5-3657-KR_LG_1.png"},
        ]
        
        for gpu_data in gpus_data:
            db.add(GPU(**gpu_data))
        db.commit()
        logger.info(f"✅ Seed completado: {len(gpus_data)} GPUs insertadas")
        return True
    except Exception as e:
        logger.error(f"❌ Error en seed: {e}")
        db.rollback()
        return False
    finally:
        db.close()

if __name__ == "__main__":
    if not wait_for_db(): sys.exit(1)
    if not create_tables(): sys.exit(1)
    if not seed_gpus(): sys.exit(1)
    logger.info("🎉 Migraciones completadas")
    sys.exit(0)