<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Producto;

class ProductoController extends Controller
{
    public function indexAll()
    {
        $productos = Producto::all();
        return response()->json($productos);
    }

    public function index(Request $request)
    {
        $query = Producto::where('activo', true);

        if ($request->filled('buscar')) {
            $query->where('nombre', 'like', '%' . $request->buscar . '%');
        }
        if ($request->filled('sexo')) {
            $query->where(function($q) use ($request) {
                $q->where('sexo', $request->sexo)->orWhere('sexo', 'unisex');
            });
        }
        if ($request->filled('nombre')) {
            $query->where('nombre', $request->nombre);
        }
        if ($request->filled('categoria')) {
            $query->where('id_categoria', $request->categoria);
        }

        return response()->json($query->get());
    }

    public function show($id)
    {
        $producto = Producto::find($id);

        if (!$producto) {
            return response()->json(['Error' => 'Producto no encontrado'], 404);
        }

        return response()->json($producto);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
            'precio' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'id_categoria' => 'required|exists:categoria,id_categoria',
            'imagen' => 'nullable|string',
            'activo' => 'boolean',
            'color' => 'nullable|string|max:50',
            'sexo' => 'nullable|in:hombre,mujer,unisex',
            'talla' => 'nullable|in:XS,S,M,L,XL,XXL',
        ]);

        $producto = Producto::create($request->all());
        return response()->json($producto, 201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nombre' => 'sometimes|string|max:255',
            'descripcion' => 'sometimes|nullable|string',
            'precio' => 'sometimes|numeric|min:0',
            'stock' => 'sometimes|integer|min:0',
            'id_categoria' => 'sometimes|exists:categoria,id_categoria',
            'imagen' => 'sometimes|nullable|string',
            'activo' => 'sometimes|boolean',
            'color' => 'sometimes|nullable|string|max:50',
            'sexo' => 'sometimes|nullable|in:hombre,mujer,unisex',
            'talla' => 'sometimes|nullable|in:XS,S,M,L,XL,XXL',
        ]);

        $producto = Producto::find($id);

        if (!$producto) {
            return response()->json(['Error' => 'Producto no encontrado'], 404);
        }

        $producto->update($request->all());
        return response()->json($producto);
    }


    public function destroy($id)
    {
        $producto = Producto::find($id);

        if (!$producto) {
            return response()->json(['Error' => 'Producto no encontrado'], 404);
        }

        $producto->update(['activo' => false]);
        return response()->json(['Completado' => 'Producto eliminado']);
    }

    public function toggleActivo($id)
    {
        $producto = Producto::find($id);

        if (!$producto) {
            return response()->json(['Error' => 'Producto no encontrado'], 404);
        }

        $producto->update(['activo' => !$producto->activo]);
        
        $estado = $producto->activo ? 'activado' : 'desactivado';
        return response()->json(['Completado' => "Producto $estado"]);
    }   
}