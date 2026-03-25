<?php

namespace App\Services;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class ReportService
{ 
    public function getStockSummary(): array
    {
        return Cache::remember('report_stock_summary', 1800, function () {
            return DB::table('stocks')
                ->join('products', 'stocks.product_id', '=', 'products.id')
                ->join('warehouses', 'stocks.warehouse_id', '=', 'warehouses.id')
                ->leftJoin('order_items', function ($join) {
                    $join->on('order_items.product_id', '=', 'stocks.product_id');
                })
                ->leftJoin('orders', function ($join) {
                    $join->on('orders.id', '=', 'order_items.order_id')
                         ->where('orders.order_status', '=', 'confirmed')
                         ->whereRaw('orders.warehouse_id = stocks.warehouse_id');
                })
                ->whereNull('products.deleted_at')
                ->select(
                    'products.id as product_id',
                    'products.name as product_name',
                    'products.sku',
                    'warehouses.id as warehouse_id',
                    'warehouses.name as warehouse_name',
                    'stocks.quantity as current_stock',
                    DB::raw('COALESCE(SUM(order_items.qty), 0) as sold_quantity'),
                    DB::raw('(stocks.quantity + COALESCE(SUM(order_items.qty), 0)) as opening_stock')
                )
                ->groupBy(
                    'stocks.product_id',
                    'stocks.warehouse_id',
                    'products.id',
                    'products.name',
                    'products.sku',
                    'warehouses.id',
                    'warehouses.name',
                    'stocks.quantity'
                )
                ->orderBy('products.name')
                ->orderBy('warehouses.name')
                ->get()
                ->toArray();
        });
    }
 
    public function getSalesReport(?string $dateFrom = null, ?string $dateTo = null): array
    {
        $cacheKey = 'report_sales_' . md5($dateFrom . $dateTo);

        return Cache::remember($cacheKey, 1800, function () use ($dateFrom, $dateTo) {
            // Daily sales totals
            $dailySalesQuery = DB::table('orders')
                ->where('order_status', 'confirmed')
                ->select(
                    DB::raw('DATE(created_at) as date'),
                    DB::raw('COUNT(*) as total_orders'),
                    DB::raw('SUM(total_amount) as total_revenue')
                );

            if ($dateFrom) {
                $dailySalesQuery->whereDate('created_at', '>=', $dateFrom);
            }
            if ($dateTo) {
                $dailySalesQuery->whereDate('created_at', '<=', $dateTo);
            }

            $dailySales = $dailySalesQuery
                ->groupBy(DB::raw('DATE(created_at)'))
                ->orderBy('date', 'desc')
                ->get();

            // Top 5 selling products
            $topProductsQuery = DB::table('order_items')
                ->join('orders', 'orders.id', '=', 'order_items.order_id')
                ->join('products', 'products.id', '=', 'order_items.product_id')
                ->where('orders.order_status', 'confirmed')
                ->select(
                    'products.id as product_id',
                    'products.name as product_name',
                    'products.sku',
                    DB::raw('SUM(order_items.qty) as total_qty_sold'),
                    DB::raw('SUM(order_items.subtotal) as total_revenue')
                );

            if ($dateFrom) {
                $topProductsQuery->whereDate('orders.created_at', '>=', $dateFrom);
            }
            if ($dateTo) {
                $topProductsQuery->whereDate('orders.created_at', '<=', $dateTo);
            }

            $topProducts = $topProductsQuery
                ->groupBy('products.id', 'products.name', 'products.sku')
                ->orderByDesc('total_qty_sold')
                ->limit(5)
                ->get();

            return [
                'daily_sales'  => $dailySales,
                'top_products' => $topProducts,
                'date_from'    => $dateFrom,
                'date_to'      => $dateTo,
            ];
        });
    }
}
