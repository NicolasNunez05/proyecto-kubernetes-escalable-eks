import logging
# IMPORTANTE: Agregamos engine y Base para poder crear las tablas
from app.db.database import SessionLocal, engine, Base 
from app.models.gpu import GPU

# Configurar logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def seed_data():
    """
    Crea las tablas y puebla la base de datos.
    """
    # --- CORRECCIÓN CRUCIAL ---
    # Esto obliga a crear las tablas (CREATE TABLE IF NOT EXISTS) antes de insertar datos
    logger.info("🔧 Creando tablas en la base de datos...")
    Base.metadata.create_all(bind=engine)
    # --------------------------

    db = SessionLocal()
    try:
        # Verificar si ya existen datos
        exists = db.query(GPU).first()
        if exists:
            logger.info("⚠️ La base de datos ya tiene datos. Saltando seed.")
            return

        logger.info("🌱 Iniciando seed de datos...")

        # Lista de GPUs (Datos de prueba)
        gpus = [
            GPU(
                name="NVIDIA GeForce RTX 4090",
                brand="ASUS",
                model="ROG Strix",
                price=1599990.0, # Float explícito
                vram=24,
                cuda_cores=16384,
                image_url="https://dlcdnwebimgs.asus.com/gain/4B683935-4309-4087-9759-6F0949709E1E",
                stock=5,
                description="La GPU más potente del mercado.",
                is_featured=True
            ),
            GPU(
                name="NVIDIA GeForce RTX 4070",
                brand="Zotac",
                model="Twin Edge",
                price=599990.0,
                vram=12,
                cuda_cores=5888,
                image_url="https://www.zotac.com/download/files/styles/w1024/public/product_main_image/graphics_cards/zt-d40700e-10m-image01.jpg",
                stock=10,
                description="Excelente relación precio/rendimiento.",
                is_featured=False
            ),
            GPU(
                name="AMD Radeon RX 7900 XTX",
                brand="Sapphire",
                model="Nitro+",
                price=1099990.0,
                vram=24,
                cuda_cores=6144,
                image_url="https://cdn.shopify.com/s/files/1/0024/9803/5810/products/11322-01-20G_01_1024x1024.png",
                stock=3,
                description="Potencia bruta de AMD.",
                is_featured=True
            ),
            GPU(
                name="NVIDIA GeForce RTX 3060",
                brand="EVGA",
                model="XC3",
                price=329990.0,
                vram=12,
                cuda_cores=3584,
                image_url="https://images.evga.com/products/gallery/png/12G-P5-3657-KR_LG_1.png",
                stock=20,
                description="La favorita de los gamers.",
                is_featured=False
            ),
        ]

        db.add_all(gpus)
        db.commit()
        logger.info(f"✅ Seed exitoso: {len(gpus)} GPUs insertadas")

    except Exception as e:
        logger.error(f"❌ Error durante el seed: {e}")
        db.rollback()
    finally:
        db.close()

if __name__ == "__main__":
    seed_data()