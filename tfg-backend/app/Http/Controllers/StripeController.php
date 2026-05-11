<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\PaymentIntent;
use App\Models\Pedido;
use App\Models\DetallePedido;

class StripeController extends Controller
{
    public function __construct()
    {
        Stripe::setApiKey(config('services.stripe.secret'));
    }

    public function createPaymentIntent(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:0.5',
        ]);

        $paymentIntent = PaymentIntent::create([
            'amount'               => (int) round($request->amount * 100),
            'currency'             => 'eur',
            'payment_method_types' => ['card'],
        ]);

        return response()->json(['client_secret' => $paymentIntent->client_secret]);
    }

    public function confirmarPedido(Request $request)
    {
        $request->validate([
            'payment_intent_id' => 'required|string',
            'id_usuario'        => 'required|exists:usuario,id_usuario',
            'id_metodo_pago'    => 'required|exists:metodo_pago,id_metodo_pago',
            'id_direccion'      => 'required|exists:direccion,id_direccion',
            'gastos_envio'      => 'required|numeric|min:0',
            'total'             => 'required|numeric|min:0',
            'items'             => 'required|array|min:1',
        ]);

        $paymentIntent = PaymentIntent::retrieve($request->payment_intent_id);

        if ($paymentIntent->status !== 'succeeded') {
            return response()->json(['error' => 'El pago no se ha completado.'], 422);
        }

        $pedido = Pedido::create([
            'id_usuario'     => $request->id_usuario,
            'id_metodo_pago' => $request->id_metodo_pago,
            'id_direccion'   => $request->id_direccion,
            'gastos_envio'   => $request->gastos_envio,
            'total'          => $request->total,
            'estado'         => 'pagado',
        ]);

        foreach ($request->items as $item) {
            DetallePedido::create([
                'id_pedido'            => $pedido->id_pedido,
                'id_producto'          => $item['id_producto'],
                'cantidad'             => $item['cantidad'],
                'precio_en_el_momento' => $item['precio_en_el_momento'],
            ]);
        }

        return response()->json($pedido, 201);
    }
}
