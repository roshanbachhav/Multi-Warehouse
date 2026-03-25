<?php

namespace App\Repositories;

use App\Models\Stock;

class StockRepository
{
 
    public function findOrNew(int $productId, int $warehouseId): Stock
    {
        return Stock::firstOrNew([
            'product_id'   => $productId,
            'warehouse_id' => $warehouseId,
        ]);
    }
 
    public function lockForUpdate(int $productId, int $warehouseId): ?Stock
    {
        return Stock::where('product_id', $productId)
            ->where('warehouse_id', $warehouseId)
            ->lockForUpdate()
            ->first();
    }
 
    public function findStock(int $productId, int $warehouseId): ?Stock
    {
        return Stock::where('product_id', $productId)
            ->where('warehouse_id', $warehouseId)
            ->first();
    }
}
