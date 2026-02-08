import { api } from '@/lib/axios';
import type { GPU, GPUQueryParams } from '@/types/gpu';
import type { AxiosResponse } from 'axios';

/**
 * Servicio para operaciones CRUD de GPUs
 */
export const gpuService = {
  /**
   * Obtener lista de GPUs con filtros opcionales
   */
  async getGpus(params?: GPUQueryParams): Promise<GPU[]> {
    const response: AxiosResponse<GPU[]> = await api.get('/gpus', { params });
    return response.data;
  },

  /**
   * Obtener GPU por ID
   */
  async getGpuById(id: number): Promise<GPU> {
    const response: AxiosResponse<GPU> = await api.get(`/gpus/${id}`);
    return response.data;
  },

  /**
   * Buscar GPUs por brand
   */
  async getGpusByBrand(brand: string): Promise<GPU[]> {
    const response: AxiosResponse<GPU[]> = await api.get('/gpus', {
      params: { brand },
    });
    return response.data;
  },
};

export default gpuService;
