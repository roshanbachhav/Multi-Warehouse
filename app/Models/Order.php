<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Builder;

class Order extends Model
{
    use HasFactory;
 
    protected $fillable = [
        'order_no',
        'customer_name',
        'warehouse_id',
        'order_status',
        'total_amount',
    ];
 
    protected $casts = [
        'total_amount' => 'decimal:2',
    ];
 
    public function warehouse(): BelongsTo
    {
        return $this->belongsTo(Warehouse::class);
    }
 
    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
 
    public function scopeByStatus(Builder $query, string $status): Builder
    {
        return $query->where('order_status', $status);
    }
 
    public function scopeDateRange(Builder $query, string $from, string $to): Builder
    {
        return $query->whereDate('created_at', '>=', $from)
                     ->whereDate('created_at', '<=', $to);
    }
 
    public function isConfirmed(): bool
    {
        return $this->order_status === 'confirmed';
    }
 
    public function isPending(): bool
    {
        return $this->order_status === 'pending';
    }
}
