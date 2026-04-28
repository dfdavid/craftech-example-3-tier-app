#!/bin/sh
set -e

# Directorio de certificados
CERT_DIR="/etc/nginx/certs"
CERT_FILE="$CERT_DIR/${NGINX_CERT:-certificado.crt}"
KEY_FILE="$CERT_DIR/${NGINX_KEY:-clave_privada.key}"

mkdir -p "$CERT_DIR"

# Prioridad 1: Inyeccion por variables de entorno (util en CI/CD)
if [ -n "$NGINX_CERT_CONTENT" ]; then
    echo "Inyectando certificado desde variable de entorno..."
    printf "%b" "$NGINX_CERT_CONTENT" > "$CERT_FILE"
fi

if [ -n "$NGINX_KEY_CONTENT" ]; then
    echo "Inyectando clave privada desde variable de entorno..."
    printf "%b" "$NGINX_KEY_CONTENT" > "$KEY_FILE"
fi

# Validacion: Si no se inyectaron y no existen fisicamente, mostrar advertencia
if [ ! -f "$CERT_FILE" ]; then
    echo "ERROR: No se encontro el certificado en $CERT_FILE ni se proporciono NGINX_CERT_CONTENT"
fi

# Ejecutar el entrypoint original de Nginx
exec /docker-entrypoint.sh "$@"
