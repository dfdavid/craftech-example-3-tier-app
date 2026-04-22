# stage 1: builder (instalacion de deps pesadas)
FROM python:3.8.3-alpine AS builder

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# herramientas de compilacion para psycopg2 y gunicorn
RUN apk add --no-cache \
    postgresql-client \
    gcc \
    libc-dev \
    linux-headers \
    postgresql-dev \
    musl-dev \
    zlib \
    zlib-dev

# instalacion en directorio local para copiar luego
COPY ./requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --prefix=/usr/local -r requirements.txt


# stage 2: final (imagen liviana para ejecucion)
FROM python:3.8.3-alpine

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# solo las bibliotecas compartidas de runtime (livianas)
RUN apk add --no-cache postgresql-client libpq zlib

# copiar los paquetes de python compilados desde el builder
COPY --from=builder /usr/local /usr/local

# configuracion de usuario no-root
RUN adduser -D user
RUN chown -R user:user /usr/src/app

COPY --chown=user:user . .
RUN chmod +x ./entrypoint.sh

USER user

ENTRYPOINT ["sh", "/usr/src/app/entrypoint.sh"]
