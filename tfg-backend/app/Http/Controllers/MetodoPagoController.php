<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\MetodoPago;

class MetodoPagoController extends Controller
{
    public function index()
    {
        $metodosPago = MetodoPago::all();
        return response()->json($metodosPago);
    }

    public function misMetodosPago(Request $request)
    {
        $metodosPago = MetodoPago::where('id_usuario', $request->user()->id_usuario)->get();

        return response()->json($metodosPago);
    }

    public function show($id)
    {
        $metodoPago = MetodoPago::find($id);

        if (!$metodoPago) {
            return response()->json(['Error' => 'El método de pago no se ha encontrado'], 404);
        }

        return response()->json($metodoPago);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_usuario' => 'required|exists:usuario,id_usuario',
            'tipo' => 'required|in:paypal,tarjeta,bizum,google_pay',
            'numero_enmascarado' => 'required|string|max:255',
            'es_predeterminado' => 'boolean',
            'fecha_expiracion' => 'nullable|date',
        ]);

        $metodoPago = MetodoPago::create($request->all());
        return response()->json($metodoPago, 201);
    }

    public function update(Request $request, $id)
    {

        $metodoPago = MetodoPago::find($id);

        if (!$metodoPago) {
            return response()->json(['Error' => 'El método de pago no se ha encontrado'], 404);
        }

        // Comprobacion de que el método de pago pertenece al usuario y no modifique el de otro
        if ($metodoPago->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para modificar este método de pago'], 403);
        }

        $request->validate([
            'tipo' => 'sometimes|in:paypal,tarjeta,bizum,google_pay',
            'numero_enmascarado' => 'sometimes|string|max:255',
            'es_predeterminado' => 'sometimes|boolean',
            'fecha_expiracion' => 'sometimes|date',
        ]);

        $metodoPago->update($request->all());
        return response()->json($metodoPago, 201);
    }

    public function destroy(Request $request, $id)
    {
        $metodoPago = MetodoPago::find($id);

        if (!$metodoPago) {
            return response()->json(['Error' => 'El método de pago no se ha encontrado'], 404);
        }

        // Comprobacion de que el método de pago pertenece al usuario y no elimine el de otro
        if ($metodoPago->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para eliminar este método de pago'], 403);
        }

        $metodoPago->delete();
        return response()->json(['Completado' => 'El método de pago se ha eliminado correctamente']);
    }

    public function togglePredeterminado(Request $request, $id)
    {
        $metodoPago = MetodoPago::find($id);

        if (!$metodoPago) {
            return response()->json(['Error' => 'El método de pago no se ha encontrado'], 404);
        }

        // Comprobacion de que el método de pago pertenece al usuario y no modifique el de otro
        if ($metodoPago->id_usuario !== $request->user()->id_usuario) {
            return response()->json(['Error' => 'No tienes permisos para modificar este método de pago'], 403);
        }

        MetodoPago::where('id_usuario', $metodoPago->id_usuario)->update(['es_predeterminado' => 0]);

        $metodoPago->update(['es_predeterminado' => 1]);

        return response()->json(['Completado' => "Método de pago marcado como predeterminado"]);
    }
}
