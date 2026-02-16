import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useCart, GPU } from '../context/CartContext';

// Iconos
const Icons = {
  Cpu: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>,
  Zap: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>,
  Cart: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>,
  Trending: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/></svg>
};

const HomePage = () => {
  const [gpus, setGpus] = useState<GPU[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  
  // CORRECCIÓN 1: Aseguramos que la URL no termine en doble slash
  const API_URL = (import.meta.env.VITE_API_URL || 'http://localhost:8000/api').replace(/\/$/, '');

  useEffect(() => {
    // CORRECCIÓN 2: Quitamos el slash final en '/gpus' para evitar errores 404 en algunos backends
    fetch(`${API_URL}/gpus`) 
      .then(res => {
        if (!res.ok) throw new Error(`Error HTTP: ${res.status}`);
        return res.json();
      })
      .then((data: any) => {
        // CORRECCIÓN 3: Validación defensiva. Si no es un array, ponemos array vacío.
        if (Array.isArray(data)) {
          setGpus(data);
        } else {
          console.error("Formato de datos incorrecto:", data);
          setGpus([]); 
        }
        setLoading(false);
      })
      .catch(err => {
        console.error("Error al cargar GPUs:", err);
        setGpus([]); // Evita pantalla blanca en caso de error
        setLoading(false);
      });
  }, []);

  // Helpers seguros para evitar crash si gpus está vacío
  const safeGpus = Array.isArray(gpus) ? gpus : [];
  const stockCount = safeGpus.filter(g => g.stock > 0).length;
  const brandCount = new Set(safeGpus.map(g => g.brand)).size;

  if (loading) return (
    <div className="flex h-screen items-center justify-center bg-gray-900">
      <div className="text-purple-500 animate-pulse text-xl font-bold">Cargando Sistema...</div>
    </div>
  );

  return (
    <div className="min-h-screen bg-gray-900 text-white p-4 md:p-8 space-y-12">
      
      {/* Hero Section */}
      <div className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-indigo-900 via-purple-900 to-slate-900 px-8 py-16 shadow-2xl border border-purple-500/20">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_50%,rgba(123,44,191,0.3),transparent_70%)]" />
        <div className="relative z-10 max-w-3xl">
          <h1 className="text-5xl md:text-7xl font-extrabold tracking-tight mb-6 drop-shadow-lg">
            Las Mejores GPUs <br />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">del Mercado</span>
          </h1>
          <p className="text-xl text-gray-300 mb-8 max-w-xl">
            Potencia tu setup con tecnología de punta. Renderizado, IA y Gaming al máximo nivel.
          </p>
          <button className="bg-purple-600 hover:bg-purple-500 text-white px-8 py-3 rounded-full font-bold shadow-[0_0_20px_rgba(168,85,247,0.5)] transition-all hover:scale-105">
            Explorar Catálogo
          </button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {[
          { icon: Icons.Trending, val: safeGpus.length, label: "Modelos Disponibles", color: "text-blue-400", bg: "bg-blue-400/10" },
          { icon: Icons.Zap, val: stockCount, label: "En Stock Inmediato", color: "text-green-400", bg: "bg-green-400/10" },
          { icon: Icons.Cpu, val: brandCount, label: "Marcas Premium", color: "text-pink-400", bg: "bg-pink-400/10" }
        ].map((stat, i) => (
          <div key={i} className="bg-gray-800/50 border border-gray-700 p-6 rounded-2xl flex items-center gap-4 hover:border-purple-500/30 transition-colors">
            <div className={`p-3 rounded-full ${stat.bg} ${stat.color}`}>
              <stat.icon />
            </div>
            <div>
              <div className="text-3xl font-bold">{stat.val}</div>
              <div className="text-gray-400 text-sm">{stat.label}</div>
            </div>
          </div>
        ))}
      </div>

      {/* Grid de Productos */}
      <div>
        <h2 className="text-3xl font-bold mb-8 flex items-center gap-2">
          Catálogo <span className="text-purple-400">Gamer</span>
        </h2>
        
        {safeGpus.length === 0 ? (
           <div className="text-center text-gray-400 py-10 bg-gray-800 rounded-xl">
              <p>No se encontraron productos o error de conexión con AWS.</p>
              <p className="text-xs mt-2 text-gray-600">URL API: {API_URL}</p>
           </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {safeGpus.map((gpu) => (
              <GPUCard key={gpu.id} gpu={gpu} />
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

// Componente Tarjeta Individual
interface GPUCardProps {
  gpu: GPU;
}

const GPUCard = ({ gpu }: GPUCardProps) => {
  const { addToCart } = useCart();
  const [isAdding, setIsAdding] = useState(false);

  const handleAdd = async () => {
    setIsAdding(true);
    await addToCart(gpu.id);
    setTimeout(() => setIsAdding(false), 500);
  };

  return (
    <div className="group bg-gray-800 rounded-xl overflow-hidden border border-gray-700 hover:border-purple-500/50 transition-all duration-300 hover:shadow-[0_0_30px_rgba(168,85,247,0.15)] flex flex-col">
      <div className="relative h-64 bg-gray-900 p-6 flex items-center justify-center overflow-hidden">
        <img 
          src={gpu.image_url} 
          alt={gpu.name} 
          className="max-h-full object-contain transition-transform duration-500 group-hover:scale-110 group-hover:rotate-2"
        />
        <div className="absolute top-3 left-3 bg-gray-900/80 backdrop-blur px-3 py-1 rounded-full text-xs font-bold text-white border border-gray-600">
          {gpu.brand}
        </div>
        {gpu.stock === 0 && (
          <div className="absolute inset-0 bg-black/70 flex items-center justify-center font-bold text-red-500 text-xl backdrop-blur-sm">
            AGOTADO
          </div>
        )}
      </div>

      <div className="p-5 flex-1 flex flex-col">
        <Link to={`/gpus/${gpu.id}`}>
          <h3 className="text-lg font-bold text-white mb-2 line-clamp-2 hover:text-purple-400 transition-colors">
            {gpu.name}
          </h3>
        </Link>
        
        <div className="flex gap-2 mb-4 text-xs font-mono">
          <span className="bg-purple-500/20 text-purple-300 px-2 py-1 rounded">{gpu.vram}GB VRAM</span>
          <span className="bg-blue-500/20 text-blue-300 px-2 py-1 rounded">{gpu.cuda_cores} Cores</span>
        </div>

        <div className="mt-auto pt-4 border-t border-gray-700 flex items-center justify-between">
          <span className="text-2xl font-bold text-white">
            ${gpu.price.toLocaleString()}
          </span>
          
          <button
            onClick={handleAdd}
            disabled={gpu.stock === 0 || isAdding}
            className={`p-3 rounded-lg transition-all ${
              isAdding 
                ? 'bg-green-600 text-white' 
                : 'bg-white text-black hover:bg-purple-400 hover:text-white'
            } disabled:opacity-50 disabled:cursor-not-allowed`}
          >
            {isAdding ? (
              <span className="text-xs font-bold">AGREGADO</span>
            ) : (
              <Icons.Cart />
            )}
          </button>
        </div>
      </div>
    </div>
  );
};

export default HomePage;