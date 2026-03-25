<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConfirmOrderRequest;
use App\Http\Requests\StoreOrderRequest;
use App\Http\Resources\OrderDetailResource;
use App\Http\Resources\OrderResource;
use App\Services\OrderService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function __construct(
        private readonly OrderService $orderService
    ) {}
 
    public function index(Request $request): JsonResponse
    {
        try {
            $filters = $request->only(['status', 'date_from', 'date_to']);
            $orders  = $this->orderService->getOrders($filters);

            return response()->json([
                'success' => true,
                'data'    => OrderResource::collection($orders->items()),
                'meta'    => [
                    'current_page' => $orders->currentPage(),
                    'last_page'    => $orders->lastPage(),
                    'per_page'     => $orders->perPage(),
                    'total'        => $orders->total(),
                ],
            ], 200);

        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch orders.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

 
    public function store(StoreOrderRequest $request): JsonResponse
    {
        try {
            $order = $this->orderService->createOrder($request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Order created successfully.',
                'data'    => new OrderDetailResource($order),
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 400);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create order.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function show(int $id): JsonResponse
    {
        try {
            $order = $this->orderService->getOrder($id);

            return response()->json([
                'success' => true,
                'data'    => new OrderDetailResource($order),
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch order.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function confirm(ConfirmOrderRequest $request, int $id): JsonResponse
    {
        try {
            $order = $this->orderService->confirmOrder($id);

            return response()->json([
                'success' => true,
                'message' => 'Order confirmed successfully.',
                'data'    => new OrderDetailResource($order),
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 400);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to confirm order.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function cancel(Request $request, int $id): JsonResponse
    {
        try {
            $order = $this->orderService->cancelOrder($id);

            return response()->json([
                'success' => true,
                'message' => 'Order cancelled successfully.',
                'data'    => new OrderDetailResource($order),
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 400);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to cancel order.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
