# NaaN

## ¿Cómo desplegarlo?

El despliegue de NaaN se realiza en **local mediante Docker**.

### Prerrequisitos

Antes de empezar, asegúrate de tener:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) instalado y **en ejecución**
- Las claves de **Groq** y **Stripe** (no incluidas en este repositorio)
- Un archivo **`.env`** con las credenciales necesarias (no incluido en este repositorio)

---

### Pasos para el despliegue

**1. Instalar dependencias del frontend**

```bash
cd tfg-frontend
npm install
```

**2. Instalar dependencias del backend**

```bash
cd tfg-backend
npm install
```

**3. Construir y levantar los contenedores**

Desde la **raíz del proyecto**, con Docker Desktop en ejecución:

```bash
docker compose up --build
```

Esto levantará tres contenedores:

| Contenedor | Descripción |
|---|---|
| `naan-bd` | Base de datos MySQL |
| `naan-backend` | Backend Laravel |
| `naan-frontend` | Frontend Angular |

También se crean dos volúmenes persistentes:
- **`naan_bd_data`** — almacena los datos de la base de datos
- **`naan_storage`** — guarda los archivos subidos por los usuarios

**4. Acceder a la aplicación**

Una vez iniciados los contenedores, la aplicación estará disponible en:
http://localhost:4200

---

>  **Nota:** Este repositorio **no incluye** las claves de Groq ni de Stripe, el archivo `.env` con credenciales, ni los `node_modules`. Es necesario completar los pasos 1 y 2 antes de proceder con el despliegue.
