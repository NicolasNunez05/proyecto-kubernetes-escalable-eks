"""
S3 Service with IRSA (IAM Roles for Service Accounts)
Production-grade implementation without hardcoded credentials
"""
import boto3
import uuid
from botocore.exceptions import ClientError
from app.core.config import settings
import logging


logger = logging.getLogger(__name__)


class S3Service:
    """
    Servicio S3 production-grade con IRSA.
    
    En EKS, el ServiceAccount inyecta automáticamente:
    - AWS_ROLE_ARN (via annotation)
    - AWS_WEB_IDENTITY_TOKEN_FILE (via projected volume)
    
    boto3 usa el default credential chain:
    1. Environment variables
    2. Web Identity Token (IRSA)
    3. Instance metadata (ECS/EC2)
    """
    
    def __init__(self):
        logger.info(f"🚀 Initializing S3 client for region: {settings.AWS_REGION}")
        
        # ✅ Cliente puro - sin credenciales explícitas
        # IRSA inyecta credenciales vía AWS STS AssumeRoleWithWebIdentity
        self.client = boto3.client(
            service_name="s3",
            region_name=settings.AWS_REGION
            # NO endpoint_url, NO aws_access_key_id, NO aws_secret_access_key
        )
        
        self.bucket_name = settings.S3_BUCKET_NAME
        logger.info(f"✅ S3 client initialized for bucket: {self.bucket_name}")
    
    def upload_file(
        self,
        file_content: bytes,
        key: str,
        content_type: str = "image/jpeg"
    ) -> str:
        """
        Sube un archivo a S3 y retorna la URL pública.
        
        Args:
            file_content: Contenido binario del archivo
            key: Path del objeto en S3 (e.g., "original/uuid-image.jpg")
            content_type: MIME type del archivo
        
        Returns:
            str: URL pública del objeto (si bucket es público) o path
        
        Raises:
            ClientError: Si falla el upload
        """
        try:
            self.client.put_object(
                Bucket=self.bucket_name,
                Key=key,
                Body=file_content,
                ContentType=content_type
            )
            
            # URL pública (asume bucket público o con Lambda presigner)
            url = f"https://{self.bucket_name}.s3.{settings.AWS_REGION}.amazonaws.com/{key}"
            
            logger.info(f"✅ Uploaded successfully: {key}")
            return url
        
        except ClientError as e:
            logger.error(f"❌ Upload failed for key '{key}': {e}")
            raise
    
    def upload_image(self, file_content: bytes, filename: str) -> str:
        """
        Sube imagen generando key único UUID-based.
        
        Args:
            file_content: Contenido binario de la imagen
            filename: Nombre original del archivo
        
        Returns:
            str: Key único del objeto en S3
        """
        # Generar key único: original/uuid-filename.ext
        file_extension = filename.split('.')[-1] if '.' in filename else 'jpg'
        unique_key = f"original/{uuid.uuid4()}-{filename}"
        
        self.upload_file(
            file_content=file_content,
            key=unique_key,
            content_type=f"image/{file_extension}"
        )
        
        return unique_key
    
    def get_presigned_url(self, key: str, expiration: int = 3600) -> str:
        """
        Genera URL prefirmada para acceso temporal a objetos privados.
        
        Args:
            key: Path del objeto en S3
            expiration: Segundos de validez (default: 1 hora)
        
        Returns:
            str: URL prefirmada con firma temporal
        
        Raises:
            ClientError: Si el objeto no existe o falla la operación
        """
        try:
            url = self.client.generate_presigned_url(
                ClientMethod='get_object',
                Params={
                    'Bucket': self.bucket_name,
                    'Key': key
                },
                ExpiresIn=expiration
            )
            
            logger.info(f"✅ Generated presigned URL for: {key}")
            return url
        
        except ClientError as e:
            logger.error(f"❌ Failed to generate presigned URL for '{key}': {e}")
            raise
    
    def delete_file(self, key: str) -> bool:
        """
        Elimina un objeto de S3.
        
        Args:
            key: Path del objeto en S3
        
        Returns:
            bool: True si se eliminó exitosamente
        """
        try:
            self.client.delete_object(
                Bucket=self.bucket_name,
                Key=key
            )
            logger.info(f"🗑️ Deleted successfully: {key}")
            return True
        
        except ClientError as e:
            logger.error(f"❌ Delete failed for '{key}': {e}")
            return False


# Singleton instance
s3_service = S3Service()
