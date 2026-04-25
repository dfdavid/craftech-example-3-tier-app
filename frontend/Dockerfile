# stage 1: build
FROM node:lts-alpine3.22 AS build

WORKDIR /usr/src/app

# instalacion de dependencias
COPY package.json package-lock.json* ./
RUN npm install --silent

# copia del codigo fuente y compilacion
COPY . .
RUN npm run build

# stage 2: production
FROM nginx:stable-alpine-slim

# copiar archivos compilados al directorio de nginx
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# exposicion del puerto estandar de nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
