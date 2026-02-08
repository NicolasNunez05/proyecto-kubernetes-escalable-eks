"""
S3 Service con soporte para LocalStack
"""
import boto3
from botocore.exceptions import ClientError
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)


class S3Service:
    """Servicio para operaciones S3 (compatible con LocalStack)"""
    
    def __init__(self):
        # 🔥 CLAVE: Configurar cliente según el entorno
        client_config = {
            "service_name": "s3",
            "region_name": settings.AWS_REGION,
        }
        
        # ===== LOCALSTACK MODE =====
        if settings.USE_LOCALSTACK:
            logger.info(f"🐳 Using LocalStack at {settings.LOCALSTACK_ENDPOINT}")
            client_config.update({
                "endpoint_url": settings.LOCALSTACK_ENDPOINT,
                "aws_access_key_id": "test",  # LocalStack acepta cualquier valor
                "aws_secret_access_key": "test",
                "use_ssl": False,
            })
        # ===== AWS REAL MODE =====
        else:
            logger.info("☁️ Using real AWS S3")
            if settings.AWS_ACCESS_KEY_ID and settings.AWS_SECRET_ACCESS_KEY:
                client_config.update({
                    "aws_access_key_id": settings.AWS_ACCESS_KEY_ID,
                    "aws_secret_access_key": settings.AWS_SECRET_ACCESS_KEY,
                })
        
        self.client = boto3.client(**client_config)
        self.bucket_name = settings.S3_BUCKET_NAME
        
        # Auto-crear bucket en LocalStack
        if settings.USE_LOCALSTACK:
            self._ensure_bucket_exists()
    
    def _ensure_bucket_exists(self):
        """Crea el bucket si no existe (solo LocalStack)"""
        try:
            self.client.head_bucket(Bucket=self.bucket_name)
            logger.info(f"✅ Bucket '{self.bucket_name}' exists")
        except ClientError:
            logger.info(f"📦 Creating bucket '{self.bucket_name}'...")
            self.client.create_bucket(Bucket=self.bucket_name)
    
    def upload_file(self, file_content: bytes, key: str, content_type: str = "image/jpeg") -> str:
        """Sube un archivo a S3"""
        try:
            self.client.put_object(
                Bucket=self.bucket_name,
                Key=key,
                Body=file_content,
                ContentType=content_type
            )
            
            # Generar URL
            if settings.USE_LOCALSTACK:
                # LocalStack formato
                url = f"{settings.LOCALSTACK_ENDPOINT}/{self.bucket_name}/{key}"
            else:
                # AWS formato
                url = f"https://{self.bucket_name}.s3.{settings.AWS_REGION}.amazonaws.com/{key}"
            
            logger.info(f"✅ Uploaded: {key}")
            return url
        
        except ClientError as e:
            logger.error(f"❌ Upload failed: {e}")
            raise
    
    def get_presigned_url(self, key: str, expiration: int = 3600) -> str:
        """Genera URL prefirmada"""
        try:
            url = self.client.generate_presigned_url(
                'get_object',
                Params={'Bucket': self.bucket_name, 'Key': key},
                ExpiresIn=expiration
            )
            return url
        except ClientError as e:
            logger.error(f"❌ Failed to generate presigned URL: {e}")
            raise


# Singleton
s3_service = S3Service()
