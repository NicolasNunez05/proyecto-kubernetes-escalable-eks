/**
 * Interfaz GPU basada en el modelo del backend
 * Debe coincidir con la respuesta de FastAPI
 */
export interface GPU {
  id: number;
  name: string;
  brand: string;
  model: string;
  price: number;
  stock: number;
  vram: number;
  cuda_cores: number | null;
  image_url: string | null;
  description: string | null;
  created_at: string; // ISO 8601 datetime
}

/**
 * Filtros para búsqueda de GPUs
 */
export interface GPUFilters {
  brand?: string;
  minPrice?: number;
  maxPrice?: number;
  minVram?: number;
}

/**
 * Query params para paginación
 */
export interface GPUQueryParams {
  skip?: number;
  limit?: number;
  brand?: string;
}
