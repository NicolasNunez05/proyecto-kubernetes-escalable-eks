import os
import sys
import pytest
import asyncio
from unittest.mock import MagicMock, patch, AsyncMock

# --- 1. CONFIGURACIÓN DE ENTORNO ---
os.environ["DATABASE_URL"] = "sqlite:///:memory:"
os.environ["REDIS_URL"] = "redis://localhost:6379/0"
os.environ["SECRET_KEY"] = "super-secret-testing-key-12345"
os.environ["S3_BUCKET_NAME"] = "test-bucket"
os.environ["AWS_ACCESS_KEY_ID"] = "testing"
os.environ["AWS_SECRET_ACCESS_KEY"] = "testing"
os.environ["AWS_REGION"] = "us-east-1"
os.environ["TESTING"] = "true"

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool


# --- 2. MOCK DE REDIS (UNIVERSAL) ---
@pytest.fixture(scope="session", autouse=True)
def mock_redis_global():
    """
    Simula Redis cubriendo todos los casos de conexión:
    - redis.Redis()
    - redis.from_url()
    - Soporte asíncrono (await ping())
    """
    # Creamos un Mock que funciona tanto síncrono como asíncrono
    redis_instance = MagicMock()
    redis_instance.ping.return_value = True

    # Si la app usa await redis.ping(), devolvemos un corutina que da True
    async def async_ping():
        return True

    redis_instance.ping.side_effect = None  # Reset side effects

    # Truco: Si se llama como función normal devuelve True, si se espera, funciona también.
    # Pero para simplificar, parcheamos ambas clases.

    with patch("redis.Redis", return_value=redis_instance) as mock_redis_cls, patch(
        "redis.from_url", return_value=redis_instance
    ) as mock_from_url:

        yield redis_instance


# --- 3. BASE DE DATOS EN MEMORIA ---
@pytest.fixture(scope="function")
def db_session():
    from app.db.database import Base

    # Importamos modelos
    from app.models.gpu import GPU

    SQLALCHEMY_DATABASE_URL = "sqlite:///:memory:"
    engine = create_engine(
        SQLALCHEMY_DATABASE_URL,
        connect_args={"check_same_thread": False},
        poolclass=StaticPool,
    )
    TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

    Base.metadata.create_all(bind=engine)

    session = TestingSessionLocal()
    try:
        yield session
    finally:
        session.close()
        Base.metadata.drop_all(bind=engine)


# --- 4. CLIENTE FASTAPI ---
@pytest.fixture(scope="function")
def client(db_session):
    from app.main import app
    from app.db.database import get_db

    def override_get_db():
        try:
            yield db_session
        finally:
            pass

    app.dependency_overrides[get_db] = override_get_db

    with TestClient(app) as test_client:
        yield test_client

    app.dependency_overrides.clear()


# --- 5. DATOS DE EJEMPLO ---
@pytest.fixture
def sample_gpu_data():
    return {
        "name": "NVIDIA RTX 4090",
        "brand": "ASUS",
        "model": "ROG Strix",
        "price": 1599.99,
        "vram": 24,
        "stock": 10,
        "description": "Top gaming GPU",
        "image_url": "https://example.com/rtx4090.jpg",
    }
