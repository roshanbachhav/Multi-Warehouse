<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\Stock;
use App\Models\Warehouse;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = ['Electronics', 'Home Appliances', 'Furniture', 'Clothing', 'Books'];
        
        for ($i = 1; $i <= 20; $i++) {
            $name = "Product " . $i;
            $product = Product::create([
                'name' => $name,
                'slug' => Str::slug($name) . '-' . time() . '-' . $i,
                'sku' => 'PRD-' . strtoupper(Str::random(8)),
                'category' => $categories[array_rand($categories)],
                'base_price' => rand(100, 1000),
                'status' => 'active',
            ]);

            // Create initial stocks for each product in random warehouses
            $warehouses = Warehouse::all();
            foreach ($warehouses as $warehouse) {
                Stock::create([
                    'product_id' => $product->id,
                    'warehouse_id' => $warehouse->id,
                    'quantity' => rand(50, 200),
                ]);
            }
        }
    }
}
