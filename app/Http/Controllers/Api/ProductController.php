<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Http\Resources\ProductResource;
use App\Services\ProductService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function __construct(
        private readonly ProductService $productService
    ) {}

 
    public function index(Request $request): JsonResponse
    {
        try {
            $filters  = $request->only(['status', 'category', 'search']);
            $products = $this->productService->getProducts($filters);

            return response()->json([
                'success' => true,
                'data'    => ProductResource::collection($products->items()),
                'meta'    => [
                    'current_page' => $products->currentPage(),
                    'last_page'    => $products->lastPage(),
                    'per_page'     => $products->perPage(),
                    'total'        => $products->total(),
                ],
            ], 200);

        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch products.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function store(StoreProductRequest $request): JsonResponse
    {
        try {
            $product = $this->productService->createProduct($request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Product created successfully.',
                'data'    => new ProductResource($product),
            ], 201);

        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to create product.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function show(int $id): JsonResponse
    {
        try {
            $product = $this->productService->getProduct($id);

            return response()->json([
                'success' => true,
                'data'    => new ProductResource($product),
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found.',
            ], 404);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch product.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function update(UpdateProductRequest $request, int $id): JsonResponse
    {
        try {
            $product = $this->productService->updateProduct($id, $request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Product updated successfully.',
                'data'    => new ProductResource($product),
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found.',
            ], 404);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update product.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function destroy(int $id): JsonResponse
    {
        try {
            $this->productService->deleteProduct($id);

            return response()->json([
                'success' => true,
                'message' => 'Product deleted successfully.',
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException) {
            return response()->json([
                'success' => false,
                'message' => 'Product not found.',
            ], 404);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete product.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
