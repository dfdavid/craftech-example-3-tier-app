# documentacion de uso - frontend (react)

## descripcion general
el frontend es una single page application (spa) desarrollada con react. proporciona una interfaz administrativa para la gestion de usuarios y visualizacion de datos.

## requisitos previos
- node.js (version 17 recomendada segun registros de infraestructura)
- npm o yarn

## instalacion
1. navegar al directorio del frontend:
   ```bash
   cd frontend
   ```
2. instalar dependencias:
   ```bash
   npm install
   ```

## configuracion
la conexion con el backend se configura en el archivo `src/config/constant.js`:
- `API_SERVER`: define la url base de la api (por defecto `http://localhost:8000/api/`).

## ejecucion
- **desarrollo:** inicia el servidor local con recarga automatica.
  ```bash
  npm start
  ```
  la aplicacion estara disponible en `http://localhost:3000`.

- **produccion:** compila la aplicacion para su despliegue.
  ```bash
  npm run build
  ```

## estructura de rutas
| ruta | acceso | componente |
| :--- | :--- | :--- |
| `/auth/signin` | publico | inicio de sesion. |
| `/auth/signup` | publico | registro de usuario. |
| `/app/dashboard/default` | protegido | panel principal (requiere login). |

## tecnologias principales
- **estado global:** redux con @reduxjs/toolkit.
- **formularios:** formik y yup para validacion.
- **estilos:** sass (scss) y react-bootstrap.
- **cliente http:** axios.
