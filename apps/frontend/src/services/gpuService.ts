/**
 * 🎯 QUÉ HACE: Llama al backend, maneja respuestas
 * 📍 CUÁNDO SE USA: Componentes hacen fetchGPUs()
 */
import api from './api';
import { GPU, GPUFilter } from '../types/gpu';

export const fetchGPUs = async (filters?: GPUFilter): Promise<GPU[]> => {
  const params = new URLSearchParams();
  
  if (filters?.brand) params.append('brand', filters.brand.join(','));
  if (filters?.vram_min) params.append('vram_min', String(filters.vram_min));
  // ... más filtros
  
  const response = await api.get(`/api/gpus?${params}`);
  return response.data.gpus;
};

export const uploadGPUImage = async (gpuId: number, file: File) => {
  const formData = new FormData();
  formData.append('file', file);
  
  await api.post(`/api/admin/gpus/${gpuId}/upload`, formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  });
};
