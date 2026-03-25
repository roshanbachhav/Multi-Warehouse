<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderDetailResource extends JsonResource
{
    /**
     * Transform the resource into an array (with items).
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'            => $this->id,
            'order_no'      => $this->order_no,
            'customer_name' => $this->customer_name,
            'warehouse'     => $this->whenLoaded('warehouse', fn () => [
                'id'       => $this->warehouse->id,
                'name'     => $this->warehouse->name,
                'location' => $this->warehouse->location,
            ]),
            'order_status'  => $this->order_status,
            'total_amount'  => (float) $this->total_amount,
            'items'         => $this->whenLoaded('items', function () {
                return $this->items->map(fn ($item) => [
                    'id'         => $item->id,
                    'product_id' => $item->product_id,
                    'product'    => $item->relationLoaded('product') ? [
                        'id'   => $item->product->id,
                        'name' => $item->product->name,
                        'sku'  => $item->product->sku,
                    ] : null,
                    'qty'        => $item->qty,
                    'price'      => (float) $item->price,
                    'subtotal'   => (float) $item->subtotal,
                ]);
            }),
            'created_at'    => $this->created_at?->toDateTimeString(),
            'updated_at'    => $this->updated_at?->toDateTimeString(),
        ];
    }
}
