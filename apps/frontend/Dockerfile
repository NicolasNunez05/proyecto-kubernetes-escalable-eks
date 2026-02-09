# ═══════════════════════════════════════════════════════════════════════════
# STAGE 1: BUILD (Node.js)
# ═══════════════════════════════════════════════════════════════════════════
FROM node:20-alpine AS builder

# Metadata
LABEL maintainer="Nicolas Nunez <nicolasnunezalvarez@gmail.com>"
LABEL description="GpuChile Frontend - React + Vite Build Stage"

# Set working directory
WORKDIR /app

# Copiar package files primero (caching layer optimization)
COPY package*.json ./

# Install dependencies (con npm ci para builds reproducibles)
RUN npm ci --no-audit --no-fund

# Copiar código fuente
COPY . .

# Build argument para VITE_API_URL
ARG VITE_API_URL=http://localhost:8000/api
ENV VITE_API_URL=${VITE_API_URL}

# Build de producción
RUN npm run build

# Verificar que el build fue exitoso
RUN ls -la /app/dist && \
    test -f /app/dist/index.html || (echo "Build failed: index.html not found" && exit 1)

# ═══════════════════════════════════════════════════════════════════════════
# STAGE 2: PRODUCTION (Nginx Alpine)
# ═══════════════════════════════════════════════════════════════════════════
FROM nginx:1.25-alpine

# Metadata
LABEL maintainer="Nicolas Nunez <nicolasnunezalvarez@gmail.com>"
LABEL description="GpuChile Frontend - Production Nginx Server"

# Instalar curl para health checks
RUN apk add --no-cache curl

# Copiar custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar archivos estáticos desde el stage de build
COPY --from=builder /app/dist /usr/share/nginx/html

# Verificar que los archivos se copiaron correctamente
RUN ls -la /usr/share/nginx/html && \
    test -f /usr/share/nginx/html/index.html || (echo "Copy failed: index.html not found" && exit 1)

# Crear directorio de logs si no existe
RUN mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    touch /var/log/nginx/error.log

# Exponer puerto
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Comando por defecto (nginx en foreground)
CMD ["nginx", "-g", "daemon off;"]
