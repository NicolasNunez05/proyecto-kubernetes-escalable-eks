"""
🎯 QUÉ HACE: Centraliza todas las variables ENV
📍 CUÁNDO SE USA: Importado por main.py y services
"""
import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Database (de External Secrets en K8s)
    DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://localhost/gpuchile_dev")
    
    # Redis (opcional para rate limiting)
    REDIS_URL: str = os.getenv("REDIS_URL", "redis://localhost:6379")
    
    # S3
    S3_BUCKET: str = os.getenv("S3_BUCKET", "gpuchile-images-prod")
    S3_REGION: str = os.getenv("AWS_REGION", "us-east-1")
    
    # JWT
    JWT_SECRET: str = os.getenv("JWT_SECRET", "dev-secret-change-in-prod")
    JWT_ALGORITHM: str = "HS256"
    JWT_EXPIRATION: int = 60 * 24 * 7  # 7 días
    
    # Rate Limiting
    RATE_LIMIT_ENABLED: bool = True
    
    class Config:
        env_file = ".env"

settings = Settings()