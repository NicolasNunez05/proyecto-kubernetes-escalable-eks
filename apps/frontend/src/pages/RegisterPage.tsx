import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const RegisterPage = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);

  const handleRegister = (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      alert("Registro simulado. ¡Bienvenido!");
      navigate('/login');
    }, 1500);
  };

  return (
    <div className="min-h-screen bg-gray-900 flex items-center justify-center p-4 relative overflow-hidden">
      <div className="absolute top-[20%] right-[30%] w-[400px] h-[400px] bg-pink-600/10 rounded-full blur-[100px]" />

      <div className="bg-gray-800 border border-gray-700 p-8 rounded-2xl shadow-2xl w-full max-w-md relative z-10">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">Crear Cuenta</h1>
          <p className="text-gray-400">Únete a la comunidad Gamer</p>
        </div>

        <form onSubmit={handleRegister} className="space-y-5">
          <div className="grid grid-cols-2 gap-4">
            <input type="text" placeholder="Nombre" className="bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
            <input type="text" placeholder="Apellido" className="bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          </div>
          
          <input type="email" placeholder="Email" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          <input type="password" placeholder="Contraseña" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />
          <input type="password" placeholder="Confirmar Contraseña" className="w-full bg-gray-900 border border-gray-600 rounded-lg px-4 py-3 text-white focus:ring-purple-500 outline-none" required />

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-gradient-to-r from-pink-600 to-purple-600 hover:from-pink-500 hover:to-purple-500 text-white font-bold py-3 rounded-lg shadow-lg transform transition active:scale-95 disabled:opacity-50"
          >
            {loading ? 'Creando cuenta...' : 'Registrarse'}
          </button>
        </form>

        <div className="mt-6 text-center text-sm text-gray-400">
          ¿Ya tienes cuenta?{' '}
          <Link to="/login" className="text-pink-400 hover:text-pink-300 font-semibold">
            Ingresa aquí
          </Link>
        </div>
      </div>
    </div>
  );
};

export default RegisterPage;