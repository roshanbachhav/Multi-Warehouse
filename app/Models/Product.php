<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Builder;

class Product extends Model
{
    use HasFactory, SoftDeletes;

 
    protected $fillable = [
        'name',
        'slug',
        'sku',
        'category',
        'base_price',
        'status',
    ];

 
    protected $casts = [
        'base_price' => 'decimal:2',
    ];

 
    public function stocks(): HasMany
    {
        return $this->hasMany(Stock::class);
    } 
    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
 
    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', 'active');
    }
 
    public function scopeByCategory(Builder $query, string $category): Builder
    {
        return $query->where('category', $category);
    }
}
