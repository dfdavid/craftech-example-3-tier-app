import pytest
import requests

BASE_URL = "http://localhost:8000/api/users"

def test_backend_is_up():
    """verifica que el servidor web responda."""
    try:
        # una peticion GET al prefijo debe responder (incluso con 404 o 405)
        response = requests.get(BASE_URL)
        # si el servidor responde, el backend esta arriba
        assert response.status_code in [200, 404, 405]
    except requests.exceptions.ConnectionError:
        pytest.fail("el backend no esta escuchando en el puerto 8000")

def test_database_is_up():
    """verifica que el backend pueda consultar la base de datos."""
    payload = {
        "email": "healthcheck@craftech.io",
        "password": "temporary_password"
    }
    try:
        # login requiere consultar la tabla de usuarios en la DB
        response = requests.post(f"{BASE_URL}/login", json=payload)
        
        # si la DB esta caida, Django lanza un 500 (OperationalError)
        # si la DB esta arriba, respondera 401 (Unauthorized) o similar por credenciales invalidas
        assert response.status_code != 500, "la base de datos no responde (error 500)"
        assert response.status_code in [400, 401, 403], f"respuesta inesperada: {response.status_code}"
        
    except requests.exceptions.RequestException as e:
        pytest.fail(f"error de conexion: {e}")
