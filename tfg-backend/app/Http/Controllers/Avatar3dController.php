<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Avatar3d;

class Avatar3dController extends Controller
{
    public function index()
    {
        $avatares = Avatar3d::all();
        return response()->json($avatares);
    }

    public function miAvatar(Request $request)
    {
        $avatar = Avatar3d::where('id_usuario', $request->user()->id_usuario)->first();
        
        if (!$avatar) {
        return response()->json(['Error' => 'No tienes avatar'], 404);
        }

        return response()->json($avatar);
    }

    public function show($id)
    {
        $avatar = Avatar3d::find($id);

        if (!$avatar) {
            return response()->json(['Error' => 'El avatar no se ha encontrado'], 404);
        }

        return response()->json($avatar);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
            'pecho' => 'required|numeric|min:0',
            'cintura' => 'required|numeric|min:0',
            'cadera' => 'required|numeric|min:0',
            'estatura' => 'required|numeric|min:0',
            'peso' => 'required|numeric|min:0',
            'edad' => 'required|integer|min:0',
            'talla' => 'required|in:XS,S,M,L,XL,XXL',
        ]);

        // Pasa el JSON a array de  PHP el $request->all()
        $avatar = Avatar3d::create($request->all());
        return response()->json($avatar, 201);
    }

    public function update(Request $request, $id)
    {
        $avatar = Avatar3d::find($id);

        if (!$avatar) {
            return response()->json(['Error' => 'El avatar no se ha encontrado'], 404);
        }

        // Comprobacion de que el avatar pertenece al usuario y no modifique el de otro
        if ($avatar->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para modificar este avatar'], 403);
        }

        $request->validate([
            'pecho' => 'sometimes|numeric|min:0',
            'cintura' => 'sometimes|numeric|min:0',
            'cadera' => 'sometimes|numeric|min:0',
            'estatura' => 'sometimes|numeric|min:0',
            'peso' => 'sometimes|numeric|min:0',
            'edad' => 'sometimes|integer|min:0',
            'talla' => 'sometimes|in:XS,S,M,L,XL,XXL',
        ]);

        $avatar->update($request->all());
        return response()->json($avatar, 201);
    }

    public function destroy(Request $request, $id)
    {
        $avatar = Avatar3d::find($id);

        if (!$avatar) {
            return response()->json(['Error' => 'El avatar no se ha encontrado'], 404);
        }

        // Comprobacion de que el avatar pertenece al usuario y no elimine el de otro
        if ($avatar->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para eliminar este avatar'], 403);
        }

        $avatar->delete();
        return response()->json(['Completado' => 'El avatar se ha eliminado correctamente']);
    }
}
