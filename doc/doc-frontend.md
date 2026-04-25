# documentacion de uso - frontend (react)

## descripcion general
el frontend es una single page application (spa) desarrollada con react. proporciona una interfaz administrativa para la gestion de usuarios y visualizacion de datos.

al revisar su package.json, se observa el uso de react-scripts. esto confirma que es una single page application (spa). una
  vez ejecutado npm run build, la aplicacion se convierte en una carpeta de archivos estaticos. 

  por lo tanto, el enfoque de nginx (Dockerfile.new) es el mas robusto, liviano y profesional para este caso, ya que elimina
  el overhead de node.js y resuelve definitivamente el problema de los descriptores de archivos (emfile) al no requerir un
  servidor de desarrollo.

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
