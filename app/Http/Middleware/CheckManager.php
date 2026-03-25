<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckManager
{
    /**
     * Handle an incoming request.
     * Allows both admins and managers.
     *
     * @param  Closure(Request): Response  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (!$request->user() || !in_array($request->user()->role, ['admin', 'manager'])) {
            return response()->json([
                'success' => false,
                'message' => 'Forbidden. Manager or Admin access required.',
            ], 403);
        }

        return $next($request);
    }
}
