<?php

namespace App\Services;

use App\Models\Stock;
use App\Repositories\StockRepository;
use Illuminate\Support\Facades\DB;

class StockService
{
    public function __construct(
        private readonly StockRepository $stockRepository
    ) {}
 
    public function checkAvailability(int $productId, int $warehouseId, int $quantity): bool
    {
        $stock = $this->stockRepository->findStock($productId, $warehouseId);

        return $stock && $stock->quantity >= $quantity;
    }
 
    public function deductStock(int $productId, int $warehouseId, int $quantity): void
    {
        $stock = $this->stockRepository->lockForUpdate($productId, $warehouseId);

        if (!$stock || $stock->quantity < $quantity) {
            throw new \Exception(
                "Insufficient stock for product ID {$productId} in warehouse ID {$warehouseId}. " .
                "Available: " . ($stock?->quantity ?? 0) . ", Requested: {$quantity}"
            );
        }

        $stock->decrement('quantity', $quantity);
    }
 
    public function restoreStock(int $productId, int $warehouseId, int $quantity): void
    {
        $stock = $this->stockRepository->findOrNew($productId, $warehouseId);
        $stock->quantity = ($stock->quantity ?? 0) + $quantity;
        $stock->save();
    }
}
