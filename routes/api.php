<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\ReportController;
use Illuminate\Support\Facades\Route;
 
// Public routes
Route::post('/login', [AuthController::class, 'login']);

// Authenticated routes
Route::middleware('auth:sanctum')->group(function () {

    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);

    // Products - Admin only for CUD, both roles for read
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/{id}', [ProductController::class, 'show']);

    Route::middleware('check.admin')->group(function () {
        Route::post('/products', [ProductController::class, 'store']);
        Route::put('/products/{id}', [ProductController::class, 'update']);
        Route::delete('/products/{id}', [ProductController::class, 'destroy']);
    });

    // Orders - Managers and Admins can create/view. Admin can also confirm/cancel
    Route::middleware('check.manager')->group(function () {
        Route::get('/orders', [OrderController::class, 'index']);
        Route::post('/orders', [OrderController::class, 'store']);
        Route::get('/orders/{id}', [OrderController::class, 'show']);

        Route::middleware('check.admin')->group(function () {
            Route::put('/orders/{id}/confirm', [OrderController::class, 'confirm']);
            Route::put('/orders/{id}/cancel', [OrderController::class, 'cancel']);
        });
    });

    // Reports - Managers and Admins
    Route::middleware('check.manager')->group(function () {
        Route::get('/reports/stock-summary', [ReportController::class, 'stockSummary']);
        Route::get('/reports/sales', [ReportController::class, 'sales']);
    });
});
