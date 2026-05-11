<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HistorialEstadoPedido extends Model
{
    protected $table = 'historial_estado_pedido';
    protected $primaryKey = 'id_historial';
    public $timestamps = false;

    protected $fillable = [
        'id_pedido',
        'estado',
        'comentario',
        'fecha'
    ];
}
