import { api } from '@/lib/axios';
import type { AxiosResponse } from 'axios';

/**
 * Tipos para el carrito
 */
export interface CartItemResponse {
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
    stock: number;
  };
}

export interface CartResponse {
  items: CartItemResponse[];
  total: number;
}

export interface AddToCartRequest {
  gpu_id: number;
  quantity: number;
}

/**
 * Servicio para operaciones del carrito
 * IMPORTANTE: Todas las requests deben incluir el header session_id
 */
export const cartService = {
  /**
   * Obtener el carrito actual
   */
  async getCart(sessionId: string): Promise<CartResponse> {
    const response: AxiosResponse<CartResponse> = await api.get('/cart', {
      headers: { session_id: sessionId },
    });
    return response.data;
  },

  /**
   * Agregar item al carrito
   */
  async addToCart(sessionId: string, data: AddToCartRequest): Promise<CartItemResponse> {
    const response: AxiosResponse<CartItemResponse> = await api.post('/cart', data, {
      headers: { session_id: sessionId },
    });
    return response.data;
  },

  /**
   * Actualizar cantidad de un item
   */
  async updateCartItem(
    sessionId: string,
    itemId: number,
    quantity: number
  ): Promise<CartItemResponse> {
    const response: AxiosResponse<CartItemResponse> = await api.put(
      `/cart/${itemId}`,
      { quantity },
      { headers: { session_id: sessionId } }
    );
    return response.data;
  },

  /**
   * Eliminar item del carrito
   */
  async removeFromCart(sessionId: string, itemId: number): Promise<void> {
    await api.delete(`/cart/${itemId}`, {
      headers: { session_id: sessionId },
    });
  },

  /**
   * Limpiar carrito completo
   */
  async clearCart(sessionId: string): Promise<void> {
    await api.delete('/cart', {
      headers: { session_id: sessionId },
    });
  },
};

export default cartService;
