<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $table = 'usuario';
    protected $primaryKey = 'id_usuario';
    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'email',
        'contrasena',
        'rol',
        'telefono',
        'fecha_nacimiento',
        'fecha_registro',
    ];

    protected $hidden = [
        'contrasena',
    ];

    // Laravel buscara password pero como la llamamos contrasena hay que crear esta funcion para que la encuentre
    public function getAuthPassword()
    {
        return $this->contrasena;
    }
}