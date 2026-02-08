from pydantic import BaseModel, Field, computed_field
from typing import Optional, Dict, Any
from datetime import datetime
from app.core.config import settings

# Base común
class GPUBase(BaseModel):
    name: str 
    model: str
    brand: str
    vram: int = Field(..., gt=0, description="VRAM in GB")
    price: float = Field(..., gt=0)
    stock: int = Field(default=0, ge=0)
    cuda_cores: Optional[int] = None
    image_url: Optional[str] = None 
    description: Optional[str] = None
    is_featured: bool = False

# Lo que recibimos al crear (POST)
class GPUCreate(GPUBase):
    pass

# --- LO QUE FALTABA ---
# Lo que recibimos al actualizar (PUT/PATCH) - Todos los campos opcionales
class GPUUpdate(BaseModel):
    name: Optional[str] = None
    model: Optional[str] = None
    brand: Optional[str] = None
    vram: Optional[int] = None
    price: Optional[float] = None
    stock: Optional[int] = None
    cuda_cores: Optional[int] = None
    image_url: Optional[str] = None
    description: Optional[str] = None
    is_featured: Optional[bool] = None

# Respuesta para URLs presignadas de S3
class PresignedURLResponse(BaseModel):
    upload_url: str
    file_key: str
# ----------------------

# Lo que devolvemos al cliente (GET)
class GPU(GPUBase): 
    id: int
    
    class Config:
        from_attributes = True