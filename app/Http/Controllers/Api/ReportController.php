<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\ReportService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function __construct(
        private readonly ReportService $reportService
    ) {}
 
    public function stockSummary(): JsonResponse
    {
        try {
            $data = $this->reportService->getStockSummary();

            return response()->json([
                'success' => true,
                'data'    => $data,
            ], 200);

        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to generate stock summary.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
 
    public function sales(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'date_from' => 'nullable|date',
                'date_to'   => 'nullable|date|after_or_equal:date_from',
            ]);

            $data = $this->reportService->getSalesReport(
                $request->get('date_from'),
                $request->get('date_to')
            );

            return response()->json([
                'success' => true,
                'data'    => $data,
            ], 200);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed.',
                'errors'  => $e->errors(),
            ], 422);
        } catch (\Throwable $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to generate sales report.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
