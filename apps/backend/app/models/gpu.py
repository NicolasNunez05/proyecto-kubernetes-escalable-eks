"""
🎯 QUÉ HACE: Define estructura de requests/responses
📍 CUÁNDO SE USA: Validación automática de FastAPI
"""
from pydantic import BaseModel, Field
from typing import Optional
from datetime import date

class GPUBase(BaseModel):
    model: str = Field(..., max_length=100)
    brand: str = Field(..., max_length=50)
    series: Optional[str] = None
    vram: int = Field(..., ge=2, le=128)  # Entre 2GB y 128GB
    price: float = Field(..., ge=0)
    stock: int = Field(default=0, ge=0)

class GPUCreate(GPUBase):
    """Para POST /api/admin/gpus"""
    image_key: Optional[str] = None  # ✅ Solo guardamos key, no URL completa

class GPUResponse(GPUBase):
    """Para GET /api/gpus"""
    id: int
    image_url: str  # ✅ Generada por @property en servicio
    thumbnail_url: str  # ✅ Convention: /thumbnails/{image_key}
    created_at: datetime
    
    class Config:
        orm_mode = True