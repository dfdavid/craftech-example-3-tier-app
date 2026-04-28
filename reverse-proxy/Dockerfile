FROM nginx:stable-alpine

# eliminar configuracion por defecto
RUN rm /etc/nginx/conf.d/default.conf

# copiar configuraciones base
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY templates/ /etc/nginx/templates/

# copia los certs si existen localmente (build manual). 
# en CI/CDestan ignorados por git, solo copiara el .gitkeep si existe.
COPY certs/ /etc/nginx/certs/

# entrpoint para inyeccion de secretos en runtime
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
