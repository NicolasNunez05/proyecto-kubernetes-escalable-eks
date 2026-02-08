import React from 'react';
import { Link } from 'react-router-dom';
// 👇 Usamos Iconos SVG directos para evitar errores si no tienes lucide-react instalado
// Si tienes lucide instalado, puedes descomentar la siguiente linea y borrar el objeto Icons:
// import { ShoppingCart, User, Cpu } from 'lucide-react';

// 👇 CONEXIÓN REAL: Importamos desde el contexto que sí existe
import { useCart } from '../../context/CartContext';

// Iconos SVG (Respaldos por si acaso)
const Icons = {
  Cpu: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="h-8 w-8 text-purple-500 transition-all group-hover:drop-shadow-[0_0_8px_rgba(123,44,191,0.8)]"><rect width="16" height="16" x="4" y="4" rx="2"/><rect width="6" height="6" x="9" y="9" rx="1"/><path d="M15 2v2"/><path d="M15 20v2"/><path d="M2 15h2"/><path d="M2 9h2"/><path d="M20 15h2"/><path d="M20 9h2"/><path d="M9 2v2"/><path d="M9 20v2"/></svg>,
  Cart: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="h-5 w-5 text-gray-300 group-hover:text-purple-400 transition-colors"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>,
  User: () => <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2 h-4 w-4"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
};

const Navbar = () => {
  // 👇 Usamos 'cartCount' que es la variable que definimos en CartContext.tsx
  const { cartCount } = useCart(); 

  return (
    <nav className="sticky top-0 z-50 w-full bg-gray-900/80 backdrop-blur-md border-b border-white/10">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          
          {/* Logo con efecto neon */}
          <Link to="/" className="flex items-center space-x-2 group">
            <Icons.Cpu />
            <span className="text-2xl font-bold">
              <span className="text-white">Gpu</span>
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-600">Chile</span>
            </span>
          </Link>

          {/* Navigation Links */}
          <div className="hidden md:flex md:items-center md:space-x-8">
            {['GPUs', 'Nosotros', 'Contacto'].map((item) => (
              <Link
                key={item}
                to="/"
                className="text-base font-medium text-gray-300 hover:text-purple-400 transition-colors relative group"
              >
                {item}
                <span className="absolute -bottom-1 left-0 h-0.5 w-0 bg-purple-500 transition-all group-hover:w-full" />
              </Link>
            ))}
          </div>

          {/* Right Side Actions */}
          <div className="flex items-center space-x-4">
            
            {/* Cart Button con glow */}
            <Link to="/cart" className="relative group p-2 hover:bg-gray-800 rounded-full transition-colors">
              <Icons.Cart />
              {cartCount > 0 && (
                <span className="absolute -right-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full bg-purple-600 text-xs font-bold text-white shadow-[0_0_10px_rgba(168,85,247,0.5)] animate-pulse">
                  {cartCount > 9 ? '9+' : cartCount}
                </span>
              )}
            </Link>

            {/* User Button */}
            <Link to="/login">
              <button 
                className="flex items-center border border-purple-500/50 text-purple-400 hover:bg-purple-500/10 hover:shadow-[0_0_15px_rgba(168,85,247,0.3)] transition-all px-4 py-2 rounded-lg font-medium text-sm"
              >
                <Icons.User />
                Ingresar
              </button>
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;