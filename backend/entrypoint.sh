#!/bin/sh

# esperar a que la base de datos este lista
if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."
    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done
    echo "PostgreSQL started"
fi

# aplicar migraciones pendientes (operacion segura e idempotente)
python manage.py migrate --no-input

# cargar datos iniciales si es necesario (evitar flush en produccion)
# python manage.py loaddata initial_data.json

# si el comando recibido es el de inicio por defecto, ejecutar gunicorn
if [ "$#" -eq 0 ]; then
    echo "Starting Gunicorn..."
    exec gunicorn core.wsgi:application --bind 0.0.0.0:8000 --workers 3
fi

# permitir ejecucion de comandos alternativos (ej. shell, tests)
exec "$@"
