# Multi-Warehouse Inventory & Order Processing System

A complete Laravel 11 API-based system for managing inventory across multiple warehouses with order processing, status tracking, and reporting.

## Features
- **Authentication**: JWT-based auth using Laravel Sanctum (Admin & Manager roles).
- **Product Management**: SKU/Slug auto-generation, soft deletes, caching.
- **Warehouse Management**: Track stock levels across multiple locations.
- **Stock Control**: Pessimistic locking to prevent race conditions during order fulfillment.
- **Order Processing**: Transactional order creation, confirmation, and cancellation.
- **Event-Driven Architecture**: Stock deduction triggered by `OrderConfirmed` events.
- **Reporting**: Optimized JOIN queries for stock summary and sales reports.

## Setup Instructions

1. **Clone the repository** (if applicable) or navigate to the project folder.
2. **Install Dependencies**:
   ```bash
   composer install
   ```
3. **Configure Environment**:
   ```bash
   cp .env.example .env
   # Update DB_DATABASE, DB_USERNAME, DB_PASSWORD in .env
   ```
4. **Generate App Key**:
   ```bash
   php artisan key:generate
   ```
5. **Run Migrations & Seed**:
   ```bash
   php artisan migrate:fresh --seed
   ```
6. **Cache Configuration**:
   ```bash
   php artisan config:cache
   php artisan route:cache
   ```

## API Documentation

### Authentication
- `POST /api/login`: Authenticate and receive a token.
  - Body: `{"email": "admin@example.com", "password": "password"}`

### Products
- `GET /api/products`: List products (Paginated, filters: `status`, `category`, `search`).
- `POST /api/products`: Create product (Admin only).
- `GET /api/products/{id}`: View product details.
- `PUT /api/products/{id}`: Update product (Admin only).
- `DELETE /api/products/{id}`: Delete product (Admin only).

### Orders
- `GET /api/orders`: List orders (Paginated, filters: `status`, `date_from`, `date_to`).
- `POST /api/orders`: Create a new order (Manager/Admin).
- `GET /api/orders/{id}`: View order details with items.
- `PUT /api/orders/{id}/confirm`: Confirm order and deduct stock (Admin only).
- `PUT /api/orders/{id}/cancel`: Cancel order and restore stock (Admin only).

### Reports
- `GET /api/reports/stock-summary`: Summary of stock levels across warehouses.
- `GET /api/reports/sales`: Sales totals and top 5 selling products.

## Default Credentials
- **Admin**: admin@example.com / password
- **Manager**: manager@example.com / password
