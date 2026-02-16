import json
import boto3
import os
from io import BytesIO
from PIL import Image

s3_client = boto3.client('s3')

THUMBNAIL_SIZE = (300, 300)
MEDIUM_SIZE = (800, 800)

def lambda_handler(event, context):
    """
    Trigger: S3 PUT en /original/
    Output: Genera thumbnails en /thumbnails/ y /medium/
    """
    
    # Obtener info del evento S3
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Solo procesar imágenes en /original/
    if not key.startswith('original/'):
        return {'statusCode': 200, 'body': 'Ignored: not in original/'}
    
    try:
        # Descargar imagen original
        response = s3_client.get_object(Bucket=bucket, Key=key)
        image_data = response['Body'].read()
        
        # Abrir con Pillow
        img = Image.open(BytesIO(image_data))
        
        # Convertir a RGB si es PNG con transparencia
        if img.mode in ('RGBA', 'LA', 'P'):
            img = img.convert('RGB')
        
        # Obtener nombre del archivo
        filename = os.path.basename(key)
        
        # Generar thumbnail (300x300)
        thumbnail = img.copy()
        thumbnail.thumbnail(THUMBNAIL_SIZE, Image.LANCZOS)
        thumbnail_buffer = BytesIO()
        thumbnail.save(thumbnail_buffer, format='JPEG', quality=85, optimize=True)
        thumbnail_buffer.seek(0)
        
        s3_client.put_object(
            Bucket=bucket,
            Key=f'thumbnails/{filename}',
            Body=thumbnail_buffer,
            ContentType='image/jpeg'
        )
        
        # Generar imagen mediana (800x800)
        medium = img.copy()
        medium.thumbnail(MEDIUM_SIZE, Image.LANCZOS)
        medium_buffer = BytesIO()
        medium.save(medium_buffer, format='JPEG', quality=90, optimize=True)
        medium_buffer.seek(0)
        
        s3_client.put_object(
            Bucket=bucket,
            Key=f'medium/{filename}',
            Body=medium_buffer,
            ContentType='image/jpeg'
        )
        
        print(f'✅ Processed: {key} → thumbnails/{filename} + medium/{filename}')
        
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Image processed successfully',
                'original': key,
                'thumbnail': f'thumbnails/{filename}',
                'medium': f'medium/{filename}'
            })
        }
        
    except Exception as e:
        print(f'❌ Error processing {key}: {str(e)}')
        raise e
