<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DetallePedido;
use App\Models\Pedido;

class DetallePedidoController extends Controller
{
    public function index()
    {
        $detallePedidos = DetallePedido::all();
        return response()->json($detallePedidos);
    }

    public function misDetalles(Request $request)
    {
        // Esto devuelve solo las ID es para evitar hacer dos consultas y un foreach
        $idsPedidos  = Pedido::where('id_usuario', $request->user()->id_usuario)->pluck('id_pedido');
        
        // SELECT * FROM detalle_pedido WHERE id_pedido IN (..., ...) | Los valores son del array de arriba
        $detalles = DetallePedido::whereIn('id_pedido', $idsPedidos)->get();

        return response()->json($detalles);
    }

    public function show($id)
    {
        $detallePedido = DetallePedido::find($id);

        if (!$detallePedido) {
            return response()->json(['Error' => 'El detalle de este pedido no se ha encontrado'], 404);
        }

        return response()->json($detallePedido);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_pedido' => 'required|exists:pedido,id_pedido',
            'id_producto' => 'required|exists:producto,id_producto',
            'cantidad' => 'required|integer|min:1',
            'precio_en_el_momento' => 'required|numeric|min:0',
        ]);

        $detallePedido = DetallePedido::create($request->all());
        return response()->json($detallePedido, 201);
    }

    public function destroy($id)
    {
        $detallePedido = DetallePedido::find($id);

        if (!$detallePedido) {
            return response()->json(['Error' => 'El detalle de este pedido no se ha encontrado'], 404);
        }

        $detallePedido->delete();
        return response()->json(['Completado' => 'Los detalles de este pedido han sido eliminados']);
    }

}
