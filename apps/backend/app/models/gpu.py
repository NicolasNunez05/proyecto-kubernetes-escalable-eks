from sqlalchemy import Column, Integer, String, Boolean, Float, Text, DateTime
from datetime import datetime
from app.db.database import Base

class GPU(Base):
    __tablename__ = "gpus"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    brand = Column(String, index=True)
    model = Column(String, index=True)
    price = Column(Float)
    vram = Column(Integer)
    cuda_cores = Column(Integer, nullable=True)
    stock = Column(Integer, default=0)
    image_url = Column(String, nullable=True)
    description = Column(Text, nullable=True)
    is_featured = Column(Boolean, default=False)
    # ESTA ES LA LÍNEA QUE FALTABA Y CAUSABA EL ERROR SQL:
    created_at = Column(DateTime, default=datetime.utcnow)