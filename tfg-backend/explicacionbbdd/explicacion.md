# Base de datos `naan_bbdd`

## AUDITORIA
- Se actualiza automáticamente al registrar cambios en **Pedido**, **Producto** o **Categoría**.
- Sus registros se eliminan automáticamente cada **1 año** mediante un evento programado.
- Almacena: tabla afectada, id del registro, operación (`INSERT`, `UPDATE`, `DELETE`), datos anteriores, datos nuevos y fecha.
- **Importante:** sirve para trazabilidad y control de cambios.


## Usuario
- Contiene los datos de cada usuario, incluyendo **rol** (cliente/admin).
- Se utiliza para permisos y asociaciones con otras tablas.

## Metodo_Pago
- Métodos de pago asociados a un cliente.
- Solo un método por usuario puede ser **predeterminado** (`es_predeterminado = TRUE`).

## Dirección
- Direcciones de envío asociadas a un usuario.
- FK hacia `Usuario`.
- Permite múltiples direcciones por usuario.

## Avatar_3D
- Datos sobre el avatar 3D asociado a un usuario: pecho, cintura, cadera, estatura, peso, edad, talla.
- FK hacia `Usuario`.  
- No es unique, por si se decide permitir cambiar el avatar en el futuro, aunque la política actual permite **uno por usuario**.

## Producto
- Productos disponibles en la tienda.
- **Soft delete:** no se pueden eliminar directamente; se marcan como inactivos (`activo = FALSE`).
- Productos inactivos se eliminan automáticamente tras **3 años**.
- `eliminado_en`:
  - Se guarda como `NULL` por defecto.
  - **Trigger automático:** actualiza la fecha cuando se desactiva, y vuelve a `NULL` si se reactiva.
- FK hacia `Categoria`.

## Categoría
- Categorías de productos.
- Asociadas a productos para organización y filtrado.

## Favorito
- Productos favoritos por usuario.
- **Doble clave primaria:** `id_usuario` + `id_producto`.
- FK hacia `Usuario` y `Producto`.

## Carrito
- Carrito asociado a un usuario (**uno por cuenta**).
- `total` calculado automáticamente sumando los productos en `detalle_carrito`.
- **Importante:** para resetear el carrito tras un pedido, se deben eliminar los productos de `detalle_carrito`.

## Detalle_Carrito
- Productos individuales del carrito con cantidad y precio unitario.
- FK hacia `Carrito` y `Producto`.

## Pedido
- Almacena todos los datos de un pedido.
- `total` calculado automáticamente sumando los productos de `detalle_pedido`.
- **Nota:** el total **no incluye gastos de envío**.
- FK hacia `Usuario`, `Metodo_Pago` y `Direccion`.

## Detalle_Pedido
- Productos individuales de cada pedido.
- FK hacia `Pedido` y `Producto`.

## Historial_Estado_Pedido
- Almacena los cambios de estado de cada pedido junto con la fecha.
- Permite trazabilidad de los pedidos.
- FK hacia `Pedido`.

---

## PASSWORD_RESET_TOKENS
- Almacena los tokens generados cuando un usuario solicita restablecer su contraseña.
- Se utiliza en el proceso de recuperación de contraseña para validar la identidad del usuario.
- El token tiene validez temporal.
- No guarda relación mediante clave foránea, ya que se basa en el email del usuario.
  
---

## PERSONAL_ACCESS_TOKENS
- Tabla utilizada por Laravel Sanctum para la autenticación de la API mediante Bearer Token.
- Permite que un usuario tenga múltiples sesiones activas (por ejemplo, móvil y navegador).
- Se usa para validar peticiones autenticadas en la API.
- Permite definir permisos mediante el campo abilities.
  
---

## MIGRATIONS
- Controla las migraciones ejecutadas en la base de datos.
- Laravel la utiliza para saber qué cambios estructurales ya han sido aplicados.
- Es una tabla interna del framework y no interviene en la lógica del negocio.
  
---

## FAILED_JOBS
- Almacena los trabajos en cola que han fallado.
- Permite depurar errores y reintentar procesos.
- Se usa cuando la aplicación trabaja con colas (queues).
  
---

