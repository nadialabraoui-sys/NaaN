<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Auditoria;

class AuditoriaController extends Controller
{
    public function index()
    {
        $auditorias = Auditoria::all();
        return response()->json($auditorias);
    }

    public function show($id)
    {
        $auditoria = Auditoria::find($id);

        if (!$auditoria) {
            return response()->json(['Error' => 'El registor de auditoria no se ha encontrado'], 404);
        }

        return response()->json($auditoria);
    }
}
