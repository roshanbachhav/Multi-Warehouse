<?php

namespace App\Services;

use App\Models\Product;
use App\Repositories\ProductRepository;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Str;

class ProductService
{
    public function __construct(
        private readonly ProductRepository $productRepository
    ) {}
 
    public function getProducts(array $filters = []): LengthAwarePaginator
    {
        // Cache key based on filters + page
        $page       = request()->get('page', 1);
        $cacheKey   = 'products_' . md5(serialize($filters) . '_page_' . $page);

        return Cache::remember($cacheKey, 3600, function () use ($filters) {
            return $this->productRepository->paginate($filters);
        });
    }
 
    public function getProduct(int $id): Product
    {
        return $this->productRepository->findById($id);
    }
 
    public function createProduct(array $data): Product
    {
        $data['sku']  = $this->generateSku();
        $data['slug'] = $this->generateSlug($data['name']);

        $product = $this->productRepository->create($data);

        $this->clearProductCache();

        return $product;
    }
  
    public function updateProduct(int $id, array $data): Product
    {
        $product = $this->productRepository->findById($id);

        if (isset($data['name'])) {
            $data['slug'] = $this->generateSlug($data['name'], $product->id);
        }

        $updated = $this->productRepository->update($product, $data);

        $this->clearProductCache();

        return $updated;
    }
 
    public function deleteProduct(int $id): bool
    {
        $product = $this->productRepository->findById($id);
        $result  = $this->productRepository->delete($product);

        $this->clearProductCache();

        return (bool) $result;
    }
 
    private function generateSku(): string
    {
        do {
            $sku = 'PRD-' . time() . '-' . strtoupper(Str::random(4));
        } while (Product::withTrashed()->where('sku', $sku)->exists());

        return $sku;
    }
 
    private function generateSlug(string $name, ?int $excludeId = null): string
    {
        $slug     = Str::slug($name);
        $original = $slug;
        $counter  = 1;

        while (
            Product::withTrashed()
                ->where('slug', $slug)
                ->when($excludeId, fn ($q) => $q->where('id', '!=', $excludeId))
                ->exists()
        ) {
            $slug = $original . '-' . $counter++;
        }

        return $slug;
    }
 
    private function clearProductCache(): void
    {
        // For file driver we flush all — for Redis you'd use tags
        Cache::flush();
    }
}
