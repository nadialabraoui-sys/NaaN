<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    protected $table = 'pedido';
    protected $primaryKey = 'id_pedido';
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'id_metodo_pago',
        'id_direccion',
        'gastos_envio',
        'codigo_seguimiento',
        'estado',
        'total'
    ];
}
