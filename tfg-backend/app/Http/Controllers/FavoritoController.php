<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Favorito;

class FavoritoController extends Controller
{
     public function index()
    {
        $favoritos = Favorito::all();
        return response()->json($favoritos);
    }

    public function productosFavoritos($id_producto)
    {
        $favoritos = Favorito::where('id_producto', $id_producto)->get();

        return response()->json($favoritos);
    }

    public function misFavoritos(Request $request)
    {
        $favoritos = Favorito::where('id_usuario', $request->user()->id_usuario)->get();

        return response()->json($favoritos);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
            'id_producto' => 'required|exists:producto,id_producto',
        ]);
        
        $favorito = Favorito::create($request->all());
        return response()->json($favorito, 201);
    }

    public function destroy(Request $request, $id_producto)
    {
        $eliminado = Favorito::where('id_usuario', $request->user()->id_usuario)->where('id_producto', $id_producto)->delete();

        if (!$eliminado) {
            return response()->json(['Error' => 'El producto no se ha encontrado en favoritos'], 404);
        }

        return response()->json(['Completado' => 'El producto se ha eliminado correctamente de favoritos']);
    }
}
