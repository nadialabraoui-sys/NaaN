<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Pedido;
use App\Models\User;

class PedidoController extends Controller
{
    public function index()
    {
        $pedidos = Pedido::all();
        return response()->json($pedidos);
    }

    public function indexOnly(Request $request)
    {
        $pedidos = Pedido::where('id_usuario', $request->user()->id_usuario)->get();
        return response()->json($pedidos);
    }

    public function show($id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido) {
            return response()->json(['Error' => 'Pedido no encontrado'], 404);
        }

        return response()->json($pedido);
    }

    public function update(Request $request, $id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido) {
            return response()->json(['Error' => 'Pedido no encontrado'], 404);
        }

        $pedido->update($request->all());
        return response()->json($pedido);
    }

    public function destroy($id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido) {
            return response()->json(['Error' => 'Pedido no encontrado'], 404);
        }

        $pedido->delete();
        return response()->json(['Completado' => 'Pedido eliminado']);
    }

    public function avanzarEstado($id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido) {
            return response()->json(['Error' => 'Pedido no encontrado'], 404);
        }

        $estados = ['pendiente', 'pagado', 'enviado', 'entregado'];
        $indexActual = array_search($pedido->estado, $estados);
        $indexSiguiente = $indexActual + 1;
        if ($indexActual === false || $indexActual >= count($estados) - 1) 
        {
            return response()->json(['Completado' => 'Pedido entregado']);
        }
        
        $estadoSiguiente = $estados[$indexSiguiente];

        $pedido->update(['estado' => $estadoSiguiente]);

        return response()->json(['Completado' => "Estado actualizado a $estadoSiguiente"]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
            'id_metodo_pago' => 'required|exists:metodo_pago,id_metodo_pago',
            'id_direccion' => 'required|exists:direccion,id_direccion',
            'gastos_envio' => 'required|numeric|min:0',
            'total' => 'required|numeric|min:0',
            'codigo_seguimiento' => 'nullable|string|max:255',
            'estado' => 'required|in:pendiente,pagado,enviado,entregado,cancelado',
        ]);

        $pedido = Pedido::create($request->all());
        return response()->json($pedido, 201);
    }

    // Hacer un boton que se deshabilite (Que quede invisible para que no se pueda cancelar en vez de venir a la API)
    public function cancelar($id)
    {
        $pedido = Pedido::find($id);

        if (!$pedido) {
            return response()->json(['Error' => 'Pedido no encontrado'], 404);
        }

        if ($pedido->estado === "entregado")
        {
            return response()->json(['Error' => 'No se puede cancelar un pedido entregado']);
        }
        else
        {
            $pedido->update(['estado' => 'cancelado']);
            return response()->json(['Completado' => 'El pedido ha sido cancelado']);
        }
    }
}
