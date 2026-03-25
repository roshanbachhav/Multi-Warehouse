<?php

namespace App\Services;

use App\Events\OrderConfirmed;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Repositories\OrderRepository;
use App\Repositories\StockRepository;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class OrderService
{
    public function __construct(
        private readonly OrderRepository $orderRepository,
        private readonly StockService    $stockService,
        private readonly StockRepository $stockRepository
    ) {}
 
    public function getOrders(array $filters = []): LengthAwarePaginator
    {
        return $this->orderRepository->paginate($filters);
    }
 
    public function getOrder(int $id): Order
    {
        return $this->orderRepository->findWithItems($id);
    }
 
    public function createOrder(array $data): Order
    {
        return DB::transaction(function () use ($data) {
            $warehouseId = $data['warehouse_id'];
            $items       = $data['items'];

            // Validate stock availability for all items before creating anything
            foreach ($items as $item) {
                if (!$this->stockService->checkAvailability($item['product_id'], $warehouseId, $item['qty'])) {
                    $product = Product::find($item['product_id']);
                    throw new \Exception(
                        "Insufficient stock for product: " . ($product?->name ?? "ID {$item['product_id']}")
                    );
                }
            }

            // Create the order header
            $order = $this->orderRepository->create([
                'order_no'      => $this->generateOrderNo(),
                'customer_name' => $data['customer_name'],
                'warehouse_id'  => $warehouseId,
                'order_status'  => 'pending',
                'total_amount'  => 0,
            ]);

            // Create order items and calculate total
            $totalAmount = 0;

            foreach ($items as $item) {
                $product  = Product::findOrFail($item['product_id']);
                $price    = $product->base_price;
                $subtotal = $price * $item['qty'];

                OrderItem::create([
                    'order_id'   => $order->id,
                    'product_id' => $item['product_id'],
                    'qty'        => $item['qty'],
                    'price'      => $price,
                    'subtotal'   => $subtotal,
                ]);

                $totalAmount += $subtotal;
            }

            // Update total_amount server-side
            $order->update(['total_amount' => $totalAmount]);

            return $order->load(['warehouse', 'items.product']);
        });
    }
 
    public function confirmOrder(int $id): Order
    {
        return DB::transaction(function () use ($id) {
            $order = Order::findOrFail($id);

            if (!$order->isPending()) {
                throw new \Exception("Only pending orders can be confirmed. Current status: {$order->order_status}");
            }

            $order->update(['order_status' => 'confirmed']);

            // Fire event — listener will deduct stock inside this transaction
            event(new OrderConfirmed($order));

            return $order->load(['warehouse', 'items.product']);
        });
    }
 
    public function cancelOrder(int $id): Order
    {
        return DB::transaction(function () use ($id) {
            $order = Order::with(['items'])->findOrFail($id);

            if ($order->order_status === 'cancelled') {
                throw new \Exception("Order is already cancelled.");
            }

            $wasConfirmed = $order->isConfirmed();

            $order->update(['order_status' => 'cancelled']);

            // Restore stock if order had been confirmed (stock was deducted)
            if ($wasConfirmed) {
                foreach ($order->items as $item) {
                    $this->stockService->restoreStock(
                        $item->product_id,
                        $order->warehouse_id,
                        $item->qty
                    );
                }
            }

            return $order->load(['warehouse', 'items.product']);
        });
    } 

    private function generateOrderNo(): string
    {
        $date     = now()->format('Ymd');
        $prefix   = "ORD-{$date}-";
        $last     = Order::where('order_no', 'like', $prefix . '%')
                        ->orderByDesc('id')
                        ->lockForUpdate()
                        ->first();

        $sequence = $last ? ((int) substr($last->order_no, strlen($prefix))) + 1 : 1;

        return $prefix . str_pad($sequence, 4, '0', STR_PAD_LEFT);
    }
}
