<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\HistorialEstadoPedido;

class HistorialEstadoPedidoController extends Controller
{
    public function index()
    {
        $historiales = HistorialEstadoPedido::all();
        return response()->json($historiales);
    }

    public function show($id)
    {
        $historial = HistorialEstadoPedido::find($id);

        if (!$historial) {
            return response()->json(['Error' => 'El historial no se ha encontrado'], 404);
        }

        return response()->json($historial);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'pecho' => 'sometimes|numeric|min:0',
            'cintura' => 'sometimes|numeric|min:0',
            'cadera' => 'sometimes|numeric|min:0',
            'estatura' => 'sometimes|numeric|min:0',
            'peso' => 'sometimes|numeric|min:0',
            'edad' => 'sometimes|integer|min:0',
            'talla' => 'sometimes|in:XS,S,M,L,XL,XXL',
        ]);

        $historial = HistorialEstadoPedido::where('id_pedido', $id)->whereIn('estado', ['entregado', 'cancelado'])->first();

        if (!$historial) {
            return response()->json(['Error' => 'No puedes añadir comentario en este momento'], 404);
        }

        $historial->update(['comentario' => $request->comentario]);
        return response()->json($historial, 201);
    }
}
