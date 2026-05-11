<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Direccion extends Model
{
    protected $table = 'direccion';
    protected $primaryKey = 'id_direccion';
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'calle',
        'numero',
        'ciudad',
        'provincia',
        'codigo_postal',
        'pais'
    ];
}
