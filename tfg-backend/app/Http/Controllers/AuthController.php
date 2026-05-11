<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Hash;
use App\Models\Carrito;


class AuthController extends Controller
{
    public function registro(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'email' => 'required|email|unique:usuario,email',
            'contrasena' => 'required|string|min:6',
            'telefono' => 'nullable|string|max:20',
            'fecha_nacimiento' => 'nullable|date',
        ]);

        $usuario = User::create([
            'nombre' => $request->nombre,
            'email' => $request->email,
            'contrasena' => Hash::make($request->contrasena),
            'rol' => 'cliente',
            'telefono' => $request->telefono,
            'fecha_nacimiento' => $request->fecha_nacimiento
        ]);

        Carrito::create([
            'id_usuario' => $usuario->id_usuario
        ]);

        $token = $usuario->createToken('token_registro')->plainTextToken;

        return response()->json([
            'usuario' => $usuario,
            'token' => $token
        ], 201);
    }

    public function login(Request $request)
    {

        $request->validate([
            'email' => 'required|email',
            'contrasena' => 'required|string',
        ]);

        $usuario = User::where('email', $request->email)->first();

        if (!$usuario || !Hash::check($request->contrasena, $usuario->contrasena)) {
            return response()->json(['Error' => 'Credenciales incorrectas'], 401);
        }

        $token = $usuario->createToken('token_login')->plainTextToken;

        return response()->json([
            'usuario' => $usuario,
            'token'   => $token
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['Completado' => 'Sesión cerrada']);
    }

    public function miPerfil(Request $request)
    {
        return response()->json($request->user());
    }

    public function actualizarMiPerfil(Request $request)
    {
        $usuario = $request->user();

        $request->validate([
            'nombre'           => 'sometimes|string|max:255',
            'email'            => 'sometimes|email|unique:usuario,email,' . $usuario->id_usuario . ',id_usuario',
            'telefono'         => 'sometimes|nullable|string|max:20',
            'fecha_nacimiento' => 'sometimes|nullable|date',
        ]);

        $usuario->update($request->only(['nombre', 'email', 'telefono', 'fecha_nacimiento']));

        return response()->json($usuario);
    }

    public function cambiarContrasena(Request $request)
    {
        $request->validate([
            'contrasena_actual' => 'required|string',
            'nueva_contrasena'  => 'required|string|min:6',
        ]);

        $usuario = $request->user();

        if (!Hash::check($request->contrasena_actual, $usuario->contrasena)) {
            return response()->json(['Error' => 'Contrasena actual incorrecta'], 422);
        }

        $usuario->update(['contrasena' => Hash::make($request->nueva_contrasena)]);

        return response()->json(['Completado' => 'Contrasena actualizada']);
    }
}