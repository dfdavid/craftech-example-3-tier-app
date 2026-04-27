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
la aplicacion se configura dinamicamente durante el proceso de construccion (build-time) mediante variables de entorno:

- **archivo .env:** en la raiz del directorio `frontend/`, se debe definir `REACT_APP_API_SERVER`.
  ```ini
  # ejemplo para entorno con ssl
  REACT_APP_API_SERVER=https://dominio.com/api/
  ```
- **docker build:** el `Dockerfile` utiliza el argumento `REACT_APP_API_SERVER` para inyectar la url de la api en el bundle estatico.
- **desarrollo:** si no se define la variable, el sistema utiliza `http://localhost:8000/api/` como valor por defecto definido en `src/config/constant.js`.

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
