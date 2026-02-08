import axios from 'axios';

// Base URL desde variable de entorno
const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000/api';

// Instancia de axios configurada
export const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000, // 10 segundos
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor (agregar token JWT cuando lo implementes)
api.interceptors.request.use(
  (config) => {
    // Obtener token de localStorage si existe
    const token = localStorage.getItem('accessToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor (manejo de errores global)
api.interceptors.response.use(
  (response) => response,
  (error) => {
    // Manejo de errores comunes
    if (error.response?.status === 401) {
      // Unauthorized - limpiar token y redirigir a login
      localStorage.removeItem('accessToken');
      window.location.href = '/login';
    }
    
    if (error.response?.status === 403) {
      // Forbidden
      console.error('No tienes permisos para esta acción');
    }
    
    if (error.response?.status >= 500) {
      // Server error
      console.error('Error del servidor. Intenta más tarde.');
    }
    
    return Promise.reject(error);
  }
);

export default api;
