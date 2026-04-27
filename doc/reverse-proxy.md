# reverse proxy - nginx con templates

## descripcion general
el servicio de proxy reverso utiliza una imagen de nginx oficial configurada para el uso de plantillas y variables de entorno. actua como punto unico de entrada para el trafico http (80) y https (443).

## funcionamiento 
el despliegue se basa en la funcionalidad nativa de la imagen oficial de nginx para procesar plantillas:

1. **directorio de plantillas**: los archivos ubicados en `./reverse-proxy/templates/*.template` son procesados al iniciar el contenedor.
2. **envsubst**: el script de inicio busca variables con el formato `${VARIABLE}` y las reemplaza por los valores definidos en el archivo `.env` o el entorno del sistema.
3. **generacion de archivos**: el resultado se guarda automaticamente en `/etc/nginx/conf.d/` con extension `.conf`.
4. **inclusion**: el archivo principal `/etc/nginx/nginx.conf` carga todos los archivos `.conf` generados, activando las reglas de ruteo.

## configuracion de servicios
para agregar una nueva aplicacion al proxy:

1. crear un archivo `.template` en `reverse-proxy/templates/`.
2. definir un bloque `server` con un `server_name` unico (ej. app2.craftech.local).
3. configurar los bloques `location` apuntando a los servicios internos de la red de docker.
4. declarar las variables de entorno necesarias en el archivo `.env` de la raiz.

## ssl y seguridad
el proxy esta configurado para forzar conexiones seguras y manejar certificados tls validos:

- **redireccion automatica:** el puerto 80 redirige a https (301) y las peticiones http accidentales al puerto 443 son capturadas (error 497) y redirigidas a https.

- **ubicacion:** los certificados deben copiarse a `./reverse-proxy/certs/` como `certificado.crt` y `clave_privada.key` respectivamente.

## logs
los logs de acceso y error se persisten en `./reverse-proxy/logs/` para facilitar la auditoria y el troubleshooting sin necesidad de ingresar al contenedor.
