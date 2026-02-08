import { Routes, Route } from 'react-router-dom';
// 👇 CORRECCIÓN: Apuntar a la carpeta layout
import Navbar from './components/layout/Navbar'; 
import HomePage from './pages/HomePage';
import GPUDetail from './pages/GPUDetail';
import CartPage from './pages/CartPage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';

function App() {
  return (
    <div className="bg-gray-900 min-h-screen text-white font-sans">
      <Navbar />
      
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/gpus/:id" element={<GPUDetail />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
      </Routes>
    </div>
  );
}

export default App;