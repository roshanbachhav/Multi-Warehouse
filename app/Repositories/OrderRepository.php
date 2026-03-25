<?php

namespace App\Repositories;

use App\Models\Order;
use Illuminate\Pagination\LengthAwarePaginator;

class OrderRepository
{ 
    public function paginate(array $filters = [], int $perPage = 15): LengthAwarePaginator
    {
        $query = Order::with(['warehouse']);

        if (!empty($filters['status'])) {
            $query->byStatus($filters['status']);
        }

        if (!empty($filters['date_from']) && !empty($filters['date_to'])) {
            $query->dateRange($filters['date_from'], $filters['date_to']);
        }

        if (!empty($filters['date_from'])) {
            $query->whereDate('created_at', '>=', $filters['date_from']);
        }

        if (!empty($filters['date_to'])) {
            $query->whereDate('created_at', '<=', $filters['date_to']);
        }

        return $query->latest()->paginate($perPage);
    }
 
    public function findWithItems(int $id): Order
    {
        return Order::with(['warehouse', 'items.product'])->findOrFail($id);
    }
 
    public function findById(int $id): Order
    {
        return Order::findOrFail($id);
    } 
    
    public function create(array $data): Order
    {
        return Order::create($data);
    }
}
