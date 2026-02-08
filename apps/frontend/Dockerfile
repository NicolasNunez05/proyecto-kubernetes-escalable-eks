# CAMBIO: Usamos 'slim' (Debian) en lugar de 'alpine' para evitar errores de binarios (musl vs glibc)
FROM node:20-slim AS base

# No necesitamos apk add libc6-compat porque Debian ya usa glibc
WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependencias ignorando conflictos de versiones
RUN npm install --legacy-peer-deps

# Copiar código fuente
COPY . .

# Exponer puerto de desarrollo
EXPOSE 5173

# Comando para desarrollo con hot reload
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]