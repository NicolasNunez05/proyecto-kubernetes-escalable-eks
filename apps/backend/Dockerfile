# Base stage con Python 3.11
FROM python:3.11-slim AS base

# Variables de entorno para Python
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    HOME=/home/appuser

WORKDIR /app

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# --- FIX 1: Instalar PyTorch CPU-Only PRIMERO ---
# Esto evita descargar 3-4GB de drivers Nvidia (CUDA) innecesarios.
# Lo hacemos antes de requirements.txt para aprovechar caché de Docker.
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Copiar requirements
COPY requirements.txt .

# Instalar resto de dependencias Python (sentence-transformers detectará torch ya instalado)
RUN pip install --no-cache-dir -r requirements.txt

# --- FIX 2: Crear usuario no-root (ID 1000) ---
# Creamos usuario y grupo para evitar problemas de permisos y seguridad
RUN groupadd -r appuser && useradd -r -g appuser -u 1000 appuser \
    && mkdir -p /home/appuser/.cache \
    && chown -R appuser:appuser /home/appuser

# Copiar código fuente y dar permisos al usuario
COPY . .
RUN chown -R appuser:appuser /app

# Usar el usuario creado
USER 1000

# Exponer puerto
EXPOSE 8000

# Script de inicio
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
