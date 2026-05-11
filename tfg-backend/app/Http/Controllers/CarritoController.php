<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Carrito;

class CarritoController extends Controller
{
    public function index()
    {
        $carritos = Carrito::all();
        return response()->json($carritos);
    }

    public function miCarrito(Request $request)
    {
        $carrito = Carrito::firstOrCreate([
            'id_usuario' => $request->user()->id_usuario
        ]);

        return response()->json($carrito);
    }

    public function show($id)
    {
        $carrito = Carrito::find($id);

        if (!$carrito) {
            return response()->json(['Error' => 'El detalle de este pedido no se ha encontrado'], 404);
        }

        return response()->json($carrito);
    }

    // El carrito se creara una vez se registre el usuario, pero por si acaso
    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
        ]);

        // Pasa el JSON a array de  PHP el $request->all()
        $carrito = Carrito::create($request->all());
        return response()->json($carrito, 201);
    }

    public function destroy($id)
    {
        $carrito = Carrito::find($id);

        if (!$carrito) {
            return response()->json(['Error' => 'El carrito no se ha encontrado'], 404);
        }

        $carrito->delete();
        return response()->json(['Completado' => 'El carrito se ha vaciado correctamente']);
    }
}
