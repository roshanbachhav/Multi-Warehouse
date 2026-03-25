# Multi-Warehouse Inventory & Order Processing System (Laravel 11)

A professional, high-performance Inventory Management System built with **Laravel 11**. This project demonstrates advanced backend architecture, including role-based authentication, event-driven stock management, and optimized reporting.

---

## 🛠️ Key Technical Highlights (Interview Ready)

### 1. Robust Authentication (Laravel Sanctum)
- **Role-Based Access Control (RBAC):** Implemented custom middleware (`CheckAdmin`, `CheckManager`) to secure API endpoints.
- **Token Management:** Uses Sanctum to issue secure API tokens for mobile or frontend consumers. 
- **User Roles:**
    - `Admin`: Full access to Products, Warehouses, Orders, and Reports.
    - `Manager`: Access to create Orders and view Reports.

### 2. Clean Architecture Pattern
- **Service Layer:** All business logic is kept in `app/Services`, making the code testable and reusable.
- **Repository Pattern:** Separates database queries from business logic for better maintainability.
- **API Resources:** Standardized JSON responses for consistent frontend integration.

### 3. Advanced Stock Integrity (Architecture Check)
- **Pessimistic Locking:** Uses `lockForUpdate()` during stock deduction to prevent "Race Conditions" (where two orders might accidentally sell the same last item).
- **Event-Driven Deduction:** Implemented an `OrderConfirmed` **Event** and a **Listener**. Stock is only deducted when the event fires, ensuring the fulfillment process is decoupled and reliable.

### 4. Optimized Reporting & Aggregation
- **Stock Summary:** Efficient SQL `JOIN` queries calculate *Opening Stock*, *Sold Quantity*, and *Current Stock* in a single pass.
- **Sales Analytics:** Aggregated reports for "Date-wise Sales" and "Top 5 Selling Products" using high-performance Eloquent/DB grouping.
- **Caching:** Implemented caching for reports to reduce database load.

---

## 🚀 Modules & Features Included

- **Product Module:** Auto-generates unique SKUs and SEO-friendly slugs. Includes "Soft Deletes" to prevent data loss.
- **Stock Module:** Handles multi-warehouse quantity tracking.
- **Order Module:** Managed within **Database Transactions**. If any part of the order creation fails, the entire process rolls back, ensuring no partial/broken data.
- **Event Module:** Handles triggered actions (like stock deduction) outside the main order lifecycle.

---

## 🛠️ Step-by-Step Implementation Flow

1.  **Project Initialization:** Set up Laravel 11 with a clean MySQL environment.
2.  **Database Design:** Created 6 migrations with proper foreign keys, unique constraints, and indexes for speed.
3.  **Authentication Setup:** Configured Sanctum and built the `AuthController` with Login/Logout functionality.
4.  **Service Development:**
    - `ProductService`: Logic for SKUs/Slugs/Cache.
    - `StockService`: Logic for checking/deducting/restoring stock.
    - `OrderService`: The core transactional engine for the $1 million logic (Orders).
5.  **Event Integration:** Registered the `OrderConfirmed` event-listener mapping.
6.  **Reporting:** Built the `ReportService` with optimized SQL aggregation.
7.  **Final Verification:** Seeded the database with sample data and verified all flows using a comprehensive Postman collection.

---

## 🚦 How to Setup

1.  **Install dependencies:** `composer install`
2.  **Env Setup:** `cp .env.example .env` (Update DB credentials)
3.  **Migration & Seeding:** `php artisan migrate:fresh --seed`
4.  **Routes/Config Cache:** `php artisan config:cache && php artisan route:cache`
5.  **Run Server:** `php artisan serve`

---

## 📄 Documentation Assets
- **Postman Collection:** [postman_collection.json](file:///d:/Job%20Projects/inventory-system/postman_collection.json)
- **Architecture Details:** See `app/Services` and `app/Listeners`.