## JOBS
- Guarda los trabajos pendientes en el sistema de colas.
- Se utiliza para procesos asíncronos como envío de correos, notificaciones o tareas pesadas.
- Solo se usa si el driver de colas está configurado en base de datos.
  
---

## JOB_BATCHES
- Permite agrupar múltiples trabajos en lote.
- Gestiona el estado global de un conjunto de procesos en cola.
- Facilita el control de ejecución masiva de tareas.
  
---

## SESSIONS
- Almacena las sesiones de usuario cuando el driver de sesión está configurado en base de datos.
- En una API REST pura normalmente no se utiliza, ya que se trabaja con tokens.
- Incluye información como IP, user agent y actividad.
  
---

## CACHE
- Tabla utilizada cuando el sistema de caché está configurado para usar base de datos.
- Permite almacenar datos temporales para mejorar rendimiento.

---

## CACHE_LOCKS
- Gestiona bloqueos para evitar problemas de concurrencia en operaciones simultáneas.
- Funciona junto con la tabla CACHE.

---

## Puntos importantes extra
- Los datos que se buscan con frecuencia están **indexados**.
- Hay dos usuarios con permisos en la base de datos:
  - `nadmin` → administrador, gestiona todo.
  - `naan_user` → cliente, acceso limitado para la web.
- Se utilizan triggers y eventos para:
  - Actualizar totales de carrito y pedido.
  - Mantener auditoría y control de métodos de pago predeterminados.
  - Gestionar soft delete y eliminación automática de productos inactivos.

 # Resumen de tablas

## AUDITORIA
- id_auditoria (INT, PK, AUTO_INCREMENT)  
- tabla_afectada (VARCHAR(100))  
- id_registro (INT)  
- operacion (ENUM: INSERT, UPDATE, DELETE)  
- datos_anteriores (JSON)  
- datos_nuevos (JSON)  
- fecha (DATETIME, DEFAULT CURRENT_TIMESTAMP)  

---

## USUARIO
- id_usuario (INT, PK, AUTO_INCREMENT)  
- nombre (VARCHAR(100))  
- email (VARCHAR(150), UNIQUE)  
- contrasena (VARCHAR(255))  
- rol (VARCHAR(50))  
- telefono (VARCHAR(20))
- fecha_nacimiento (DATE)
- fecha_registro (DATETIME, DEFAULT CURRENT_TIMESTAMP)  

---

## METODO_PAGO
- id_metodo_pago (INT, PK, AUTO_INCREMENT)  
- id_usuario (INT, FK → usuario)  
- tipo (ENUM: paypal, tarjeta, bizum, google_pay)  
- numero_enmascarado (VARCHAR(50))  
- es_predeterminado (TINYINT(1), DEFAULT 0)  
- fecha_expiracion (DATE)  

---

## DIRECCION
- id_direccion (INT, PK, AUTO_INCREMENT)  
- id_usuario (INT, FK → usuario)  
- calle (VARCHAR(150))  
- numero (VARCHAR(20))  
- ciudad (VARCHAR(100))  
- provincia (VARCHAR(100))  
- codigo_postal (VARCHAR(10))  
- pais (VARCHAR(100))  

---

## AVATAR_3D
- id_avatar (INT, PK, AUTO_INCREMENT)  
- id_usuario (INT, FK → usuario)  
- pecho (DECIMAL)  
- cintura (DECIMAL)  
- cadera (DECIMAL)  
- estatura (DECIMAL)  
- peso (DECIMAL)  
- edad (INT)  
- talla (VARCHAR(10))  

---

## PRODUCTO
- id_producto (INT, PK, AUTO_INCREMENT)  
- nombre (VARCHAR(150))  
- descripcion (TEXT)  
- id_categoria (INT, FK → categoria)  
- activo (TINYINT(1), DEFAULT 1)  
- color (VARCHAR(50))
- talla (ENUM('XS','S','M','L','XL','XXL'))
- sexo (ENUM('hombre','mujer'))
- eliminado_en (DATETIME, NULL)  
- precio (DECIMAL(10,2))  
- stock (INT, DEFAULT 0)  
- imagen (VARCHAR(255))  

---

## CATEGORIA
- id_categoria (INT, PK, AUTO_INCREMENT)  
- nombre (VARCHAR(100))  
- descripcion (TEXT)  

