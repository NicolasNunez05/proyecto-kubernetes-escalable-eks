import { useState, useEffect } from 'react';
import axios from 'axios';
import { Send, Cpu, ShoppingCart, Activity, X, Trash2, Plus, Zap, Database, ExternalLink, Server } from 'lucide-react';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';

// --- MAPA DE IMÁGENES DE EMERGENCIA ---
// Como el backend está forzando un placeholder, usamos esto para mostrar TUS fotos reales
const IMAGE_MAP: Record<string, string> = {
  "RTX 4090": "https://postperspective.com/wp-content/uploads/2022/10/GeForce-RTX4090-3QTR-Back-Left-1-624x423.jpg",
  "RTX 4080 Super": "https://media.solotodo.com/media/products/1908889_picture_1714628261.jpg",
  "RX 7900 XTX": "https://www.winpy.cl/files/40276-1210-Tarjeta-de-Video-Gigabyte-Gaming-RX-7900-XTX-OC-de-24GB-GDDR6-1.jpg",
  "RTX 4070 Ti Super": "https://static.gigabyte.com/StaticFile/Image/Global/4ff5ef905e0d95bb802303397cccb4b2/ProductRemoveBg/39097",
  "RX 7800 XT": "https://media.solotodo.com/media/products/1813688_picture_1694325846.jpg",
  "RTX 4060": "https://media.spdigital.cl/thumbnails/products/9pabv5mf_8be0215a_thumbnail_512.jpg",
  "H100": "https://miro.medium.com/1*TFadQrVWmT6FsYlIG5HDnw.jpeg",
  "A100": "https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/a100/nvidia-a100-pcie-3qtr-top-left-2c50-d@2x.jpg",
  "RTX 6000 Ada": "https://www.zstore.be/cdn/shop/files/40949_1Z.webp?v=1723626638&width=2048",
  "Arc A770": "https://media.solotodo.com/media/products/1719344_picture_1675848714.jpg"
};

