from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.db.database import get_db

# Importamos el MODELO de base de datos (SQLAlchemy)
from app.models.gpu import GPU as GPUModel

# Importamos los ESQUEMAS de validación (Pydantic)
from app.schemas.gpu import GPU as GPUSchema, GPUCreate, GPUUpdate

router = APIRouter()

# -----------------------------------------------------------------------------
# RUTAS PÚBLICAS (GET)
# -----------------------------------------------------------------------------


@router.get("/", response_model=List[GPUSchema])
def list_gpus(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Listar GPUs disponibles en la tienda.
    """
    # Consulta simple a la base de datos
    gpus = db.query(GPUModel).offset(skip).limit(limit).all()
    return gpus


@router.get("/{gpu_id}", response_model=GPUSchema)
def get_gpu(gpu_id: int, db: Session = Depends(get_db)):
    """
    Obtener el detalle de una GPU específica.
    """
    gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not gpu:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="GPU no encontrada"
        )
    return gpu


# -----------------------------------------------------------------------------
# RUTAS ADMINISTRATIVAS (POST, PUT, DELETE)
# Nota: Para este MVP, quitamos la dependencia de 'get_current_admin'
# para que puedas probarlas desde Swagger sin loguearte.
# -----------------------------------------------------------------------------


@router.post("/", response_model=GPUSchema, status_code=status.HTTP_201_CREATED)
def create_gpu(gpu_in: GPUCreate, db: Session = Depends(get_db)):
    """
    Crear una nueva GPU.
    """
    # Convertimos el esquema Pydantic a Modelo SQLAlchemy
    # model_dump() convierte el objeto a un diccionario
    db_gpu = GPUModel(**gpu_in.model_dump())

    db.add(db_gpu)
    db.commit()
    db.refresh(db_gpu)
    return db_gpu


@router.put("/{gpu_id}", response_model=GPUSchema)
def update_gpu(gpu_id: int, gpu_in: GPUUpdate, db: Session = Depends(get_db)):
    """
    Actualizar una GPU existente.
    """
    db_gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not db_gpu:
        raise HTTPException(status_code=404, detail="GPU no encontrada")

    # Actualizamos solo los campos que vienen con valor (exclude_unset=True)
    update_data = gpu_in.model_dump(exclude_unset=True)

    for field, value in update_data.items():
        setattr(db_gpu, field, value)

    db.commit()
    db.refresh(db_gpu)
    return db_gpu


@router.delete("/{gpu_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_gpu(gpu_id: int, db: Session = Depends(get_db)):
    """
    Eliminar una GPU.
    """
    db_gpu = db.query(GPUModel).filter(GPUModel.id == gpu_id).first()
    if not db_gpu:
        raise HTTPException(status_code=404, detail="GPU no encontrada")

    db.delete(db_gpu)
    db.commit()
    return None
