from fastapi import APIRouter, UploadFile, HTTPException
from app.core.config import settings
import boto3
from botocore.exceptions import ClientError

router = APIRouter()
s3_client = boto3.client('s3', region_name=settings.S3_REGION)

@router.post("/upload")
async def get_upload_url(filename: str):
    """
    Genera pre-signed URL para que el frontend suba directamente a S3
    """
    try:
        url = s3_client.generate_presigned_url(
            'put_object',
            Params={
                'Bucket': settings.S3_BUCKET,
                'Key': f'original/{filename}',
                'ContentType': 'image/jpeg'
            },
            ExpiresIn=3600  # 1 hora
        )
        
        return {
            "upload_url": url,
            "key": f"original/{filename}"
        }
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/view/{image_key:path}")
async def get_view_url(image_key: str, size: str = "medium"):
    """
    Genera pre-signed URL para descargar/ver imagen
    size: original | medium | thumbnails
    """
    valid_sizes = ["original", "medium", "thumbnails"]
    if size not in valid_sizes:
        raise HTTPException(status_code=400, detail=f"Size must be one of {valid_sizes}")
    
    try:
        # Construir key completo
        full_key = f"{size}/{image_key.split('/')[-1]}"
        
        url = s3_client.generate_presigned_url(
            'get_object',
            Params={
                'Bucket': settings.S3_BUCKET,
                'Key': full_key
            },
            ExpiresIn=3600  # 1 hora
        )
        
        return {
            "view_url": url,
            "expires_in": 3600
        }
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/list")
async def list_images():
    """
    Lista todas las imágenes disponibles
    """
    try:
        response = s3_client.list_objects_v2(
            Bucket=settings.S3_BUCKET,
            Prefix='thumbnails/'
        )
        
        images = []
        for obj in response.get('Contents', []):
            filename = obj['Key'].split('/')[-1]
            images.append({
                "filename": filename,
                "thumbnail_key": f"thumbnails/{filename}",
                "medium_key": f"medium/{filename}",
                "original_key": f"original/{filename}",
                "size": obj['Size'],
                "last_modified": obj['LastModified'].isoformat()
            })
        
        return {"images": images}
    except ClientError as e:
        raise HTTPException(status_code=500, detail=str(e))