export default function App() {
  const [products, setProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState('');
  const [chatHistory, setChatHistory] = useState<{role: string, content: string}[]>([]);
  const [aiLoading, setAiLoading] = useState(false);
  const [cart, setCart] = useState<any[]>([]);
  const [isCartOpen, setIsCartOpen] = useState(false);

  useEffect(() => { fetchProducts(); }, []);

  const fetchProducts = async () => {
    try {
      const res = await axios.get(`${API_URL}/api/gpus`);
      setProducts(Array.isArray(res.data) ? res.data : []);
    } catch (error) { console.error(error); setProducts([]); } 
    finally { setLoading(false); }
  };

  // --- LÓGICA DE VISUALIZACIÓN INTELIGENTE ---
  const getDisplayImage = (p: any) => {
    // 1. Si tenemos la foto mapeada por el modelo, ÚSALA (Prioridad 1)
    if (p.model && IMAGE_MAP[p.model]) return IMAGE_MAP[p.model];
    // 2. Si el backend mandó una URL válida que no sea el placeholder, úsala
    if (p.image_url && p.image_url.startsWith('http') && !p.image_url.includes('placeholder')) return p.image_url;
    // 3. Fallback
    return 'https://placehold.co/600x400/1a1a1a/666666?text=No+Image';
  };

  const getDisplayName = (p: any) => {
    // Si no hay "name", juntamos "brand" + "model"
    if (!p.name && p.brand && p.model) return `${p.brand} ${p.model}`;
    return p.name || "Producto Sin Nombre";
  };

  const addToCart = (p: any) => setCart([...cart, p]);
  const removeFromCart = (i: number) => setCart(cart.filter((_, idx) => idx !== i));
  const cartTotal = cart.reduce((total, item) => total + (item.price || 0), 0);

  const handleChat = async (e: any) => {
    e.preventDefault();
    if (!query.trim()) return;
    const newHistory = [...chatHistory, { role: 'user', content: query }];
    setChatHistory(newHistory);
    setAiLoading(true);
    setQuery('');
    try {
      const res = await axios.post(`${API_URL}/api/v1/ask-ai`, { query });
      setChatHistory([...newHistory, { role: 'ai', content: res.data.answer }]);
    } catch (error) { setChatHistory([...newHistory, { role: 'ai', content: "Error IA." }]); } 
    finally { setAiLoading(false); }
  };

  return (
    <div className="min-h-screen bg-[#050505] text-white font-sans selection:bg-cyan-500 selection:text-black pb-20">
      
      <nav className="border-b border-white/10 bg-slate-900/90 backdrop-blur-md sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-gradient-to-tr from-cyan-600 to-blue-600 rounded-lg shadow-lg shadow-cyan-500/20">
                <Cpu className="text-white w-6 h-6" />
            </div>
            <div>
                <h1 className="text-xl font-bold tracking-tight text-white">GPU_CHILE</h1>
                <p className="text-[10px] text-cyan-500 font-mono tracking-widest">KUBERNETES STORE</p>
            </div>
          </div>
          <div className="flex gap-4 items-center">
             <div className="hidden md:flex gap-4 text-[10px] font-mono tracking-widest uppercase text-slate-500">
                <span className="flex items-center gap-1"><Database className="w-3 h-3 text-emerald-500"/> RDS: CONNECTED</span>
             </div>
             <button className="relative group p-2 hover:bg-white/5 rounded-full transition" onClick={() => setIsCartOpen(true)}>
                <ShoppingCart className="w-6 h-6 text-slate-300 group-hover:text-cyan-400 transition" />
                {cart.length > 0 && <span className="absolute -top-1 -right-1 bg-cyan-500 text-black text-[10px] font-bold w-5 h-5 rounded-full flex items-center justify-center border-2 border-[#050505]">{cart.length}</span>}
             </button>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto px-6 py-10 grid grid-cols-1 lg:grid-cols-12 gap-10">
        
        {/* Catálogo */}
        <div className="lg:col-span-8 space-y-8">
          <div className="flex justify-between items-end border-b border-white/10 pb-4">
             <div><h2 className="text-3xl font-bold text-white">Catálogo de Hardware</h2><p className="text-slate-400 text-sm mt-1">Componentes disponibles en tiempo real.</p></div>
             <span className="bg-cyan-500/10 text-cyan-400 px-3 py-1 rounded text-xs font-mono border border-cyan-500/20">{products.length} ITEMS</span>
          </div>

          {loading ? (
             <div className="flex flex-col items-center py-20 gap-4"><div className="w-10 h-10 border-4 border-cyan-500 border-t-transparent rounded-full animate-spin"></div><div className="text-cyan-500 font-mono text-xs animate-pulse">Sincronizando...</div></div>
          ) : products.length === 0 ? (
             <div className="bg-[#0f1115] border border-dashed border-white/10 rounded-2xl p-10 text-center">
                <Database className="w-12 h-12 text-slate-600 mx-auto mb-4"/>
                <h3 className="text-slate-300 font-bold mb-2">Base de Datos Vacía</h3>
                <p className="text-slate-500 text-sm mb-6">Usa Swagger para cargar productos.</p>
                <a href={`${API_URL}/docs`} target="_blank" className="inline-flex items-center gap-2 bg-cyan-600 hover:bg-cyan-500 text-white px-6 py-3 rounded-lg text-sm font-bold transition"><ExternalLink className="w-4 h-4"/> IR A SWAGGER</a>
             </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {products.map((p, i) => (
                <div key={i} className="group bg-[#0f1115] border border-white/5 rounded-2xl overflow-hidden hover:border-cyan-500/50 transition-all duration-300 shadow-lg hover:shadow-cyan-900/10">
                  <div className="h-64 bg-white/5 p-6 flex items-center justify-center relative">
                      {/* FOTO REAL USANDO EL MAPA */}
                      <img 
                          src={getDisplayImage(p)} 
                          alt={getDisplayName(p)} 
                          className="max-h-full object-contain drop-shadow-xl group-hover:scale-105 transition duration-500" 
                      />
                      {p.brand && <div className="absolute top-4 left-4 bg-black/60 backdrop-blur px-3 py-1 rounded text-[10px] font-bold text-slate-300 border border-white/10 uppercase tracking-wider">{p.brand}</div>}
                  </div>
                  <div className="p-6">
                    <div className="flex justify-between items-start mb-3">
                        {/* NOMBRE CONSTRUIDO (Marca + Modelo) */}
                        <h3 className="font-bold text-lg text-white leading-tight w-3/4">{getDisplayName(p)}</h3>
                        <span className="text-emerald-400 font-mono font-bold text-xl">${p.price}</span>
                    </div>
                    <p className="text-slate-400 text-xs mb-6 line-clamp-2 leading-relaxed">VRAM: {p.vram}GB | {p.description || "Sin descripción"}</p>
                    <button onClick={() => addToCart(p)} className="w-full bg-slate-800 hover:bg-cyan-600 hover:text-white text-slate-300 py-3 rounded-xl text-sm font-bold transition flex items-center justify-center gap-2 group-hover:shadow-lg group-hover:shadow-cyan-900/20"><Plus className="w-4 h-4" /> AGREGAR AL CARRITO</button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
        <div className="lg:col-span-4">
            <div className="bg-[#0f1115] border border-white/10 rounded-3xl p-6 h-[600px] flex flex-col sticky top-28 shadow-2xl">
                <div className="flex items-center gap-3 mb-6 pb-4 border-b border-white/5"><Activity className="text-cyan-400 w-5 h-5 animate-pulse" /><div><h3 className="font-bold text-white">Asistente IA</h3><p className="text-[10px] text-slate-400 uppercase tracking-wider">Llama-3 Online</p></div></div>
                <div className="flex-1 overflow-y-auto space-y-4 pr-2 mb-4 scrollbar-thin scrollbar-thumb-slate-800">
                    {chatHistory.length === 0 && <div className="mt-20 text-center text-slate-500 text-sm">Prueba: "Recomienda una GPU para 4K"</div>}
                    {chatHistory.map((msg, i) => (<div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}><div className={`max-w-[85%] p-4 rounded-2xl text-sm ${msg.role === 'user' ? 'bg-cyan-700 text-white' : 'bg-[#1a1d24] text-slate-300'}`}>{msg.content}</div></div>))}
                    {aiLoading && <div className="text-xs text-slate-500 animate-pulse pl-2">Pensando...</div>}
                </div>
                <form onSubmit={handleChat} className="relative mt-auto"><input type="text" value={query} onChange={(e) => setQuery(e.target.value)} placeholder="..." className="w-full bg-black border border-white/10 rounded-xl py-4 pl-4 text-sm text-white focus:border-cyan-500" /><button type="submit" className="absolute right-2 top-2 p-2 bg-cyan-600 rounded-lg"><Send className="w-4 h-4 text-white" /></button></form>
            </div>
        </div>
      </main>
      
      {/* Carrito */}
      {isCartOpen && (
        <div className="fixed inset-0 z-[60] flex justify-end backdrop-blur-md bg-black/60" onClick={() => setIsCartOpen(false)}>
            <div className="w-full max-w-md bg-[#0f1115] h-full shadow-2xl flex flex-col border-l border-white/10 p-6" onClick={(e) => e.stopPropagation()}>
                <h2 className="text-xl font-bold mb-6 flex gap-2"><ShoppingCart/> Carrito</h2>
                <div className="flex-1 space-y-4 overflow-y-auto">{cart.map((item, i) => (<div key={i} className="flex gap-4 items-center bg-white/5 p-3 rounded-xl border border-white/5"><img src={getDisplayImage(item)} className="w-12 h-12 object-contain bg-white/5 rounded p-1" /><div className="flex-1"><h4 className="text-sm font-bold">{getDisplayName(item)}</h4><p className="text-emerald-400 font-mono">${item.price}</p></div><button onClick={() => removeFromCart(i)} className="text-red-500"><Trash2/></button></div>))}</div>
                <div className="pt-6 border-t border-white/10 mt-4"><div className="flex justify-between text-xl font-bold mb-4"><span>Total:</span><span className="text-cyan-400 font-mono">${cartTotal.toFixed(2)}</span></div><button className="w-full py-4 bg-cyan-600 rounded-xl font-bold">PAGAR</button></div>
            </div>
        </div>
      )}
    </div>
  );
}