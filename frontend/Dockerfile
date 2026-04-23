# stage 1: build
FROM node:16-alpine AS build

WORKDIR /usr/src/app

# instalacion de dependencias (se copia package.json primero para aprovechar cache)
COPY package.json package-lock.json* ./
RUN npm install --silent

# copia del codigo fuente y compilacion
COPY . .
RUN npm run build

# stage 2: production
FROM nginx:stable-alpine

# copiar archivos compilados al directorio de nginx
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# exposicion del puerto estandar de nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
