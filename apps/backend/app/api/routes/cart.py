from fastapi import APIRouter, Depends, HTTPException, status, Header
from sqlalchemy.orm import Session
from typing import Optional
import redis
import json

from app.db.database import get_db
from app.models.cart import Cart
from app.models.gpu import GPU
from app.models.user import User
from app.schemas.cart import CartItemCreate, CartResponse, CartItem, CartMigrateRequest
from app.core.config import settings

router = APIRouter()

# Cliente Redis
try:
    redis_client = redis.from_url(settings.REDIS_URL, decode_responses=True)
except Exception:
    redis_client = None

def get_redis_cart_key(session_id: str) -> str:
    return f"cart:{session_id}"

def get_optional_current_user(
    authorization: Optional[str] = Header(None),
    db: Session = Depends(get_db)
) -> Optional[User]:
    if not authorization or not authorization.startswith("Bearer "):
        return None
    try:
        from app.core.security import decode_access_token
        token = authorization.replace("Bearer ", "")
        payload = decode_access_token(token)
        if payload is None: return None
        user_id: int = payload.get("sub")
        if user_id is None: return None
        return db.query(User).filter(User.id == int(user_id)).first()
    except Exception:
        return None

@router.post("/", status_code=status.HTTP_201_CREATED)
def add_to_cart(
    item: CartItemCreate,
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    gpu = db.query(GPU).filter(GPU.id == item.gpu_id).first()
    if not gpu:
        raise HTTPException(status_code=404, detail="GPU not found")
    
    if gpu.stock < item.quantity:
        raise HTTPException(status_code=400, detail=f"Stock insuficiente. Disponible: {gpu.stock}")
    
    # Usuario Autenticado (Postgres)
    if current_user:
        existing_item = db.query(Cart).filter(
            Cart.user_id == current_user.id,
            Cart.gpu_id == item.gpu_id
        ).first()
        
        if existing_item:
            existing_item.quantity += item.quantity
        else:
            cart_item = Cart(user_id=current_user.id, gpu_id=item.gpu_id, quantity=item.quantity)
            db.add(cart_item)
        db.commit()
        return {"message": "Agregado al carrito (DB)"}
    
    # Usuario Anónimo (Redis)
    else:
        if not session_id or not redis_client:
            raise HTTPException(status_code=503, detail="Sistema de sesión no disponible")
        
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        cart = json.loads(cart_data) if cart_data else {}
        
        gpu_id_str = str(item.gpu_id)
        if gpu_id_str in cart:
            cart[gpu_id_str] += item.quantity
        else:
            cart[gpu_id_str] = item.quantity
        
        redis_client.setex(cart_key, 604800, json.dumps(cart))
        return {"message": "Agregado al carrito (Redis)"}

@router.get("/", response_model=CartResponse)
def get_cart(
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    # Autenticado
    if current_user:
        cart_items = db.query(Cart).filter(Cart.user_id == current_user.id).all()
        items = []
        total = 0.0
        for ci in cart_items:
            if ci.gpu:
                items.append(CartItem(
                    id=ci.id,
                    gpu_id=ci.gpu_id,
                    quantity=ci.quantity,
                    gpu=ci.gpu
                ))
                total += ci.gpu.price * ci.quantity
        return CartResponse(items=items, total=total)
    
    # Anónimo (Redis)
    else:
        if not session_id or not redis_client:
            return CartResponse(items=[], total=0.0)
        
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        
        if not cart_data:
            return CartResponse(items=[], total=0.0)
        
        cart = json.loads(cart_data)
        items = []
        total = 0.0
        
        for gpu_id_str, quantity in cart.items():
            gpu = db.query(GPU).filter(GPU.id == int(gpu_id_str)).first()
            if gpu:
                items.append(CartItem(
                    # TRUCO: Usamos el gpu_id como id del item para poder borrarlo luego
                    id=gpu.id, 
                    gpu_id=gpu.id,
                    quantity=quantity,
                    gpu=gpu
                ))
                total += gpu.price * quantity
        
        return CartResponse(items=items, total=total)

# ✅ AQUÍ ESTABA EL PROBLEMA, AGREGADA LÓGICA REDIS
@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
def remove_from_cart(
    item_id: int,
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    # Autenticado (Borrar de Postgres por ID de la fila)
    if current_user:
        db.query(Cart).filter(Cart.id == item_id, Cart.user_id == current_user.id).delete()
        db.commit()
        return None

    # Anónimo (Borrar de Redis usando el GPU ID como key)
    if session_id and redis_client:
        cart_key = get_redis_cart_key(session_id)
        cart_data = redis_client.get(cart_key)
        if cart_data:
            cart = json.loads(cart_data)
            # Convertimos a string porque JSON keys son strings
            item_id_str = str(item_id)
            if item_id_str in cart:
                del cart[item_id_str]
                redis_client.setex(cart_key, 604800, json.dumps(cart))
    
    return None

@router.delete("/", status_code=status.HTTP_204_NO_CONTENT)
def clear_cart(
    session_id: Optional[str] = Header(None),
    current_user: Optional[User] = Depends(get_optional_current_user),
    db: Session = Depends(get_db)
):
    if current_user:
        db.query(Cart).filter(Cart.user_id == current_user.id).delete()
        db.commit()
    elif session_id and redis_client:
        cart_key = get_redis_cart_key(session_id)
        redis_client.delete(cart_key)
    return None