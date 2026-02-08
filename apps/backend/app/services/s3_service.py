import boto3
import uuid
import os
from app.config import settings
from botocore.exceptions import NoCredentialsError

# Cliente S3 Singleton
s3_client = boto3.client(
    "s3",
    aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY"),
    region_name=settings.S3_REGION,
)


def upload_image(file_bytes: bytes, original_filename: str) -> str:
    """
    Sube bytes a S3 en la carpeta /original/ y retorna el Key único.
    """
    # 1. Generar nombre único: "rtx4090.jpg" -> "uuid-v4.jpg"
    ext = original_filename.split(".")[-1]
    unique_filename = f"{uuid.uuid4()}.{ext}"

    # 2. Definir ruta en S3 (Convention)
    s3_key = f"original/{unique_filename}"

    # 3. Subir
    try:
        s3_client.put_object(
            Bucket=settings.S3_BUCKET,
            Key=s3_key,
            Body=file_bytes,
            ContentType=f"image/{ext}",
        )
    except NoCredentialsError:
        # Fallback para desarrollo local si no hay AWS keys
        print("⚠️ [MOCK] No AWS Credentials. Simulando subida a S3.")
        return unique_filename
    except Exception as e:
        print(f"❌ Error S3: {e}")
        raise e

    # 4. Retornar SOLO el nombre del archivo (sin carpeta)
    # El modelo Pydantic construirá la URL completa
    return unique_filename