---

## FAVORITO
- id_usuario (INT, FK → usuario, PK)  
- id_producto (INT, FK → producto, PK)  

---

## CARRITO
- id_carrito (INT, PK, AUTO_INCREMENT)  
- id_usuario (INT, FK → usuario, UNIQUE)  
- total (DECIMAL(10,2), DEFAULT 0)  

---

## DETALLE_CARRITO
- id_detalle_carrito (INT, PK, AUTO_INCREMENT)  
- id_carrito (INT, FK → carrito)  
- id_producto (INT, FK → producto)  
- cantidad (INT)  
- precio_unitario (DECIMAL(10,2))  

---

## PEDIDO
- id_pedido (INT, PK, AUTO_INCREMENT)  
- id_usuario (INT, FK → usuario)  
- id_metodo_pago (INT, FK → metodo_pago)  
- id_direccion (INT, FK → direccion)  
- fecha (DATETIME, DEFAULT CURRENT_TIMESTAMP)  
- gastos_envio (DECIMAL(10,2), DEFAULT 0)  
- total (DECIMAL(10,2))  
- codigo_seguimiento (VARCHAR(100))  
- estado (ENUM: pendiente, pagado, enviado, entregado, cancelado, DEFAULT pendiente)  

---

## DETALLE_PEDIDO
- id_detalle_pedido (INT, PK, AUTO_INCREMENT)  
- id_pedido (INT, FK → pedido)  
- id_producto (INT, FK → producto)  
- cantidad (INT)  
- precio_en_el_momento (DECIMAL(10,2))  

---

## HISTORIAL_ESTADO_PEDIDO
- id_historial (INT, PK, AUTO_INCREMENT)  
- id_pedido (INT, FK → pedido)  
- estado (VARCHAR(50))  
- comentario (TEXT)  
- fecha (DATETIME, DEFAULT CURRENT_TIMESTAMP)  

---

## PASSWORD_RESET_TOKENS
- email (VARCHAR(255), PK)
- token (VARCHAR(255))
- created_at (DATETIME, NULL)

## PERSONAL_ACCESS_TOKENS
- id (BIGINT, PK, AUTO_INCREMENT)
- tokenable_type (VARCHAR(255))
- tokenable_id (BIGINT)
- name (VARCHAR(255))
- token (VARCHAR(64), UNIQUE)
- abilities (TEXT, NULL)
- last_used_at (DATETIME, NULL)
- expires_at (DATETIME, NULL)
- created_at (DATETIME)
- updated_at (DATETIME)

## MIGRATIONS
- id (INT, PK, AUTO_INCREMENT)
- migration (VARCHAR(255))
- batch (INT)

---

## FAILED_JOBS
- id (BIGINT, PK, AUTO_INCREMENT)
- uuid (VARCHAR(255), UNIQUE)
- connection (TEXT)
- queue (TEXT)
- payload (LONGTEXT)
- exception (LONGTEXT)
- failed_at (DATETIME, DEFAULT CURRENT_TIMESTAMP)

---

## JOBS
- id (BIGINT, PK, AUTO_INCREMENT)
- queue (VARCHAR(255))
- payload (LONGTEXT)
- attempts (TINYINT)
- reserved_at (INT, NULL)
- available_at (INT)
- created_at (INT)

---

## JOB_BATCHES
- id (VARCHAR(255), PK)
- name (VARCHAR(255))
- total_jobs (INT)
- pending_jobs (INT)
- failed_jobs (INT)
- failed_job_ids (LONGTEXT)
- options (MEDIUMTEXT, NULL)
- cancelled_at (INT, NULL)
- created_at (INT)
- finished_at (INT, NULL)

---
## SESSIONS
- id (VARCHAR(255), PK)
- user_id (BIGINT, NULL)
- ip_address (VARCHAR(45), NULL)
- user_agent (TEXT, NULL)
- payload (LONGTEXT)
- last_activity (INT)

---

## CACHE
- key (VARCHAR(255), PK)
- value (MEDIUMTEXT)
- expiration (INT)

---

## CACHE_LOCKS
- key (VARCHAR(255), PK)
- owner (VARCHAR(255))
- expiration (INT)

---