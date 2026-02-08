"""
🎯 QUÉ HACE: Redimensiona imágenes automáticamente
📍 CUÁNDO SE USA: Trigger cuando se sube a S3 /original/
🚫 NO TOCA LA BASE DE DATOS (Convention over Configuration)
"""
import boto3
import io
from PIL import Image
from urllib.parse import unquote_plus # 👈 IMPORTANTE: Para leer nombres con espacios

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # Extraer info del evento S3 y decodificar el nombre (ej: "foto+1.jpg" -> "foto 1.jpg")
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = unquote_plus(event['Records'][0]['s3']['object']['key'])
    
    # Solo procesar /original/
    if not key.startswith('original/'):
        print(f"Skipping: {key}")
        return {'statusCode': 200, 'body': 'Skipped'}
    
    try:
        # Descargar imagen original
        print(f"Downloading: {key}")
        obj = s3.get_object(Bucket=bucket, Key=key)
        img = Image.open(io.BytesIO(obj['Body'].read()))
        
        # ✅ Manejar PNGs transparentes (Evita fondo negro)
        if img.mode in ('RGBA', 'P', 'LA'):
            background = Image.new('RGB', img.size, (255, 255, 255))
            if img.mode == 'RGBA':
                background.paste(img, mask=img.split()[3])
            else:
                background.paste(img)
            img = background
        
        # Resize inteligente (Lanczos es el mejor filtro)
        img.thumbnail((400, 400), Image.Resampling.LANCZOS)
        
        # Guardar en buffer (Memoria RAM)
        buffer = io.BytesIO()
        img.save(buffer, format='JPEG', quality=85, optimize=True)
        buffer.seek(0)
        
        # ✅ Guardar en /thumbnails/ con MISMO NOMBRE
        thumb_key = key.replace('original/', 'thumbnails/')
        
        print(f"Uploading to: {thumb_key}")
        s3.put_object(
            Bucket=bucket,
            Key=thumb_key,
            Body=buffer.getvalue(),
            ContentType='image/jpeg',
            CacheControl='max-age=31536000'  # 1 año
        )
        
        return {'statusCode': 200, 'body': f'Created {thumb_key}'}
        
    except Exception as e:
        print(f"Error processing {key}: {str(e)}")
        raise e