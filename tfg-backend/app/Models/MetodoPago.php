<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MetodoPago extends Model
{
    protected $table = 'metodo_pago';
    protected $primaryKey = 'id_metodo_pago';
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'tipo',
        'numero_enmascarado',
        'es_predeterminado',
        'fecha_expiracion',
    ];
}
