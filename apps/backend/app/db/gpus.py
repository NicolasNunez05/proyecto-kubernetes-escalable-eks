# apps/backend/app/api/routes/gpus.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.db.session import get_db
from app.db.models import GPU as GPUModel
from app.models.gpu import GPU as GPUSchema

router = APIRouter()

@router.get("/", response_model=List[GPUSchema])
def read_gpus(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Obtiene lista de GPUs con paginación
    """
    gpus = db.query(GPUModel).offset(skip).limit(limit).all()
    # Pydantic y nuestra lógica en __init__ se encargan de las URLs
    return gpus
