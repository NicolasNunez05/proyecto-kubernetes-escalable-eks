import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

// --- DEFINICIÓN DE TIPOS (Interfaces) ---

export interface GPU {
  id: number;
  name: string;
  brand: string;
  model: string;
  price: number;
  vram: number;
  cuda_cores: number;
  stock: number;
  image_url: string;
  description?: string;
}

export interface CartItem {
  id: number;
  gpu_id: number;
  quantity: number;
  gpu: GPU; // La GPU anidada que viene del backend
}

interface CartResponse {
  items: CartItem[];
  total: number;
}

interface CartContextType {
  cartItems: CartItem[];
  cartCount: number;
  addToCart: (gpuId: number, quantity?: number) => Promise<boolean>;
  removeFromCart: (itemId: number) => Promise<void>;
  isLoading: boolean;
}

// --- CONTEXTO ---

const CartContext = createContext<CartContextType | undefined>(undefined);

export const useCart = () => {
  const context = useContext(CartContext);
  if (!context) throw new Error('useCart debe usarse dentro de CartProvider');
  return context;
};

// --- PROVIDER ---

interface CartProviderProps {
  children: ReactNode;
}

export const CartProvider = ({ children }: CartProviderProps) => {
  const [cartItems, setCartItems] = useState<CartItem[]>([]);
  const [cartCount, setCartCount] = useState<number>(0);
  const [sessionId, setSessionId] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(false);
  
  // Usamos import.meta.env para Vite
  const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

  // 1. Generar o Recuperar Session ID
  useEffect(() => {
    let storedSession = localStorage.getItem('gpu_chile_session_id');
    if (!storedSession) {
      storedSession = crypto.randomUUID();
      localStorage.setItem('gpu_chile_session_id', storedSession);
    }
    setSessionId(storedSession);
    fetchCart(storedSession);
  }, []);

  // 2. Obtener Carrito
  const fetchCart = async (sid: string) => {
    if (!sid) return;
    try {
      const response = await fetch(`${API_URL}/cart/`, {
        headers: { 'session-id': sid }
      });
      
      if (response.ok) {
        const data: any = await response.json(); // Usamos any temporalmente para flexibilidad si la respuesta varía
        // El backend devuelve una lista directa o un objeto { items: [] } dependiendo de tu implementación final.
        // Asumimos que el backend devuelve una lista de items o un objeto { items: ... }
        // Ajuste defensivo:
        const items = Array.isArray(data) ? data : (data.items || []);
        
        setCartItems(items);
        const count = items.reduce((acc: number, item: CartItem) => acc + item.quantity, 0);
        setCartCount(count);
      }
    } catch (error) {
      console.error("Error cargando carrito:", error);
    }
  };

  // 3. Agregar al Carrito
  const addToCart = async (gpuId: number, quantity: number = 1): Promise<boolean> => {
    setIsLoading(true);
    try {
      const response = await fetch(`${API_URL}/cart/`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'session-id': sessionId
        },
        body: JSON.stringify({ gpu_id: gpuId, quantity })
      });

      if (response.ok) {
        await fetchCart(sessionId);
        return true;
      } else {
        const err = await response.json();
        alert(`Error: ${err.detail}`);
        return false;
      }
    } catch (error) {
      console.error("Error agregando al carrito:", error);
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  // 4. Eliminar del Carrito
  const removeFromCart = async (itemId: number) => {
    try {
      await fetch(`${API_URL}/cart/${itemId}`, {
        method: 'DELETE',
        headers: { 'session-id': sessionId }
      });
      await fetchCart(sessionId);
    } catch (error) {
      console.error("Error eliminando item:", error);
    }
  };

  const value: CartContextType = {
    cartItems,
    cartCount,
    addToCart,
    removeFromCart,
    isLoading
  };

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>;
};