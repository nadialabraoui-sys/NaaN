<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetalleCarrito extends Model
{
    protected $table = 'detalle_carrito';
    protected $primaryKey = 'id_detalle_carrito';
    public $timestamps = false;

    protected $fillable = [
        'id_carrito',
        'id_producto',
        'cantidad',
        'talla',
        'precio_unitario'
    ];

}
