"""
Production-grade configuration for EKS with IRSA
"""
import os
from functools import lru_cache
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Settings optimized for IRSA (IAM Roles for Service Accounts)"""
    
    # ===== AWS Configuration =====
    # Solo región y bucket - IRSA maneja credenciales automáticamente
    AWS_REGION: str = os.getenv("AWS_REGION", "us-east-1")
    S3_BUCKET_NAME: str = os.getenv("S3_BUCKET_NAME", "gpuchile-images-dev-nicolas-2026")
    
    # ===== Database =====
    DATABASE_URL: str = os.getenv(
        "DATABASE_URL",
        "postgresql://postgres:postgres123@db:5432/gpuchile"
    )
    
    # ===== Redis =====
    REDIS_URL: str = os.getenv(
        "REDIS_URL",
        "redis://:redis123@redis:6379/0"
    )
    
    # ===== Security =====
    SECRET_KEY: str = os.getenv("SECRET_KEY", "dev-secret-key-change-in-production")
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # ===== Environment =====
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "production")
    
    class Config:
        case_sensitive = True
        env_file = ".env"


@lru_cache()
def get_settings() -> Settings:
    """Singleton para obtener settings (cached)"""
    return Settings()


# Instancia global
settings = get_settings()
