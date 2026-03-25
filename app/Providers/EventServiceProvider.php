<?php

namespace App\Providers;

use App\Events\OrderConfirmed;
use App\Listeners\DeductStockOnOrderConfirmed;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    protected $listen = [
        OrderConfirmed::class => [
            DeductStockOnOrderConfirmed::class,
        ],
    ];
 
    public function boot(): void
    {
        parent::boot();
    }
 
    public function shouldDiscoverEvents(): bool
    {
        return false;
    }
}
