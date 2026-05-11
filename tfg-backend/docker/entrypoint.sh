#!/bin/sh
set -e

echo "==> Esperando a MySQL..."
until php -r "
try {
    new PDO(
        'mysql:host=' . getenv('DB_HOST') . ';port=' . getenv('DB_PORT') . ';dbname=' . getenv('DB_DATABASE'),
        getenv('DB_USERNAME'),
        getenv('DB_PASSWORD')
    );
    exit(0);
} catch (Exception \$e) {
    exit(1);
}
" 2>/dev/null; do
    echo "    MySQL no disponible, reintentando en 3s..."
    sleep 3
done
echo "==> MySQL listo."

echo "==> Ejecutando migraciones..."
php artisan migrate --force

echo "==> Creando enlace de storage..."
php artisan storage:link 2>/dev/null || true

echo "==> Cacheando configuración y rutas..."
php artisan config:cache
php artisan route:cache
php artisan view:cache 2>/dev/null || true

echo "==> Ajustando permisos de storage..."
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

echo "==> Iniciando servicios (nginx + php-fpm)..."
exec supervisord -c /etc/supervisord.conf
