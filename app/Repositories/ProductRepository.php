<?php

namespace App\Repositories;

use App\Models\Product;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class ProductRepository
{  
    public function paginate(array $filters = [], int $perPage = 15): LengthAwarePaginator
    {
        $query = Product::query();

        if (!empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        if (!empty($filters['category'])) {
            $query->byCategory($filters['category']);
        }

        if (!empty($filters['search'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('name', 'like', '%' . $filters['search'] . '%')
                  ->orWhere('sku', 'like', '%' . $filters['search'] . '%');
            });
        }

        return $query->latest()->paginate($perPage);
    }
 
    public function findById(int $id): Product
    {
        return Product::findOrFail($id);
    }
 
    public function create(array $data): Product
    {
        return Product::create($data);
    }
 
    public function update(Product $product, array $data): Product
    {
        $product->update($data);
        return $product->fresh();
    }

 
    public function delete(Product $product): bool|null
    {
        return $product->delete();
    }
}
