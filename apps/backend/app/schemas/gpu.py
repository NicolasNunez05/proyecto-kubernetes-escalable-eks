from pydantic import BaseModel, Field, computed_field
from typing import Optional, Dict, Any
from datetime import datetime

# --- CLASE BASE (Datos compartidos) ---
class GPUBase(BaseModel):
    model: str
    brand: str
    series: Optional[str] = None
    vram: int
    memory_type: Optional[str] = None
    price: float
    stock: int
    is_featured: bool = False
    specs: Dict[str, Any] = Field(default_factory=dict)

# --- CLASE PARA CREAR (Input) ---
class GPUCreate(GPUBase):
    image_key: Optional[str] = None

# --- CLASE PARA ACTUALIZAR (FALTABA ESTA) ---
class GPUUpdate(BaseModel):
    # Todos opcionales para permitir actualizaciones parciales
    model: Optional[str] = None
    brand: Optional[str] = None
    series: Optional[str] = None
    vram: Optional[int] = None
    memory_type: Optional[str] = None
    price: Optional[float] = None
    stock: Optional[int] = None
    is_featured: Optional[bool] = None
    specs: Optional[Dict[str, Any]] = None
    image_key: Optional[str] = None

# --- CLASE PARA RESPONDER (Output Swagger) ---
class GPU(GPUBase):
    id: int
    created_at: datetime
    
    @computed_field
    @property
    def image_url(self) -> Optional[str]:
        if hasattr(self, 'image_key') and self.image_key:
             return f"https://gpuchile-public.s3.amazonaws.com/{self.image_key}"
        return "https://gpuchile-public.s3.amazonaws.com/assets/gpu_placeholder.png"

    class Config:
        from_attributes = True