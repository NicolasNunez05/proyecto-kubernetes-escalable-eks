import React from 'react';
import { Link } from 'react-router-dom';
import { useCart } from '../context/CartContext';

const Icons = {
  Trash: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/></svg>,
  Plus: () => <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="M12 5v14"/></svg>,
  Minus: () => <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/></svg>,
  ArrowRight: () => <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>
};

const CartPage = () => {
  const { cartItems, removeFromCart, addToCart, isLoading } = useCart();

  // Calcular total dinámicamente con Tipado seguro
  const total = cartItems.reduce((acc, item) => acc + (item.gpu.price * item.quantity), 0);

  if (cartItems.length === 0) {
    return (
      <div className="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-4">
        <div className="bg-gray-800 p-8 rounded-2xl border border-gray-700 text-center shadow-2xl max-w-md w-full">
          <div className="bg-gray-700/50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg className="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
          </div>
          <h2 className="text-2xl font-bold mb-2">Tu carrito está vacío</h2>
          <p className="text-gray-400 mb-8">Parece que aún no has elegido tu próxima GPU.</p>
          <Link to="/" className="block w-full bg-purple-600 hover:bg-purple-500 text-white py-3 rounded-xl font-bold transition-colors text-center">
            Volver al Catálogo
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white p-4 md:p-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-3xl font-bold mb-8 flex items-center gap-3">
          Tu Carrito <span className="text-purple-400">Gamer</span>
          <span className="text-sm bg-gray-800 text-gray-300 px-3 py-1 rounded-full font-normal">
            {cartItems.length} items
          </span>
        </h1>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          
          <div className="lg:col-span-2 space-y-4">
            {cartItems.map((item) => (
              <div key={item.id} className="bg-gray-800 border border-gray-700 rounded-xl p-4 flex flex-col sm:flex-row gap-4 items-center shadow-lg transition-all hover:border-purple-500/30">
                
                <div className="w-24 h-24 bg-gray-900 rounded-lg p-2 flex-shrink-0">
                  <img src={item.gpu.image_url} alt={item.gpu.name} className="w-full h-full object-contain" />
                </div>

                <div className="flex-1 text-center sm:text-left">
                  <h3 className="font-bold text-lg text-white">{item.gpu.name}</h3>
                  <p className="text-purple-400 text-sm">{item.gpu.brand}</p>
                  <p className="text-gray-400 text-xs mt-1">VRAM: {item.gpu.vram}GB</p>
                </div>

                <div className="flex items-center gap-3 bg-gray-900 rounded-lg p-1">
                  <button 
                    disabled={isLoading || item.quantity <= 1}
                    onClick={() => addToCart(item.gpu.id, -1)}
                    className="p-2 hover:bg-gray-700 rounded text-gray-300 disabled:opacity-30"
                  >
                    <Icons.Minus />
                  </button>
                  <span className="font-mono w-8 text-center">{item.quantity}</span>
                  <button 
                    disabled={isLoading}
                    onClick={() => addToCart(item.gpu.id, 1)}
                    className="p-2 hover:bg-gray-700 rounded text-white disabled:opacity-30"
                  >
                    <Icons.Plus />
                  </button>
                </div>

                <div className="text-right min-w-[100px]">
                  <div className="font-bold text-xl">${(item.gpu.price * item.quantity).toLocaleString()}</div>
                  {item.quantity > 1 && (
                    <div className="text-xs text-gray-500">${item.gpu.price.toLocaleString()} c/u</div>
                  )}
                </div>

                <button 
                  onClick={() => removeFromCart(item.id)}
                  className="p-2 text-red-400 hover:bg-red-400/10 rounded-full transition-colors"
                  title="Eliminar"
                >
                  <Icons.Trash />
                </button>
              </div>
            ))}
          </div>

          <div className="lg:col-span-1">
            <div className="bg-gray-800 border border-gray-700 rounded-2xl p-6 shadow-2xl sticky top-4">
              <h3 className="text-xl font-bold mb-6 text-white">Resumen del Pedido</h3>
              
              <div className="space-y-3 mb-6">
                <div className="flex justify-between text-gray-400">
                  <span>Subtotal</span>
                  <span>${total.toLocaleString()}</span>
                </div>
                <div className="flex justify-between text-gray-400">
                  <span>Envío</span>
                  <span className="text-green-400">Gratis</span>
                </div>
                <div className="h-px bg-gray-700 my-4" />
                <div className="flex justify-between items-end">
                  <span className="text-lg font-bold">Total</span>
                  <span className="text-3xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">
                    ${total.toLocaleString()}
                  </span>
                </div>
              </div>

              <button className="w-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 text-white font-bold py-4 rounded-xl shadow-lg transform transition active:scale-95 flex items-center justify-center gap-2">
                Proceder al Pago <Icons.ArrowRight />
              </button>
              
              <p className="text-xs text-center text-gray-500 mt-4">
                🔒 Transacción segura encriptada con tecnología EKS.
              </p>
            </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default CartPage;