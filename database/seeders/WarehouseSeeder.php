<?php

namespace Database\Seeders;

use App\Models\Warehouse;
use Illuminate\Database\Seeder;

class WarehouseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $warehouses = [
            ['name' => 'Main Warehouse', 'location' => 'New York'],
            ['name' => 'Secondary Warehouse', 'location' => 'Los Angeles'],
            ['name' => 'Distribution Center', 'location' => 'Chicago'],
        ];

        foreach ($warehouses as $warehouse) {
            Warehouse::create($warehouse);
        }
    }
}
