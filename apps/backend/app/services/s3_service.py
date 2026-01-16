"""
🎯 QUÉ HACE: Sube imágenes a S3, genera key único
📍 CUÁNDO SE USA: POST /api/admin/gpus/{id}/upload
"""
import boto3
import uuid
from app.config import settings

s3_client = boto3.client('s3', region_name=settings.S3_REGION)

def upload_image(file_bytes: bytes, original_filename: str) -> str:
    """
    Sube imagen a S3 /original/ con UUID
    
    Returns:
        image_key: "rtx4090-abc123.jpg" (solo filename, no URL)
    """
    # Generar key único
    extension = original_filename.split('.')[-1]
    image_key = f"{uuid.uuid4()}.{extension}"
    
    # Upload a /original/
    s3_client.put_object(
        Bucket=settings.S3_BUCKET,
        Key=f"original/{image_key}",
        Body=file_bytes,
        ContentType=f"image/{extension}"
    )
    
    # ✅ NO guardamos URL completa, solo el key
    # Lambda creará /thumbnails/{image_key} automáticamente
    return image_key

def get_image_url(image_key: str, is_thumbnail: bool = False) -> str:
    """
    Construye URL por convención
    ✅ Convention over Configuration
    """
    folder = "thumbnails" if is_thumbnail else "original"
    return f"https://{settings.S3_BUCKET}.s3.{settings.S3_REGION}.amazonaws.com/{folder}/{image_key}"