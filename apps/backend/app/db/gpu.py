from pydantic import BaseModel, Field, computed_field  # ✅ Importar computed_field
from typing import Optional, Dict, Any
from datetime import datetime
from app.config import settings


# Base común
class GPUBase(BaseModel):
    model: str
    brand: str
    series: Optional[str] = None
    vram: int = Field(..., gt=0, description="VRAM in GB")
    memory_type: Optional[str] = None
    price: float = Field(..., gt=0)
    stock: int = Field(default=0, ge=0)
    specs: Dict[str, Any] = Field(default_factory=dict)
    is_featured: bool = False


class GPUCreate(GPUBase):
    image_key: Optional[str] = None  # Admin envía esto al crear


class GPU(GPUBase):
    id: int
    image_key: Optional[str] = None
    created_at: datetime

    class Config:
        from_attributes = True

    # ✅ SENIOR WAY: Computed Fields
    # Esto agrega 'image_url' y 'thumbnail_url' al JSON de respuesta automáticamente

    @computed_field
    @property
    def image_url(self) -> Optional[str]:
        if not self.image_key:
            return None
        return f"https://{settings.S3_BUCKET}.s3.{settings.S3_REGION}.amazonaws.com/original/{self.image_key}"

    @computed_field
    @property
    def thumbnail_url(self) -> Optional[str]:
        if not self.image_key:
            return None
        return f"https://{settings.S3_BUCKET}.s3.{settings.S3_REGION}.amazonaws.com/thumbnails/{self.image_key}"
