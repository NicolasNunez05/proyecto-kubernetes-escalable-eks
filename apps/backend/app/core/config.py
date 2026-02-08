"""
Configuración centralizada con soporte para LocalStack
"""
import os
from functools import lru_cache
from typing import Optional
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Settings con detección automática de LocalStack"""
    
    # ===== AWS Configuration =====
    AWS_REGION: str = os.getenv("AWS_REGION", "us-east-1")
    S3_BUCKET_NAME: str = os.getenv("S3_BUCKET_NAME", "gpuchile-dev")
    AWS_ACCESS_KEY_ID: Optional[str] = os.getenv("AWS_ACCESS_KEY_ID")
    AWS_SECRET_ACCESS_KEY: Optional[str] = os.getenv("AWS_SECRET_ACCESS_KEY")
    
    # ===== LocalStack Detection =====
    USE_LOCALSTACK: bool = os.getenv("USE_LOCALSTACK", "false").lower() == "true"
    LOCALSTACK_ENDPOINT: str = os.getenv("LOCALSTACK_ENDPOINT", "http://localstack:4566")
    
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
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")
    
    @property
    def is_local(self) -> bool:
        """Detecta si estamos en modo local (LocalStack o Docker Compose)"""
        return self.USE_LOCALSTACK or self.ENVIRONMENT == "development"
    
    @property
    def aws_endpoint_url(self) -> Optional[str]:
        """Retorna el endpoint de AWS solo si usamos LocalStack"""
        if self.USE_LOCALSTACK:
            return self.LOCALSTACK_ENDPOINT
        return None
    
    class Config:
        case_sensitive = True
        env_file = ".env"


@lru_cache()
def get_settings() -> Settings:
    """Singleton para obtener settings (cached)"""
    return Settings()


# Instancia global
settings = get_settings()
