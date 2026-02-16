from sqlalchemy import Column, Integer, String, Float, Boolean, JSON, DateTime
from sqlalchemy.sql import func
from app.db.base import Base

class GPU(Base):
    __tablename__ = "gpus"

    id = Column(Integer, primary_key=True, index=True)
    model = Column(String, index=True)
    brand = Column(String, index=True)
    series = Column(String, nullable=True)
    vram = Column(Integer)
    memory_type = Column(String, nullable=True)
    price = Column(Float)
    stock = Column(Integer, default=0)
    specs = Column(JSON, default={})
    is_featured = Column(Boolean, default=False)
    image_key = Column(String, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())