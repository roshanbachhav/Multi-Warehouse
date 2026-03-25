-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2026 at 06:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_03_25_154650_create_products_table', 1),
(5, '2026_03_25_154651_create_warehouses_table', 1),
(6, '2026_03_25_154652_create_stocks_table', 1),
(7, '2026_03_25_154653_create_orders_table', 1),
(8, '2026_03_25_154654_create_order_items_table', 1),
(9, '2026_03_25_165140_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_no` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `order_status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_no`, `customer_name`, `warehouse_id`, `order_status`, `total_amount`, `created_at`, `updated_at`) VALUES
(1, 'ORD-20260325-0001', 'Customer 1', 1, 'cancelled', 3785.00, '2026-03-25 11:22:51', '2026-03-25 11:47:00'),
(2, 'ORD-20260325-0002', 'Customer 2', 3, 'confirmed', 6573.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(3, 'ORD-20260325-0003', 'Customer 3', 1, 'pending', 1280.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(4, 'ORD-20260325-0004', 'Customer 4', 2, 'confirmed', 2244.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(5, 'ORD-20260325-0005', 'Customer 5', 1, 'pending', 1766.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(6, 'ORD-20260325-0006', 'Customer 6', 1, 'confirmed', 1280.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(7, 'ORD-20260325-0007', 'Customer 7', 2, 'pending', 1140.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(8, 'ORD-20260325-0008', 'Customer 8', 1, 'confirmed', 1704.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(9, 'ORD-20260325-0009', 'Customer 9', 3, 'pending', 1835.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(10, 'ORD-20260325-0010', 'Customer 10', 2, 'confirmed', 5078.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(10) UNSIGNED NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `qty`, `price`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 5, 757.00, 3785.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(2, 2, 1, 5, 348.00, 1740.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(3, 2, 8, 1, 570.00, 570.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(4, 2, 9, 3, 850.00, 2550.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(5, 2, 13, 3, 571.00, 1713.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(6, 3, 19, 5, 256.00, 1280.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(7, 4, 20, 4, 561.00, 2244.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(8, 5, 1, 1, 348.00, 348.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(9, 5, 2, 1, 130.00, 130.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(10, 5, 11, 2, 388.00, 776.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(11, 5, 19, 2, 256.00, 512.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(12, 6, 19, 5, 256.00, 1280.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(13, 7, 8, 2, 570.00, 1140.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(14, 8, 5, 3, 568.00, 1704.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(15, 9, 10, 1, 679.00, 679.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(16, 9, 15, 4, 289.00, 1156.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(17, 10, 7, 3, 813.00, 2439.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(18, 10, 12, 4, 457.00, 1828.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(19, 10, 18, 1, 811.00, 811.00, '2026-03-25 11:22:51', '2026-03-25 11:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'test-token', 'cabd1d2fa08108d602458b3e989e030cfb49f94f9b77fcd1754ba4f0ec3caac6', '[\"*\"]', NULL, NULL, '2026-03-25 11:23:10', '2026-03-25 11:23:10'),
(2, 'App\\Models\\User', 1, 'api-token', '5244649506cb201dcb05fd5ef13e207c7381e59f99aa635c1d0333edc6866d74', '[\"*\"]', '2026-03-25 11:51:51', NULL, '2026-03-25 11:24:08', '2026-03-25 11:51:51'),
(3, 'App\\Models\\User', 2, 'api-token', 'db734065700a4a7317c5ac156f3f94d8497cea79ebe6ee2f46877eb2c5c33c0b', '[\"*\"]', '2026-03-25 11:43:02', NULL, '2026-03-25 11:42:39', '2026-03-25 11:43:02');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `sku`, `category`, `base_price`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Product 1', 'product-1-1774457571-1', 'PRD-HPT0JEDR', 'Furniture', 348.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(2, 'Product 2', 'product-2-1774457571-2', 'PRD-JJ1MM6RJ', 'Furniture', 130.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(3, 'Product 3', 'product-3-1774457571-3', 'PRD-VPMPU7F6', 'Clothing', 411.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(4, 'Product 4', 'product-4-1774457571-4', 'PRD-U6O1GGTW', 'Books', 732.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(5, 'Product 5', 'product-5-1774457571-5', 'PRD-DSEPJTPA', 'Clothing', 568.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(6, 'Product 6', 'product-6-1774457571-6', 'PRD-VX6VDLLC', 'Home Appliances', 757.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(7, 'Product 7', 'product-7-1774457571-7', 'PRD-UQCGCKRG', 'Furniture', 813.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(8, 'Product 8', 'product-8-1774457571-8', 'PRD-XFCCAGHN', 'Books', 570.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(9, 'Product 9', 'product-9-1774457571-9', 'PRD-WJDHPNFG', 'Home Appliances', 850.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(10, 'Product 10', 'product-10-1774457571-10', 'PRD-MW0DSH6N', 'Furniture', 679.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(11, 'Product 11', 'product-11-1774457571-11', 'PRD-AWKII3HJ', 'Home Appliances', 388.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(12, 'Product 12', 'product-12-1774457571-12', 'PRD-4WEGH6HV', 'Furniture', 457.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(13, 'Product 13', 'product-13-1774457571-13', 'PRD-KGHUOAVD', 'Furniture', 571.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(14, 'Product 14', 'product-14-1774457571-14', 'PRD-C3WEDRSZ', 'Electronics', 296.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(15, 'Product 15', 'product-15-1774457571-15', 'PRD-IQ7BAHWG', 'Electronics', 289.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(16, 'Product 16', 'product-16-1774457571-16', 'PRD-XHIPB6XM', 'Home Appliances', 699.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(17, 'Product 17', 'product-17-1774457571-17', 'PRD-IYLNQGJA', 'Furniture', 903.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(18, 'Product 18', 'product-18-1774457571-18', 'PRD-YKCIL21G', 'Books', 811.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(19, 'Product 19', 'product-19-1774457571-19', 'PRD-LHORLCIW', 'Books', 256.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(20, 'Product 20', 'product-20-1774457571-20', 'PRD-YZOL91CI', 'Furniture', 561.00, 'active', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `warehouse_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 65, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(2, 1, 2, 171, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(3, 1, 3, 195, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(4, 2, 1, 152, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(5, 2, 2, 164, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(6, 2, 3, 167, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(7, 3, 1, 89, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(8, 3, 2, 189, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(9, 3, 3, 172, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(10, 4, 1, 136, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(11, 4, 2, 166, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(12, 4, 3, 145, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(13, 5, 1, 192, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(14, 5, 2, 61, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(15, 5, 3, 88, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(16, 6, 1, 97, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(17, 6, 2, 54, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(18, 6, 3, 74, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(19, 7, 1, 118, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(20, 7, 2, 182, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(21, 7, 3, 176, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(22, 8, 1, 195, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(23, 8, 2, 142, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(24, 8, 3, 115, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(25, 9, 1, 135, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(26, 9, 2, 77, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(27, 9, 3, 190, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(28, 10, 1, 121, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(29, 10, 2, 163, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(30, 10, 3, 161, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(31, 11, 1, 184, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(32, 11, 2, 153, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(33, 11, 3, 134, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(34, 12, 1, 191, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(35, 12, 2, 114, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(36, 12, 3, 136, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(37, 13, 1, 198, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(38, 13, 2, 110, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(39, 13, 3, 155, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(40, 14, 1, 114, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(41, 14, 2, 180, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(42, 14, 3, 58, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(43, 15, 1, 137, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(44, 15, 2, 171, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(45, 15, 3, 120, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(46, 16, 1, 109, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(47, 16, 2, 182, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(48, 16, 3, 55, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(49, 17, 1, 184, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(50, 17, 2, 174, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(51, 17, 3, 66, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(52, 18, 1, 193, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(53, 18, 2, 120, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(54, 18, 3, 195, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(55, 19, 1, 116, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(56, 19, 2, 140, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(57, 19, 3, 85, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(58, 20, 1, 119, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(59, 20, 2, 98, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(60, 20, 3, 136, '2026-03-25 11:22:51', '2026-03-25 11:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','manager') NOT NULL DEFAULT 'manager',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@example.com', NULL, '$2y$12$vKpMyeA8ZhGcSPxNSLok9uJdhV3dnizOK1cJTWrd/JLOfgajCMA/a', 'admin', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(2, 'Manager User', 'manager@example.com', NULL, '$2y$12$N5ztq4N0Y0cv/YdNYeqcF.gLUdj.QYL35gm31nhfAx6y3vztZRRfG', 'manager', NULL, '2026-03-25 11:22:51', '2026-03-25 11:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(1, 'Main Warehouse', 'Nashik', '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(2, 'Secondary Warehouse', 'Pune', '2026-03-25 11:22:51', '2026-03-25 11:22:51'),
(3, 'Distribution Center', 'Mumbai', '2026-03-25 11:22:51', '2026-03-25 11:22:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_order_no_unique` (`order_no`),
  ADD KEY `orders_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `orders_order_no_index` (`order_no`),
  ADD KEY `orders_order_status_index` (`order_status`),
  ADD KEY `orders_created_at_index` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`),
  ADD KEY `products_sku_index` (`sku`),
  ADD KEY `products_slug_index` (`slug`),
  ADD KEY `products_status_index` (`status`),
  ADD KEY `products_category_index` (`category`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stocks_product_id_warehouse_id_unique` (`product_id`,`warehouse_id`),
  ADD KEY `stocks_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stocks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
