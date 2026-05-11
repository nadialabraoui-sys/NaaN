<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Auditoria extends Model
{
    protected $table = 'auditoria';
    protected $primaryKey = 'id_auditoria';
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'tabla_afectada',
        'id_registro',
        'operacion',
        'datos_anteriores',
        'datos_nuevos',
        'fecha'
    ];
}
