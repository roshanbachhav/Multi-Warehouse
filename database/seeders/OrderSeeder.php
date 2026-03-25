<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\Warehouse;
use Illuminate\Database\Seeder;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $warehouses = Warehouse::all();
        $products = Product::all();

        for ($i = 1; $i <= 10; $i++) {
            $warehouse = $warehouses->random();
            
            $order = Order::create([
                'order_no' => 'ORD-' . date('Ymd') . '-' . str_pad($i, 4, '0', STR_PAD_LEFT),
                'customer_name' => 'Customer ' . $i,
                'warehouse_id' => $warehouse->id,
                'order_status' => $i % 2 == 0 ? 'confirmed' : 'pending',
                'total_amount' => 0,
            ]);

            $totalAmount = 0;
            $itemsCount = rand(1, 4);
            $selectedProducts = $products->random($itemsCount);

            foreach ($selectedProducts as $product) {
                $qty = rand(1, 5);
                $price = $product->base_price;
                $subtotal = $qty * $price;

                OrderItem::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'qty' => $qty,
                    'price' => $price,
                    'subtotal' => $subtotal,
                ]);

                $totalAmount += $subtotal;
            }

            $order->update(['total_amount' => $totalAmount]);
        }
    }
}
