<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    // Si lo dejasemos ['*'] cualquier web del mundo puede hacer peticiones a nuestra API
    // Ahora solo Angular podra hacer las peticiones
    'allowed_origins' => ['http://localhost:4200'],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    // Sanctum usa cookies y tokens para autenticar, 
    // el navegador bloquea el envío de credenciales 
    // en peticiones entre dominios diferentes si esta en "false"
    // Al ponerlo en true le indicamos al navegador que envie credenciales a Angular (puerto: 4200)
    'supports_credentials' => true,

];
