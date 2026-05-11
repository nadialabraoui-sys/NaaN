<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Avatar3d extends Model
{
    protected $table = 'avatar_3d';
    protected $primaryKey = 'id_avatar';
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'pecho',
        'cintura',
        'cadera',
        'estatura',
        'peso',
        'edad',
        'talla'
    ];
}
