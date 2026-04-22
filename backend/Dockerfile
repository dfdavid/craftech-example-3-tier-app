# ---------- STAGE 1: build ----------
FROM python:3.8.3-alpine AS builder

WORKDIR /usr/src/app

RUN apk add --no-cache \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib-dev

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ---------- STAGE 2: runtime ----------
FROM python:3.8.3-alpine

WORKDIR /usr/src/app

# evita que Python genere .pyc, reduce archivos innecesarios
ENV PYTHONDONTWRITEBYTECODE=1  
# mejora la visualizacion de logs evitando retrasos
ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache postgresql-client

# copiar solo lo necesario desde builder
COPY --from=builder /install /usr/local

COPY . .

RUN adduser -D user && chown -r user:user /usr/src/app
USER user

ENTRYPOINT ["sh", "/usr/src/app/entrypoint.sh"]
