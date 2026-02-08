from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form, status
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.db.models import GPU as GPUModel
from app.models.gpu import GPUCreate, GPU as GPUSchema
from app.services.s3_service import upload_image  # ¡Vamos a crear esto!
import json
from typing import Optional

router = APIRouter()

# ⚠️ NOTA: En un caso real, aquí iría: dependencies=[Depends(get_current_admin_user)]
# Para el portfolio inicial, lo dejamos abierto o simulado para facilitar pruebas.


@router.post("/gpus", response_model=GPUSchema, status_code=status.HTTP_201_CREATED)
async def create_gpu(
    # Recibimos datos como Form porque viene una imagen adjunta (multipart/form-data)
    model: str = Form(...),
    brand: str = Form(...),
    price: float = Form(...),
    vram: int = Form(...),
    stock: int = Form(0),
    file: UploadFile = File(...),  # La imagen es obligatoria al crear
    specs: str = Form("{}"),  # JSON stringificado
    db: Session = Depends(get_db),
):
    """
    Crea una GPU y sube su imagen a S3 (carpeta /original)
    """
    # 1. Subir imagen a S3 y obtener el KEY único (ej: "uuid-123.jpg")
    # No guardamos la URL, solo el key.
    try:
        file_content = await file.read()
        image_key = upload_image(file_content, file.filename)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error subiendo imagen: {str(e)}")

    # 2. Parsear specs (vienen como string JSON desde frontend/postman)
    try:
        specs_dict = json.loads(specs)
    except json.JSONDecodeError:
        specs_dict = {}

    # 3. Crear registro en DB
    new_gpu = GPUModel(
        model=model,
        brand=brand,
        price=price,
        vram=vram,
        stock=stock,
        specs=specs_dict,
        image_key=image_key,  # 👈 Aquí está la magia de la convención
    )

    db.add(new_gpu)
    db.commit()
    db.refresh(new_gpu)

    return new_gpu
