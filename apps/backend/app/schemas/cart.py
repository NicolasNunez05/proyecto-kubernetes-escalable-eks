from pydantic import BaseModel
from typing import List, Optional
from app.schemas.gpu import GPU  # Importamos el esquema de GPU para anidar la respuesta


class CartItemCreate(BaseModel):
    gpu_id: int
    quantity: int = 1


class CartItem(BaseModel):
    id: int
    gpu_id: int
    quantity: int
    gpu: GPU  # Esto permite ver los detalles de la tarjeta en el carrito

    class Config:
        from_attributes = True


class CartResponse(BaseModel):
    items: List[CartItem]
    total: float


class CartMigrateRequest(BaseModel):
    session_id: str
