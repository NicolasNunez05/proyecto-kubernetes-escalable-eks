/**
 * 🎯 QUÉ HACE: Define tipos para TypeScript
 * 📍 CUÁNDO SE USA: Autocompletado y validación
 */
export interface GPU {
  id: number;
  model: string;
  brand: 'NVIDIA' | 'AMD' | 'Intel';
  series?: string;
  vram: number;
  price: number;
  stock: number;
  image_url: string;
  thumbnail_url: string;
  created_at: string;
}

export interface GPUFilter {
  brand?: string[];
  vram_min?: number;
  vram_max?: number;
  price_min?: number;
  price_max?: number;
  in_stock?: boolean;
  sort?: 'price_asc' | 'price_desc' | 'vram_desc';
  limit?: number;
  offset?: number;
}