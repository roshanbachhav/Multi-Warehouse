<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
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
            'created_at'    => $this->created_at?->toDateTimeString(),
            'updated_at'    => $this->updated_at?->toDateTimeString(),
        ];
    }
}
