/**
 * Respuestas genéricas de API
 */

export interface ApiResponse<T> {
  data: T;
  message?: string;
}

export interface ApiError {
  detail: string;
  status?: number;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  skip: number;
  limit: number;
}

/**
 * Auth types
 */
export interface User {
  id: number;
  email: string;
  username: string;
  role: 'admin' | 'customer';
  created_at: string;
}

export interface LoginCredentials {
  username: string;
  password: string;
}

export interface AuthResponse {
  access_token: string;
  token_type: string;
  user: User;
}

/**
 * Cart types
 */
export interface CartItem {
  id: number;
  gpu_id: number;
  quantity: number;
  gpu: {
    id: number;
    name: string;
    brand: string;
    model: string;
    price: number;
    image_url: string | null;
  };
}

export interface CartResponse {
  items: CartItem[];
  total: number;
}
