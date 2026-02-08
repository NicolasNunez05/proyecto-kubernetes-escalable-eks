import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';

const GPUDetail = () => {
  const { id } = useParams();
  const [gpu, setGpu] = useState(null);
  const [loading, setLoading] = useState(true);
  const { addToCart } = useCart();
  const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

  useEffect(() => {
    // Buscar la GPU específica por ID
    fetch(`${API_URL}/gpus/${id}`)
      .then((res) => {
        if (!res.ok) throw new Error("GPU no encontrada");
        return res.json();
      })
      .then((data) => {
        setGpu(data);
        setLoading(false);
      })
      .catch((err) => {
        console.error(err);
        setLoading(false);
      });
  }, [id]);

  if (loading) return <div className="text-white text-center mt-20">Cargando detalles...</div>;
  if (!gpu) return <div className="text-white text-center mt-20">GPU no encontrada 😢</div>;

  return (
    <div className="container mx-auto p-6 mt-10">
      <div className="bg-gray-800 rounded-xl shadow-2xl overflow-hidden border border-gray-700 flex flex-col md:flex-row">
        
        {/* Imagen Gigante */}
        <div className="md:w-1/2 p-8 bg-gray-900 flex items-center justify-center">
          <img 
            src={gpu.image_url} 
            alt={gpu.name} 
            className="max-h-[400px] object-contain hover:scale-110 transition-transform duration-500" 
          />
        </div>

        {/* Información */}
        <div className="md:w-1/2 p-8 flex flex-col justify-center">
          <div className="uppercase tracking-wide text-sm text-purple-400 font-semibold">{gpu.brand} • {gpu.model}</div>
          <h1 className="mt-2 text-4xl font-bold text-white leading-tight">{gpu.name}</h1>
          <p className="mt-4 text-gray-300 text-lg">{gpu.description || "Sin descripción disponible."}</p>
          
          <div className="mt-6 grid grid-cols-2 gap-4">
            <div className="bg-gray-700 p-3 rounded text-center">
              <span className="block text-gray-400 text-xs">VRAM</span>
              <span className="text-white font-bold">{gpu.vram} GB</span>
            </div>
            <div className="bg-gray-700 p-3 rounded text-center">
              <span className="block text-gray-400 text-xs">CUDA Cores</span>
              <span className="text-white font-bold">{gpu.cuda_cores}</span>
            </div>
          </div>

          <div className="mt-8 flex items-center justify-between">
            <span className="text-4xl font-bold text-white">${gpu.price.toLocaleString()}</span>
            <button 
              onClick={() => addToCart(gpu.id)}
              className="bg-purple-600 hover:bg-purple-500 text-white font-bold py-3 px-8 rounded-full shadow-lg transform transition hover:-translate-y-1"
            >
              Agregar al Carrito 🛒
            </button>
          </div>
          
          <Link to="/" className="mt-6 text-gray-400 hover:text-white text-sm">
            ← Volver al catálogo
          </Link>
        </div>
      </div>
    </div>
  );
};

export default GPUDetail;