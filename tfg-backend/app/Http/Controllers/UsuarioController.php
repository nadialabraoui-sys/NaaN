<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Pedido;

class UsuarioController extends Controller
{
    public function index()
    {
        $usuarios = User::all();
        return response()->json($usuarios);
    }

    public function show($id)
    {
        $usuario = User::find($id);

        if (!$usuario) {
            return response()->json(['Error' => 'Usuario no encontrado'], 404);
        }

        return response()->json($usuario);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nombre' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|unique:usuario,email',
            'telefono' => 'sometimes|nullable|string|max:20',
            'fecha_nacimiento' => 'sometimes|nullable|date',
        ]);

        $usuario = User::find($id);

        if (!$usuario) {
            return response()->json(['Error' => 'Usuario no encontrado'], 404);
        }

        $usuario->update($request->all());
        return response()->json($usuario);
    }

    public function destroy($id)
    {
        $usuario = User::find($id);

        if (!$usuario) {
            return response()->json(['Error' => 'Usuario no encontrado'], 404);
        }

        Pedido::where('id_usuario', $id)->delete();
        $usuario->delete();
        return response()->json(['Completado' => 'Usuario eliminado']);
    }

    // Posible SuperUsusario para cuentas que paguen mensualidad
    public function toggleAdmin($id)
    {
        $usuario = User::find($id);

        if (!$usuario) {
            return response()->json(['Error' => 'Usuario no encontrado'], 404);
        }

        $nuevoRol = $usuario->rol === 'admin' ? 'cliente' : 'admin';
        $usuario->update(['rol' => $nuevoRol]);
        
        return response()->json(['Completado' => "Rol cambiado a $nuevoRol"]);
    }
}
