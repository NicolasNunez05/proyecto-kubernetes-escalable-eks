export interface GPU {
  id: number;
  model: string;
  brand: string;
  series?: string;
  vram: number;
  price: number;
  stock: number;
  image_url?: string;
  thumbnail_url?: string;
  is_featured: boolean;
}
