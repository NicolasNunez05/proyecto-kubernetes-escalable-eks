import os
import logging
from typing import Optional, List, Dict
from sqlalchemy import text
from sentence_transformers import SentenceTransformer

from app.db.database import SessionLocal

logger = logging.getLogger(__name__)

# Imports opcionales
try:
    import agentops
    from langchain_groq import ChatGroq
    from langchain.schema import HumanMessage, SystemMessage
    AGENTOPS_AVAILABLE = True
except ImportError:
    AGENTOPS_AVAILABLE = False
    logger.warning("⚠️ AgentOps/LangChain-Groq not installed. AI features disabled.")


class AIService:
    """
    Servicio de IA con RAG (Retrieval-Augmented Generation)
    Usa pgvector para búsqueda semántica + Groq (Llama-3) para generación
    """
    
    def __init__(self):
        self.groq_api_key = os.getenv("GROQ_API_KEY")
        self.agentops_api_key = os.getenv("AGENTOPS_API_KEY")
        self.llm: Optional[ChatGroq] = None
        self.agentops_initialized = False
        self.embedding_model: Optional[SentenceTransformer] = None
        
        # Inicializar AgentOps
        if AGENTOPS_AVAILABLE and self.agentops_api_key:
            try:
                agentops.init(api_key=self.agentops_api_key)
                self.agentops_initialized = True
                logger.info("✅ AgentOps initialized")
            except Exception as e:
                logger.error(f"❌ AgentOps init failed: {e}")
        
        # Inicializar ChatGroq
        if self.groq_api_key and AGENTOPS_AVAILABLE:
            try:
                self.llm = ChatGroq(
                    groq_api_key=self.groq_api_key,
                    # --- CAMBIO CRÍTICO: Modelo Actualizado ---
                    model_name="llama-3.3-70b-versatile",
                    temperature=0
                )
                logger.info("✅ ChatGroq (Llama-3.3-70b) initialized")
            except Exception as e:
                logger.error(f"❌ ChatGroq init failed: {e}")
        
        # Inicializar modelo de embeddings (mismo que el seeding)
        try:
            self.embedding_model = SentenceTransformer('all-MiniLM-L6-v2')
            logger.info("✅ Embedding model loaded (all-MiniLM-L6-v2)")
        except Exception as e:
            logger.error(f"❌ Embedding model failed: {e}")
    
    def is_available(self) -> bool:
        """Verifica disponibilidad del servicio"""
        return (
            self.llm is not None and 
            AGENTOPS_AVAILABLE and 
            self.embedding_model is not None
        )
    
    def retrieve_similar_products(self, query: str, top_k: int = 3) -> List[Dict]:
        """
        RAG Step 1: Retrieval
        Busca productos similares usando pgvector
        """
        if not self.embedding_model:
            return []
        
        try:
            # 1. Convertir pregunta a vector
            query_embedding = self.embedding_model.encode(query).tolist()
            
            # 2. Búsqueda por similitud coseno (<-> operador de pgvector)
            db = SessionLocal()
            sql_query = text("""
                SELECT 
                    id, 
                    name, 
                    description, 
                    price, 
                    stock,
                    brand,
                    (embedding <-> :query_vector) AS distance
                FROM products
                WHERE embedding IS NOT NULL
                ORDER BY distance ASC
                LIMIT :top_k
            """)
            
            result = db.execute(
                sql_query,
                {"query_vector": str(query_embedding), "top_k": top_k}
            )
            
            products = []
            for row in result:
                products.append({
                    "id": row[0],
                    "name": row[1],
                    "description": row[2],
                    "price": row[3],
                    "stock": row[4],
                    "brand": row[5],
                    "relevance_score": round(1 - row[6], 3)  # Invertir distancia
                })
            
            db.close()
            logger.info(f"🔍 Retrieved {len(products)} similar products")
            return products
            
        except Exception as e:
            logger.error(f"❌ Retrieval error: {e}")
            return []
    
    @agentops.record_function('generate_response') if AGENTOPS_AVAILABLE else lambda f: f
    def ask_agent(self, question: str) -> Dict:
        """
        RAG Step 2: Augmented Generation
        Inyecta contexto de productos en el prompt y genera respuesta
        """
        if not self.is_available():
            return {
                "answer": "AI service not available. Please configure API keys.",
                "error": "Service unavailable",
                "observability": "disabled",
                "retrieved_products": []
            }
        
        try:
            # 1. RETRIEVAL: Buscar productos relevantes
            similar_products = self.retrieve_similar_products(question, top_k=3)
            
            # 2. AUGMENTATION: Construir contexto enriquecido
            if similar_products:
                context = "### Productos Disponibles (recuperados de la base de datos):\n"
                for idx, product in enumerate(similar_products, 1):
                    context += f"{idx}. **{product['name']}** (${product['price']:.2f})\n"
                    context += f"   - {product['description']}\n"
                    context += f"   - Stock: {product['stock']} unidades\n"
                    context += f"   - Marca: {product['brand']}\n"
                    context += f"   - Relevancia: {product['relevance_score']}\n\n"
            else:
                context = "No se encontraron productos relevantes en el inventario actual."
            
            # 3. GENERATION: Prompt Engineering con contexto
            system_prompt = f"""
Eres el Asistente Virtual Experto de 'GpuChile', la tienda líder en hardware gaming.

**TUS REGLAS:**
1. Solo recomiendas GPUs de NVIDIA y AMD (no menciones otras marcas).
2. Si te preguntan por CPUs, RAM o periféricos, responde cortésmente que solo vendemos GPUs.
3. SIEMPRE basa tus recomendaciones en el contexto recuperado abajo.
4. Respuestas técnicas pero concisas (máximo 4 oraciones).
5. Si detectas intención de compra, menciona que pueden visitar '/api/gpus' para ver el catálogo completo.
6. Nunca reveles que eres Llama-3 o Groq, eres 'GpuChileBot'.

{context}

**Usa SOLO la información de arriba para responder.**
"""
            
            # 4. Invocar LLM con contexto aumentado
            messages = [
                SystemMessage(content=system_prompt),
                HumanMessage(content=question)
            ]
            
            response = self.llm.invoke(messages)
            
            return {
                "answer": response.content,
                # --- CAMBIO: Reflejar el nombre correcto en la respuesta ---
                "model": "llama-3.3-70b-versatile",
                "rag_enabled": True,
                "retrieved_products": similar_products,
                "observability": "tracked_by_agentops" if self.agentops_initialized else "disabled"
            }
            
        except Exception as e:
            logger.error(f"❌ AI generation error: {e}")
            return {
                "answer": f"Error al generar respuesta: {str(e)}",
                "error": str(e),
                "rag_enabled": False,
                "observability": "error"
            }


# Instancia singleton
ai_service = AIService()