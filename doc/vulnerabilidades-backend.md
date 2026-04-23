# informe de vulnerabilidades - backend

este documento detalla hallazgos criticos detectados durante la auditoria de infraestructura y pruebas de integracion. se recomienda su revision por parte del equipo de desarrollo.

## 1. debilidades en la logica de autorizacion
- **endpoint:** `/api/users/edit`
- **hallazgo:** el viewset `UserViewSet` permite la edicion de perfiles mediante el parametro `userID` enviado en el cuerpo de la peticion (POST).
- **riesgo:** un usuario autenticado podria modificar datos de otros usuarios si conoce o adivina su identificador numerico. la validacion `self.request.user.pk != int(user_id)` en el metodo `create` podria no ser suficiente si el middleware de autenticacion no esta sincronizado con la logica del viewset.
- **recomendacion:** el identificador del usuario a editar debe obtenerse directamente del token de sesion (`request.user`) y no de un parametro externo enviado por el cliente.

## 2. gestion de sesiones y tokens jwt
- **hallazgo:** la `SECRET_KEY` de django se encuentra definida por defecto en `core/settings.py` con un valor estatico.
- **riesgo:** si la clave es conocida, es posible falsificar tokens de sesion (JWT) y suplantar cualquier identidad en el sistema.
- **recomendacion:** extraer la `SECRET_KEY` a una variable de entorno obligatoria en entornos de produccion.

## 3. manejo de multiples sesiones activas
- **hallazgo:** el endpoint `/logout` utiliza `ActiveSession.objects.get(user=user)`.
- **riesgo:** si un usuario inicia sesion desde multiples dispositivos o navegadores, se generan multiples registros en la tabla `ActiveSession`. el metodo `.get()` lanzara una excepcion `MultipleObjectsReturned`, provocando un error 500 del servidor y bloqueando la capacidad del usuario para cerrar sesion de forma controlada.
- **recomendacion:** cambiar la logica a `.filter(token=token).delete()` para invalidar la sesion especifica que realiza la peticion.

## 4. configuracion de cors
- **hallazgo:** la lista `CORS_ALLOWED_ORIGINS` incluye `localhost` y `127.0.0.1`.
- **riesgo:** aunque es aceptable para desarrollo, mantener estas entradas en produccion permite ataques desde scripts locales maliciosos.
- **recomendacion:** implementar una gestion dinamica de origenes permitidos basada en el entorno de despliegue.
