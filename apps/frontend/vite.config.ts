import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  
  // ═══════════════════════════════════════════════════════════════════════
  // Server Config (solo para dev local, no afecta producción)
  // ═══════════════════════════════════════════════════════════════════════
  server: {
    host: '0.0.0.0',  // Crucial para Docker
    port: 5173,
    watch: {
      usePolling: true,  // Necesario para hot reload en Docker
    },
  },
  
  // ═══════════════════════════════════════════════════════════════════════
  // Build Config (producción)
  // ═══════════════════════════════════════════════════════════════════════
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,  // Desactivar sourcemaps en prod para reducir tamaño
    
    // Optimizaciones
    minify: 'terser',
    terserOptions: {
      compress: {
        drop_console: true,  // Remover console.log en producción
        drop_debugger: true,
      },
    },
    
    // Code splitting
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom', 'react-router-dom'],
        },
      },
    },
    
    // Chunk size warnings
    chunkSizeWarningLimit: 1000,
  },
  
  // ═══════════════════════════════════════════════════════════════════════
  // Preview Config (para testing del build)
  // ═══════════════════════════════════════════════════════════════════════
  preview: {
    host: '0.0.0.0',
    port: 4173,
  },
})