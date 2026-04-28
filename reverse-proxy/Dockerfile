FROM nginx:stable-alpine

# eliminar configuracion por defecto
RUN rm /etc/nginx/conf.d/default.conf

# copiar configuraciones
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY templates/ /etc/nginx/templates/
COPY certs/ /etc/nginx/certs/

# los logs seguiran yendo a stdout/stderr por defecto en la imagen base
