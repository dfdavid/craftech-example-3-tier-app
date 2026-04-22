# use un alias para multi-stage build (opcional pero util para claridad)
FROM python:3.8.3-alpine 
WORKDIR /usr/src/app
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# instalacion de dependencias de sistema y python en un solo paso para reducir capas
RUN apk add --no-cache postgresql-client && \
    apk add --no-cache --virtual .tmp-build-deps \
    gcc \
    libc-dev \
    linux-headers \
    postgresql-dev \
    musl-dev \
    zlib \
    zlib-dev

COPY ./requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del --no-cache .tmp-build-deps

# configuracion final
COPY ./entrypoint.sh .
RUN chmod +x ./entrypoint.sh

COPY . .

# seguridad: evitar correr como root
RUN adduser -D user
USER user

ENTRYPOINT ["sh", "/usr/src/app/entrypoint.sh"]