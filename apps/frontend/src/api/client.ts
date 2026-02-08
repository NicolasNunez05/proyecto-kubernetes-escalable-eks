import axios from 'axios';

const client = axios.create({
  // En producción (K8s), usa el proxy de Nginx (/api)
  // En local (docker-compose), usa variable de entorno
  baseURL: import.meta.env.VITE_API_URL || '/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default client;
