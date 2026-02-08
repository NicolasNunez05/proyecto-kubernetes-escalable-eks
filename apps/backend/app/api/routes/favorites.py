from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def get_favorites():
    return {"msg": "Favoritos endpoint pendiente"}