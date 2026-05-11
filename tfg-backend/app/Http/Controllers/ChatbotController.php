<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ChatbotController extends Controller
{
    private string $systemPrompt = <<<'PROMPT'
Eres el asistente virtual de atención al cliente de NaaN, una tienda de ropa online española.
Ayuda a los clientes con dudas sobre pedidos, tallas, devoluciones, envíos y productos.

Información de NaaN:
- Tienda de ropa online: camisetas, pantalones, vestidos y más
- Tallas disponibles: XS, S, M, L, XL, XXL
- Envíos dentro de España (3-5 días laborables)
- Devoluciones: 30 días desde la recepción, producto sin usar
- Para incidencias con un pedido concreto, solicita el número de pedido
- Email de soporte: soporte@naan.es

Responde siempre en español, de forma amable, breve (máximo 3 frases) y profesional.
Si no puedes resolver algo, indica que contacten con soporte@naan.es
PROMPT;

    public function chat(Request $request)
    {
        $request->validate([
            'messages'          => 'required|array|min:1|max:20',
            'messages.*.role'   => 'required|in:user,assistant',
            'messages.*.content'=> 'required|string|max:500',
        ]);

        $messages = array_slice($request->messages, -10);

        $response = Http::withoutVerifying()->withHeaders([
            'Authorization' => 'Bearer ' . config('services.groq.key'),
            'Content-Type'  => 'application/json',
        ])->timeout(15)->post('https://api.groq.com/openai/v1/chat/completions', [
            'model'       => 'llama-3.3-70b-versatile',
            'messages'    => [
                ['role' => 'system', 'content' => $this->systemPrompt],
                ...$messages,
            ],
            'max_tokens'  => 250,
            'temperature' => 0.6,
        ]);

        if (!$response->successful()) {
            return response()->json(['error' => 'Error al conectar con el asistente'], 500);
        }

        return response()->json([
            'reply' => $response->json('choices.0.message.content'),
        ]);
    }
}
