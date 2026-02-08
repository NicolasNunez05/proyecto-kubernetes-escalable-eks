from sqlalchemy import Column, Integer, ForeignKey
from app.db.database import Base

class Cart(Base):
    __tablename__ = "carts"

    id = Column(Integer, primary_key=True, index=True)
    # Por ahora lo hacemos simple para que no falle por claves foráneas
    user_id = Column(Integer, nullable=True) 
    gpu_id = Column(Integer, nullable=False)
    quantity = Column(Integer, default=1)