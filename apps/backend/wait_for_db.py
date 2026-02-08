"""
Script para esperar a que PostgreSQL esté listo antes de iniciar el backend.
Evita errores de conexión al inicio del docker-compose.
"""
import time
import sys
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError
from app.core.config import settings

def wait_for_db(max_retries: int = 30, retry_interval: int = 2):
    """
    Intenta conectarse a la base de datos con reintentos.
    
    Args:
        max_retries: Número máximo de intentos
        retry_interval: Segundos entre intentos
    """
    engine = create_engine(settings.DATABASE_URL)
    
    for attempt in range(1, max_retries + 1):
        try:
            print(f"🔄 Intento {attempt}/{max_retries}: Conectando a PostgreSQL...")
            connection = engine.connect()
            connection.close()
            print("✅ PostgreSQL está listo!")
            return True
        except OperationalError as e:
            if attempt == max_retries:
                print(f"❌ Error: No se pudo conectar a PostgreSQL después de {max_retries} intentos")
                print(f"   Detalles: {e}")
                sys.exit(1)
            print(f"⏳ PostgreSQL no está listo. Reintentando en {retry_interval}s...")
            time.sleep(retry_interval)
    
    return False

if __name__ == "__main__":
    print("🚀 Esperando a que PostgreSQL esté disponible...")
    wait_for_db()
