<?php

namespace App\Listeners;

use App\Events\OrderConfirmed;
use App\Services\StockService;
use Illuminate\Contracts\Queue\ShouldQueue;

class DeductStockOnOrderConfirmed
{
    /**
     * Create the event listener.
     */
    public function __construct(
        private readonly StockService $stockService
    ) {}

    /**
     * Handle the OrderConfirmed event.
     * Deducts stock for each item in the confirmed order.
     *
     * @param  OrderConfirmed  $event
     * @return void
     *
     * @throws \Exception
     */
    public function handle(OrderConfirmed $event): void
    {
        $order = $event->order;

        // Load items if not already loaded
        if (!$order->relationLoaded('items')) {
            $order->load('items');
        }

        foreach ($order->items as $item) {
            $this->stockService->deductStock(
                $item->product_id,
                $order->warehouse_id,
                $item->qty
            );
        }
    }
}
