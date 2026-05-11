NaaN

¿COMO DESPLEGARLO?

El despliegue de NaaN se realiza en local mediante Docker. Con Docker Desktop en ejecución, basta con ejecutar el siguiente comando en la raíz del proyecto:

"docker compose up --build"

Esto construye las imágenes y levanta tres contenedores: uno para la base de datos MySQL (naan-bd), otro para el backend Laravel (naan-backend) y otro para el frontend Angular (naan-frontend).
Además, se crean dos volúmenes persistentes: naan_bd_data, que almacena los datos de la base de datos, y naan_storage, que guarda los archívos subidos por los usuarios.

Una vez iniciados, la aplicaión es accesible en http://localhost:4200

(También recordar que no esta en este github las claves de Groq ni de Stripe, tampoco cuenta con el .env coon credenciales ni con los node_modules necesarios para ejecutar la aplicación)
