from sqlalchemy import Column, Integer, String, Float, Text
from pgvector.sqlalchemy import Vector
from app.db.database import Base


class Product(Base):
    """
    Modelo de Producto con Embeddings para RAG
    """
    __tablename__ = "products"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False, index=True)
    description = Column(Text, nullable=False)
    price = Column(Float, nullable=False)
    stock = Column(Integer, default=0)
    category = Column(String(100), default="GPU")
    brand = Column(String(50))  # NVIDIA, AMD
    
    # Vector de embeddings (384 dimensiones para all-MiniLM-L6-v2)
    embedding = Column(Vector(384), nullable=True)
    
    def __repr__(self):
        return f"<Product(id={self.id}, name='{self.name}', price={self.price})>"
