"""
Production-grade configuration for EKS with IRSA
Features:
- IRSA (IAM Roles for Service Accounts) - No hardcoded credentials
- External Secrets Operator integration
- Pre-signed URLs for S3
- AI/RAG with Groq
"""
import os
from functools import lru_cache
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Settings optimized for IRSA (IAM Roles for Service Accounts)"""
    
    # ===== AWS Configuration =====
    # IRSA maneja credenciales automáticamente en EKS
    # En desarrollo local, usar AWS CLI credentials
    AWS_REGION: str = os.getenv("AWS_REGION", "us-east-1")
    S3_BUCKET_NAME: str = os.getenv(
        "S3_BUCKET_NAME", 
        "gpuchile-images-dev-592451843842"  # Actualizado al bucket real
    )
    
    # Alias para compatibilidad con código que use S3_BUCKET
    @property
    def S3_BUCKET(self) -> str:
        return self.S3_BUCKET_NAME
    
    @property
    def S3_REGION(self) -> str:
        return self.AWS_REGION
    
    # Credenciales explícitas (solo para desarrollo local)
    # En EKS con IRSA, estos se ignoran
    AWS_ACCESS_KEY_ID: str = os.getenv("AWS_ACCESS_KEY_ID", "")
    AWS_SECRET_ACCESS_KEY: str = os.getenv("AWS_SECRET_ACCESS_KEY", "")
    
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
    SECRET_KEY: str = os.getenv(
        "SECRET_KEY", 
        "dev-secret-key-change-in-production"
    )
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    
    # Alias para compatibilidad
    @property
    def JWT_SECRET(self) -> str:
        return self.SECRET_KEY
    
    @property
    def JWT_ALGORITHM(self) -> str:
        return self.ALGORITHM
    
    JWT_EXPIRATION: int = 60 * 24 * 7  # 7 días
    
    # ===== AI Configuration =====
    GROQ_API_KEY: str = os.getenv("GROQ_API_KEY", "")
    
    # ===== Environment =====
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "production")
    
    # ===== Rate Limiting =====
    RATE_LIMIT_ENABLED: bool = os.getenv("RATE_LIMIT_ENABLED", "true").lower() == "true"
    
    class Config:
        case_sensitive = True
        env_file = ".env"


@lru_cache()
def get_settings() -> Settings:
    """
    Singleton para obtener settings (cached)
    Se carga una sola vez y se reutiliza en toda la app
    """
    return Settings()


# Instancia global
settings = get_settings()


# ===== Validaciones en tiempo de ejecución =====
def validate_settings():
    """Valida configuración crítica al iniciar la app"""
    errors = []
    
    # Validar S3
    if not settings.S3_BUCKET_NAME:
        errors.append("❌ S3_BUCKET_NAME no está configurado")
    
    # Validar Database
    if "localhost" in settings.DATABASE_URL and settings.ENVIRONMENT == "production":
        errors.append("⚠️ WARNING: Usando localhost en producción")
    
    # Validar Secret Key en producción
    if settings.ENVIRONMENT == "production" and "dev-secret" in settings.SECRET_KEY:
        errors.append("❌ CRITICAL: Usando SECRET_KEY por defecto en producción")
    
    if errors:
        print("\n" + "="*60)
        print("⚠️  CONFIGURATION WARNINGS/ERRORS")
        print("="*60)
        for error in errors:
            print(error)
        print("="*60 + "\n")
        
        # Si hay errores críticos (❌), no continuar
        if any("CRITICAL" in e for e in errors):
            raise ValueError("Configuration errors detected. Fix before deploying.")
    else:
        print("✅ Configuration validated successfully")

