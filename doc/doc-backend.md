# documentacion de uso - backend (django)

## descripcion general
el backend es una api rest construida con django y django rest framework (drf). gestiona la logica de negocio, la autenticacion de usuarios mediante jwt y la persistencia de datos en postgresql.

## requisitos previos
- python 3.8+
- postgresql
- pip (gestor de paquetes de python)

## instalacion
1. navegar al directorio del backend:
   ```bash
   cd backend
   ```
2. instalar dependencias:
   ```bash
   pip install -r requirements.txt
   ```

## configuracion de base de datos
el sistema espera una base de datos postgresql. las credenciales se configuran en `core/settings.py` o mediante variables de entorno en el archivo `.env.postgres`.

## ejecucion de la aplicacion
1. ejecutar migraciones:
   ```bash
   python manage.py migrate
   ```
2. cargar datos de prueba:
   ```bash
   python manage.py loaddata api/fixtures/initial_data.json
   ```
3. iniciar servidor de desarrollo:
   ```bash
   python manage.py runserver
   ```

## referencia de la api
la api esta disponible en `http://localhost:8000/api/users/`.

| endpoint | metodo | descripcion |
| :--- | :--- | :--- |
| `register` | post | crea una nueva cuenta de usuario. |
| `login` | post | autentica al usuario y devuelve un token. |
| `logout` | post | invalida la sesion actual. |
| `checkSession` | get | verifica si la sesion del usuario es valida. |
| `edit` | get/put | permite ver y editar el perfil del usuario. |

## pruebas
para ejecutar los tests automatizados:
```bash
pytest
```
