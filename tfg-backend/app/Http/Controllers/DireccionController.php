<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Direccion;

class DireccionController extends Controller
{
    public function index()
    {
        $direcciones = Direccion::all();
        return response()->json($direcciones);
    }

    public function misDirecciones(Request $request)
    {
        $direcciones = Direccion::where('id_usuario', $request->user()->id_usuario)->get();

        return response()->json($direcciones);
    }

    public function show($id)
    {
        $direccion = Direccion::find($id);

        if (!$direccion) {
            return response()->json(['Error' => 'La dirección no se ha encontrado'], 404);
        }

        return response()->json($direccion);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
            'calle' => 'required|string|max:255',
            'numero' => 'required|string|max:20',
            'ciudad' => 'required|string|max:255',
            'provincia' => 'required|string|max:255',
            'codigo_postal' => 'required|string|max:10',
            'pais' => 'required|string|max:255',
        ]);

        $direccion = Direccion::create($request->all());
        return response()->json($direccion, 201);
    }

    public function update(Request $request, $id)
    {

        $direccion = Direccion::find($id);

        if (!$direccion) {
            return response()->json(['Error' => 'La dirección no se ha encontrado'], 404);
        }

        // Comprobacion de que la dirección pertenece al usuario y no modifique la de otro
        if ($direccion->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para modificar esta dirección'], 403);
        }

        $request->validate([
            'calle' => 'sometimes|string|max:255',
            'numero' => 'sometimes|string|max:20',
            'ciudad' => 'sometimes|string|max:255',
            'provincia' => 'sometimes|string|max:255',
            'codigo_postal' => 'sometimes|string|max:10',
            'pais' => 'sometimes|string|max:255',
        ]);

        $direccion->update($request->all());
        return response()->json($direccion, 201);
    }

    public function destroy(Request $request, $id)
    {
        $direccion = Direccion::find($id);

        if (!$direccion) {
            return response()->json(['Error' => 'La dirección no se ha encontrado'], 404);
        }

        // Comprobacion de que la dirección pertenece al usuario y no elimine la de otro
        if ($direccion->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para eliminar esta dirección'], 403);
        }

        $direccion->delete();
        return response()->json(['Completado' => 'La direccion se ha eliminado correctamente']);
    }
}
