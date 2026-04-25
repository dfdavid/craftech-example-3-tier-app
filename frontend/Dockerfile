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

# copiar archivos compilados
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# user no root, port 8080, redireccion de rutas desconocidas a index.html
RUN sed -i 's/listen\(.*\)80;/listen 8080;/g' /etc/nginx/conf.d/default.conf && \
    sed -i '/location \/ {/a \        try_files $uri $uri/ /index.html;' /etc/nginx/conf.d/default.conf && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /usr/share/nginx/html /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
