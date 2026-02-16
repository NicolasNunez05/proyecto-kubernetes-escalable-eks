"""
Seed script para poblar la base de datos con 15 GPUs reales del mercado.
Uso: python -m app.scripts.seed_gpus
"""

import sys
import os
from sqlalchemy.orm import Session

# Add parent directory to path para importar app
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../../..")))

from app.db.database import SessionLocal, engine
from app.db.models import Base, GPU


def create_tables():
    """Crea todas las tablas si no existen"""
    Base.metadata.create_all(bind=engine)
    print("[INFO] Tablas de base de datos verificadas.")


def seed_gpus(db: Session):
    """Inserta 15 GPUs reales en la base de datos"""

    # Verificar si ya existen GPUs
    try:
        existing_count = db.query(GPU).count()
        if existing_count >= 15:
            print(f"[WARN] Ya existen {existing_count} GPUs en la DB. Saltando seed.")
            return
    except Exception as e:
        print(f"[INFO] Parece que las tablas no existen o están vacías. Continuando... ({str(e)})")

    gpus_data = [
        # NVIDIA RTX 40 Series (High-End)
        {
            "name": "NVIDIA GeForce RTX 4090",
            "brand": "NVIDIA",
            "model": "RTX 4090",
            "price": 1899.99,
            "stock": 12,
            "vram": 24,
            "cuda_cores": 16384,
            "image_url": None,
            "description": "Flagship GPU with Ada Lovelace architecture. Beast for 4K gaming and AI workloads.",
        },
        {
            "name": "NVIDIA GeForce RTX 4080 SUPER",
            "brand": "NVIDIA",
            "model": "RTX 4080 SUPER",
            "price": 1099.99,
            "stock": 18,
            "vram": 16,
            "cuda_cores": 10240,
            "image_url": None,
            "description": "High-performance gaming at 4K with ray tracing and DLSS 3.5.",
        },
        {
            "name": "NVIDIA GeForce RTX 4070 Ti SUPER",
            "brand": "NVIDIA",
            "model": "RTX 4070 Ti SUPER",
            "price": 849.99,
            "stock": 25,
            "vram": 16,
            "cuda_cores": 8448,
            "image_url": None,
            "description": "Excellent 1440p performance with 16GB VRAM for content creation.",
        },
        {
            "name": "NVIDIA GeForce RTX 4060 Ti",
            "brand": "NVIDIA",
            "model": "RTX 4060 Ti",
            "price": 449.99,
            "stock": 30,
            "vram": 8,
            "cuda_cores": 4352,
            "image_url": None,
            "description": "Solid 1080p gaming with RTX features at accessible price point.",
        },
        # AMD Radeon RX 7000 Series (Enthusiast)
        {
            "name": "AMD Radeon RX 7900 XTX",
            "brand": "AMD",
            "model": "RX 7900 XTX",
            "price": 999.99,
            "stock": 15,
            "vram": 24,
            "cuda_cores": 6144,
            "image_url": None,
            "description": "AMD's flagship RDNA 3 GPU with 24GB for high-end gaming and workstation tasks.",
        },
        {
            "name": "AMD Radeon RX 7900 XT",
            "brand": "AMD",
            "model": "RX 7900 XT",
            "price": 849.99,
            "stock": 20,
            "vram": 20,
            "cuda_cores": 5376,
            "image_url": None,
            "description": "Strong 4K gaming performance with generous 20GB VRAM.",
        },
        {
            "name": "AMD Radeon RX 7800 XT",
            "brand": "AMD",
            "model": "RX 7800 XT",
            "price": 549.99,
            "stock": 28,
            "vram": 16,
            "cuda_cores": 3840,
            "image_url": None,
            "description": "Best value for 1440p gaming with 16GB VRAM.",
        },
        {
            "name": "AMD Radeon RX 7600",
            "brand": "AMD",
            "model": "RX 7600",
            "price": 299.99,
            "stock": 35,
            "vram": 8,
            "cuda_cores": 2048,
            "image_url": None,
            "description": "Budget-friendly 1080p gaming with RDNA 3 efficiency.",
        },
        # NVIDIA RTX 30 Series (Previous Gen - Still Relevant)
        {
            "name": "NVIDIA GeForce RTX 3090",
            "brand": "NVIDIA",
            "model": "RTX 3090",
            "price": 1199.99,
            "stock": 8,
            "vram": 24,
            "cuda_cores": 10496,
            "image_url": None,
            "description": "Previous-gen flagship with massive 24GB VRAM for creators.",
        },
        {
            "name": "NVIDIA GeForce RTX 3080",
            "brand": "NVIDIA",
            "model": "RTX 3080",
            "price": 799.99,
            "stock": 10,
            "vram": 10,
            "cuda_cores": 8704,
            "image_url": None,
            "description": "Legendary GPU from Ampere era. Still crushes 1440p gaming.",
        },
        {
            "name": "NVIDIA GeForce RTX 3070",
            "brand": "NVIDIA",
            "model": "RTX 3070",
            "price": 549.99,
            "stock": 14,
            "vram": 8,
            "cuda_cores": 5888,
            "image_url": None,
            "description": "Sweet spot for 1440p gaming at great value.",
        },
        # Intel Arc (Emerging Player)
        {
            "name": "Intel Arc A770",
            "brand": "Intel",
            "model": "Arc A770",
            "price": 349.99,
            "stock": 22,
            "vram": 16,
            "cuda_cores": 4096,
            "image_url": None,
            "description": "Intel's high-end discrete GPU with 16GB VRAM and AV1 encoding.",
        },
        {
            "name": "Intel Arc A750",
            "brand": "Intel",
            "model": "Arc A750",
            "price": 289.99,
            "stock": 25,
            "vram": 8,
            "cuda_cores": 3584,
            "image_url": None,
            "description": "Competitive 1080p gaming with excellent media encoding.",
        },
        # AMD Radeon RX 6000 Series (Value Picks)
        {
            "name": "AMD Radeon RX 6800 XT",
            "brand": "AMD",
            "model": "RX 6800 XT",
            "price": 649.99,
            "stock": 12,
            "vram": 16,
            "cuda_cores": 4608,
            "image_url": None,
            "description": "Previous-gen high-end with 16GB VRAM and great rasterization.",
        },
        {
            "name": "AMD Radeon RX 6700 XT",
            "brand": "AMD",
            "model": "RX 6700 XT",
            "price": 449.99,
            "stock": 18,
            "vram": 12,
            "cuda_cores": 2560,
            "image_url": None,
            "description": "Solid 1440p gaming with 12GB VRAM at good price.",
        },
    ]

    # --- WHITELIST PATTERN (Senior-level) ---
    allowed_cols = [
        'name', 'brand', 'model', 'series', 'vram', 'memory_type',
        'price', 'stock', 'specs', 'description', 'cuda_cores',
        'is_featured', 'image_key', 'image_url'
    ]

    # Insertar GPUs
    inserted_count = 0
    for gpu_data in gpus_data:
        # 1. Verificar si ya existe
        existing = db.query(GPU).filter(GPU.model == gpu_data["model"]).first()
        if existing:
            print(f"[SKIP] El modelo {gpu_data['model']} ya existe.")
            continue

        # 2. Mapear image_url -> image_key si es necesario
        if 'image_url' in gpu_data and 'image_key' not in gpu_data:
            gpu_data['image_key'] = gpu_data['image_url']

        # 3. Filtrar columnas permitidas
        clean_data = {k: v for k, v in gpu_data.items() if k in allowed_cols}

        # 4. Crear instancia
        gpu = GPU(**clean_data)
        db.add(gpu)
        inserted_count += 1

    db.commit()
    print(f"[SUCCESS] Proceso completado: {inserted_count} GPUs nuevas insertadas.")


def main():
    print("[INIT] Iniciando proceso de seed...")

    # Crear tablas
    create_tables()

    # Crear sesión
    db = SessionLocal()

    try:
        # Seed GPUs
        seed_gpus(db)
        print("[DONE] Base de datos lista para produccion.")
    except Exception as e:
        print(f"[ERROR] Fallo durante el seed: {e}")
        db.rollback()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
