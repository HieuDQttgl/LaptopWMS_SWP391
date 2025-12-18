CREATE DATABASE  IF NOT EXISTS `laptop_wms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptop_wms`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: laptop_wms
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'ABC Tech Company','contact@abc.com','0901234567','10th Floor, Tower A, HCMC'),(2,'Retail Store Minh Khoi','minh.khoi@shop.com','0389012345','123 Nguyen Van Linh St, Hanoi'),(3,'Hanoi University','hanu.uni@edu.vn','0245678901','A Campus'),(4,'Customer Test','customer@email.com','092878347','231 Shiba, Ha Noi'),(5,'Công Ty TNHH Giải Pháp Số VietTech','contact@viettech-solutions.vn','0912567890','Tầng 5, Tòa nhà Keangnam, Nam Từ Liêm, Hà Nội'),(6,'Cửa Hàng Máy Tính Bảo Long','baolong.computer@gmail.com','0385621993','158 Nguyễn Thị Minh Khai, Quận 3, TP. Hồ Chí Minh'),(7,'Công Ty CP Thương Mại Hưng Thịnh','sales@hungthinh-trading.com','0909112334','45 Lê Duẩn, Hải Châu, Đà Nẵng');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `inventory_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `location_id` int NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `unique_inv_loc_prod` (`product_id`,`location_id`),
  KEY `fk_inv_location` (`location_id`),
  CONSTRAINT `fk_inv_location` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`),
  CONSTRAINT `fk_inv_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,1,20,'2025-12-12 00:55:43'),(2,2,2,15,'2025-12-12 00:55:43'),(3,3,1,30,'2025-12-12 00:55:43'),(4,4,1,10,'2025-12-12 00:55:43');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aisle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rack` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_name` (`location_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'General','Standard storage area','Zone A',NULL,NULL,NULL),(2,'Controlled','Temperature controlled area','Zone B',NULL,NULL,NULL),(3,'Shipping','Packing and staging area','Zone C',NULL,NULL,NULL);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'User who will receive the notification (Admin)',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type of notification: password_reset, etc.',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `related_user_id` int DEFAULT NULL COMMENT 'User related to this notification (e.g., user who requested password reset)',
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `fk_notification_user` (`user_id`),
  KEY `fk_notification_related_user` (`related_user_id`),
  KEY `idx_notification_type` (`type`),
  KEY `idx_notification_read` (`is_read`),
  CONSTRAINT `fk_notification_related_user` FOREIGN KEY (`related_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,1,'password_reset','Password Reset Request','User \'sale1\' (b@gmail.com) has requested a password reset.\n\nUser Details:\n- Full Name: Nguyễn Thị B\n- Username: sale1\n- Email: b@gmail.com\n- User ID: 3\n\nPlease reset their password and notify them.',3,0,'2025-12-17 15:49:51',NULL),(2,1,'password_reset','Password Reset Request','User \'keeper1\' (aaa1@gmail.com) has requested a password reset.\n\nUser Details:\n- Full Name: Nguyen Van A\n- Username: keeper1\n- Email: aaa1@gmail.com\n- User ID: 2\n\nPlease reset their password and notify them.',2,0,'2025-12-17 15:51:13',NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_products` (
  `order_product_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_detail_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`order_product_id`),
  UNIQUE KEY `unique_order_prod` (`order_id`,`product_detail_id`),
  KEY `fk_op_product_detail` (`product_detail_id`),
  CONSTRAINT `fk_op_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_op_product_details` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`product_detail_id`),
  CONSTRAINT `order_products_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` VALUES (17,1,1,1,650.00),(18,1,2,2,999.00),(19,2,3,1,1200.00),(20,5,4,3,550.00),(21,5,5,1,2400.00),(22,6,6,2,1100.00),(23,7,7,1,1800.00),(24,7,42,1,850.00),(25,8,8,5,720.00),(26,9,9,1,1350.00),(27,9,10,1,1500.00),(28,10,11,2,800.00),(29,10,12,1,1150.00),(30,11,13,1,950.00),(31,12,14,2,1050.00),(32,12,15,1,1400.00),(33,13,43,1,2100.00),(34,14,1,1,650.00);
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` int NOT NULL,
  `order_status` enum('pending','approved','shipping','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `customer_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_code` (`order_code`),
  KEY `fk_order_user` (`created_by`),
  KEY `fk_order_customer` (`customer_id`),
  KEY `fk_order_supplier` (`supplier_id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_order_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `chk_order_partner` CHECK ((((`customer_id` is not null) and (`supplier_id` is null)) or ((`customer_id` is null) and (`supplier_id` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'IMP-2025001','Quarterly replenishment from main supplier.',3,'completed',NULL,1,'2025-12-12 01:01:09','2025-12-18 03:18:17'),(2,'EXP-2025002','Urgent export order for major client.',2,'shipping',1,NULL,'2025-12-12 01:01:09','2025-12-16 14:41:44'),(5,'EXP-2025003','Đơn hàng test tự động từ Main.',1,'approved',1,NULL,'2025-12-16 03:30:55','2025-12-16 15:42:18'),(6,'EXP-2025004','Nhanh Nhá',2,'pending',1,NULL,'2025-12-16 03:46:57','2025-12-16 03:46:57'),(7,'IMP-2025002','Nhanh nhé',3,'pending',NULL,3,'2025-12-16 03:48:10','2025-12-18 03:24:25'),(8,'EXP-2025005','nhanh',2,'cancelled',2,NULL,'2025-12-16 03:57:47','2025-12-16 15:10:26'),(9,'EXP-2025006','Hello',2,'pending',2,NULL,'2025-12-16 04:13:11','2025-12-16 04:13:10'),(10,'EXP-2025007','J dzậy trời',2,'pending',2,NULL,'2025-12-16 04:28:52','2025-12-16 04:28:51'),(11,'EXP-2025008','hahaha',2,'pending',1,NULL,'2025-12-16 04:29:34','2025-12-16 04:29:34'),(12,'EXP-2025009','Haha',3,'pending',2,NULL,'2025-12-16 04:33:32','2025-12-18 03:17:55'),(13,'EXP-2025010','123',3,'pending',2,NULL,'2025-12-16 04:44:39','2025-12-18 03:17:55'),(14,'EXP-2025011','Haha',3,'shipping',2,NULL,'2025-12-16 04:50:06','2025-12-18 03:22:57');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'e.g., user.view, user.create, product.manage',
  `permission_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Module name: user, product, warehouse, order, etc.',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permission_name` (`permission_url`),
  KEY `idx_permission_name` (`permission_url`),
  KEY `idx_module` (`module`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'/landing','User homepage','common','2025-12-03 12:19:13','2025-12-08 14:10:12'),(2,'/user-list','View user list','admin','2025-12-03 12:19:13','2025-12-08 14:10:12'),(4,'/user-detail','View user details','admin','2025-12-03 12:19:13','2025-12-08 14:10:12'),(5,'/user-status','Update user status','admin','2025-12-03 12:19:13','2025-12-08 14:10:12'),(6,'/edit-role','Edit user role','role','2025-12-03 12:19:13','2025-12-08 14:10:12'),(7,'/add-role','Create new roles','role','2025-12-03 12:19:13','2025-12-08 14:10:12'),(8,'/role','View role status','role','2025-12-03 12:19:13','2025-12-08 14:10:12'),(9,'/role-list','Change role status','role','2025-12-03 12:19:13','2025-12-08 14:10:12'),(10,'/role-permission','Manage role permissions','role','2025-12-03 12:19:13','2025-12-08 14:10:12'),(11,'/profile','View own profile','profile','2025-12-03 12:19:13','2025-12-08 14:10:12'),(12,'/change-password','Change own password','profile','2025-12-03 12:19:13','2025-12-08 14:10:12'),(13,'/edit-profile','Edit own profile','profile','2025-12-03 12:19:13','2025-12-08 14:10:12'),(14,'/login','Login to system','common','2025-12-03 12:19:13','2025-12-08 14:10:12'),(15,'/logout','Logout from system','common','2025-12-03 12:19:13','2025-12-08 14:10:12'),(16,'/forgot','Allow user to recover password','common','2025-12-08 14:10:12','2025-12-08 14:10:12'),(17,'/product-list','View products list','product','2025-12-15 04:25:56','2025-12-15 04:53:13'),(18,'/add-product','Add new product','product','2025-12-15 04:25:56','2025-12-15 04:25:56'),(19,'/edit-product','Edit product details','product','2025-12-15 04:25:56','2025-12-15 04:25:56'),(20,'/product-detail','View product details','product','2025-12-15 04:25:56','2025-12-15 04:25:56'),(21,'/toggleProduct','Activate/Deactivate product','product','2025-12-15 04:25:56','2025-12-15 04:25:56'),(22,'/supplier-list','View suppliers list','supplier','2025-12-15 04:25:56','2025-12-15 04:25:56'),(23,'/supplier-detail','View supplier details','supplier','2025-12-15 04:25:56','2025-12-15 04:25:56'),(24,'/add-supplier','Add new supplier','supplier','2025-12-15 04:25:56','2025-12-15 04:25:56'),(25,'/edit-supplier','Edit supplier details','supplier','2025-12-15 04:25:56','2025-12-15 04:25:56'),(26,'/list-all-urls','View all URL mappings (Debug tool)','admin','2025-12-15 04:48:28','2025-12-15 04:48:28'),(27,'/order-list','View order list','order','2025-12-15 14:38:44','2025-12-15 14:39:33'),(28,'/order-detail','View order detail','order','2025-12-15 14:38:44','2025-12-15 14:38:44'),(29,'/inventory','View Inventory','inventory','2025-12-16 02:32:25','2025-12-16 02:32:25'),(30,'/audit-inventory','Inventory Auditing','inventory','2025-12-16 02:32:25','2025-12-16 02:32:25'),(31,'/add-inventory','Add new product to inventory','inventory','2025-12-16 04:49:37','2025-12-16 04:49:37'),(32,'/add-product-detail','Add product configuration details','product','2025-12-15 08:35:33','2025-12-16 04:16:39'),(33,'/edit-product-detail','Edit product details','product','2025-12-16 04:11:53','2025-12-16 04:11:53'),(34,'/toggleSpec','Activate/Deactivate product details','product','2025-12-16 04:21:46','2025-12-16 04:24:25'),(35,'/add-order','Add new order','order','2025-12-17 02:49:51','2025-12-17 02:49:51'),(36,'/order-status','Update order status','order','2025-12-17 02:49:51','2025-12-17 02:49:51'),(37,'/customer-list','View customer list','customer','2025-12-17 03:18:16','2025-12-17 03:18:16'),(38,'/customer-detail','View detail of a customer','customer','2025-12-17 03:18:16','2025-12-17 03:18:16'),(39,'/add-customer','Add a new customer',NULL,'2025-12-17 09:58:29','2025-12-17 09:58:29'),(40,'/edit-customer','Edit customer details',NULL,'2025-12-17 09:58:29','2025-12-17 09:58:29'),(41,'/dashboard','View Main Dashboard','common','2025-12-18 03:02:49','2025-12-18 03:02:49');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_details` (
  `product_detail_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `ram` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `screen` double DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`product_detail_id`),
  KEY `fk_details_product` (`product_id`),
  CONSTRAINT `fk_details_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,1,'16GB','512GB','Intel Core i7-1360P','Intel Iris Xe',13.4,1),(2,2,'16GB','512GB','Apple M3 Pro','14-core GPU',16.2,1),(3,3,'8GB','256GB','Intel Core i3-1115G4','Intel UHD',15.6,1),(4,4,'32GB','1TB','Intel Core i7-1355U','Intel Iris Xe',14,1),(5,5,'32GB','1TB','Intel Core i9-13980HX','NVIDIA RTX 4090',18,1),(6,6,'16GB','1TB','Intel Core i7-13700HX','NVIDIA RTX 4070',16,0),(7,7,'32GB','2TB','Intel Core i9-13980HX','NVIDIA RTX 4080',17,1),(8,7,'64GB','4TB','Intel Core i9-13980HX','NVIDIA RTX 4090',17,1),(9,8,'64GB','2TB','Intel Core i9-13950HX','NVIDIA RTX 5000 Ada',16,0),(10,8,'128GB','8TB','Intel Core i9-13950HX','NVIDIA RTX 5000 Ada',16,1),(11,9,'64GB','2TB','Intel Core i7-13850HX','NVIDIA RTX 3500 Ada',17.3,1),(12,1,'32GB','1TB','Intel Core i7-1360P','Intel Iris Xe',13.4,1),(13,2,'36GB','1TB','Apple M3 Pro','18-core GPU',16.2,1),(14,2,'96GB','4TB','Apple M3 Max','40-core GPU',16.2,1),(15,4,'16GB','512GB','Intel Core i5-1335U','Intel Iris Xe',14,0),(42,10,'8GB','512GB','AMD Ryzen 5-5600H','NVIDIA RTX 3050 Ti 4GB',16,1),(43,10,'32gb','512gb','ccccc','dddddd',21,1);
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_items`
--

DROP TABLE IF EXISTS `product_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_items` (
  `items_id` int NOT NULL AUTO_INCREMENT,
  `product_detail_id` int NOT NULL,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Available','Sold','Lost','Damaged') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Available',
  `items_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`items_id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `product_detail_id` (`product_detail_id`),
  CONSTRAINT `product_items_ibfk_1` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`product_detail_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_items`
--

LOCK TABLES `product_items` WRITE;
/*!40000 ALTER TABLE `product_items` DISABLE KEYS */;
INSERT INTO `product_items` VALUES (1,1,'DELL-001','Available',''),(2,1,'DELL-002','Available',''),(3,1,'DELL-003','Available',''),(4,1,'SN-004','Available',''),(5,1,'SN-005','Available',''),(6,2,'SN-006','Available',''),(7,2,'SN-007','Sold','Sold to Custommer A'),(8,3,'SN-008','Available',''),(9,3,'SN-009','Damaged','Broken screen'),(10,4,'SN-010','Available',''),(11,4,'SN-011','Available',''),(12,5,'SN-012','Available',''),(13,5,'SN-013','Lost','Cant find in storage'),(14,6,'SN-014','Available',''),(15,6,'SN-015','Available',''),(16,7,'SN-016','Available',''),(17,7,'SN-017','Available',''),(18,8,'SN-018','Available',''),(19,8,'SN-019','Damaged','Damaged ICs'),(20,9,'SN-020','Available',''),(21,9,'SN-021','Sold','Sold for Custommer B'),(22,10,'SN-022','Available',''),(23,10,'SN-023','Available',''),(24,11,'SN-024','Available',''),(25,11,'SN-025','Available',''),(26,12,'SN-026','Sold','Shipped'),(27,12,'SN-027','Available',''),(28,13,'SN-028','Lost','Idk where'),(29,13,'SN-029','Available',''),(30,14,'SN-030','Lost','Stolen'),(31,14,'SN-031','Available',''),(32,15,'SN-032','Available',''),(33,15,'SN-033','Damaged','Damaged keybroad');
/*!40000 ALTER TABLE `product_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `supplier_id` int DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'unit',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`product_id`),
  KEY `fk_product_supplier` (`supplier_id`),
  CONSTRAINT `fk_product_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Dell XPS 13 (Core i7, 16GB)','Dell','Office',1,'piece',1),(2,'Macbook Pro M3 (16 inch)','Apple','Office',2,'piece',1),(3,'Dell Vostro 3500 (Core i3)','Dell','Office',1,'piece',1),(4,'Lenovo ThinkPad X1 Carbon','Lenovo','Gaming',3,'piece',1),(5,'ASUS ROG Strix Scar 18','ASUS','Gaming',4,'piece',1),(6,'Acer Predator Helios 16','Acer','Gaming',5,'piece',0),(7,'MSI Raider GE78','MSI','Gaming',6,'piece',1),(8,'HP ZBook Fury 16 G10','HP','Workstation',7,'piece',1),(9,'Dell Precision 7780','Dell','Workstation',1,'piece',1),(10,'Test Product (Empty Specs)','Dell','Office',1,'piece',1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_permission_id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `granted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `granted_by` int DEFAULT NULL COMMENT 'User who granted this permission',
  PRIMARY KEY (`role_permission_id`),
  UNIQUE KEY `unique_role_permission` (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  KEY `fk_role_permissions_granted_by` (`granted_by`),
  CONSTRAINT `fk_role_permissions_granted_by` FOREIGN KEY (`granted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (199,1,1,'2025-12-08 14:50:25',NULL),(200,1,2,'2025-12-08 14:50:25',NULL),(201,1,4,'2025-12-08 14:50:25',NULL),(202,1,5,'2025-12-08 14:50:25',NULL),(203,1,6,'2025-12-08 14:50:25',NULL),(204,1,7,'2025-12-08 14:50:25',NULL),(205,1,8,'2025-12-08 14:50:25',NULL),(206,1,9,'2025-12-08 14:50:25',NULL),(207,1,10,'2025-12-08 14:50:25',NULL),(208,1,11,'2025-12-08 14:50:25',NULL),(209,1,12,'2025-12-08 14:50:25',NULL),(210,1,13,'2025-12-08 14:50:25',NULL),(211,1,14,'2025-12-08 14:50:25',NULL),(212,1,15,'2025-12-08 14:50:25',NULL),(213,1,16,'2025-12-08 14:50:25',NULL),(226,1,18,'2025-12-15 04:25:56',NULL),(227,1,24,'2025-12-15 04:25:56',NULL),(228,1,19,'2025-12-15 04:25:56',NULL),(229,1,25,'2025-12-15 04:25:56',NULL),(230,1,20,'2025-12-15 04:25:56',NULL),(231,1,17,'2025-12-15 04:25:56',NULL),(232,1,23,'2025-12-15 04:25:56',NULL),(233,1,22,'2025-12-15 04:25:56',NULL),(234,1,21,'2025-12-15 04:25:56',NULL),(263,1,26,'2025-12-15 04:48:28',NULL),(322,1,29,'2025-12-15 15:35:33',NULL),(390,1,32,'2025-12-17 02:45:56',NULL),(391,1,33,'2025-12-17 02:45:56',NULL),(392,1,34,'2025-12-17 02:45:56',NULL),(408,2,11,'2025-12-17 03:19:39',NULL),(409,2,12,'2025-12-17 03:19:39',NULL),(410,2,13,'2025-12-17 03:19:39',NULL),(411,2,14,'2025-12-17 03:19:39',NULL),(412,2,15,'2025-12-17 03:19:39',NULL),(413,2,16,'2025-12-17 03:19:39',NULL),(414,2,17,'2025-12-17 03:19:39',NULL),(415,2,18,'2025-12-17 03:19:39',NULL),(416,2,19,'2025-12-17 03:19:39',NULL),(417,2,20,'2025-12-17 03:19:39',NULL),(418,2,21,'2025-12-17 03:19:39',NULL),(419,2,22,'2025-12-17 03:19:39',NULL),(420,2,23,'2025-12-17 03:19:39',NULL),(421,2,24,'2025-12-17 03:19:39',NULL),(422,2,25,'2025-12-17 03:19:39',NULL),(423,2,27,'2025-12-17 03:19:39',NULL),(424,2,28,'2025-12-17 03:19:39',NULL),(425,2,29,'2025-12-17 03:19:39',NULL),(426,2,30,'2025-12-17 03:19:39',NULL),(427,2,31,'2025-12-17 03:19:39',NULL),(428,2,32,'2025-12-17 03:19:39',NULL),(429,2,33,'2025-12-17 03:19:39',NULL),(430,2,34,'2025-12-17 03:19:39',NULL),(431,2,36,'2025-12-17 03:19:39',NULL),(432,3,11,'2025-12-17 03:19:39',NULL),(433,3,12,'2025-12-17 03:19:39',NULL),(434,3,13,'2025-12-17 03:19:39',NULL),(435,3,14,'2025-12-17 03:19:39',NULL),(436,3,15,'2025-12-17 03:19:39',NULL),(437,3,16,'2025-12-17 03:19:39',NULL),(438,3,17,'2025-12-17 03:19:39',NULL),(439,3,20,'2025-12-17 03:19:39',NULL),(440,3,22,'2025-12-17 03:19:39',NULL),(441,3,23,'2025-12-17 03:19:39',NULL),(442,3,24,'2025-12-17 03:19:39',NULL),(443,3,25,'2025-12-17 03:19:39',NULL),(444,3,27,'2025-12-17 03:19:39',NULL),(445,3,28,'2025-12-17 03:19:39',NULL),(446,3,30,'2025-12-17 03:19:39',NULL),(447,3,31,'2025-12-17 03:19:39',NULL),(448,3,35,'2025-12-17 03:19:39',NULL),(449,3,36,'2025-12-17 03:19:39',NULL),(450,3,37,'2025-12-17 03:19:39',NULL),(451,3,38,'2025-12-17 03:19:39',NULL),(452,3,39,'2025-12-17 09:58:52',NULL),(453,3,40,'2025-12-17 09:58:52',NULL),(454,1,41,'2025-12-18 03:02:56',NULL),(455,2,41,'2025-12-18 03:02:56',NULL),(456,3,41,'2025-12-18 03:02:56',NULL);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'e.g., Administrator, Warehouse Keeper, Sale',
  `role_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`),
  KEY `idx_role_name` (`role_name`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator','System administrator with full access to all modules','active','2025-12-03 12:19:13','2025-12-08 14:12:33'),(2,'Warehouse Keeper','Manages warehouse operations, imports, exports, and inventory','active','2025-12-03 12:19:13','2025-12-08 03:26:40'),(3,'Sale','Handles sales orders and customer management','active','2025-12-03 12:19:13','2025-12-08 03:06:27'),(5,'Shipper','shipping','active','2025-12-09 03:28:48','2025-12-09 03:28:48'),(6,'Cleaner','Cleaning','active','2025-12-09 04:25:45','2025-12-10 02:53:23'),(7,'admin','','active','2025-12-10 05:00:18','2025-12-10 05:00:18');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Dell Global Technology VN','sale@dellglobal.vn','0912345678','active'),(2,'Apple Authorized Distributor','apple@distributor.com','0289876543','active'),(3,'Lenovo VietNam','support@lenovo.vn','0909999888','active'),(4,'ASUS Vietnam','contact@asus.com.vn','0912345678','active'),(5,'Acer Vietnam','support@acer.com.vn','0398765432','active'),(6,'MSI Gaming VN','sales@msi.com.vn','0905558888','active'),(7,'HP Vietnam','sales@hp.com.vn','0382223333','active');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `updated_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_trans_order` (`order_id`),
  KEY `fk_trans_user` (`updated_by`),
  CONSTRAINT `fk_trans_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_trans_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,'approved','Import order approved .',2,'2025-12-12 01:02:07'),(2,1,'stock_added','30 units added to inventory locations.',2,'2025-12-12 01:02:07'),(3,1,'completed','Import order finished.',2,'2025-12-12 01:02:07'),(4,2,'created','Export order created by Sales Staff.',2,'2025-12-12 01:02:07'),(5,2,'pending_approval','Awaiting warehouse keeper approval.',2,'2025-12-12 01:02:07');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Hashed password',
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('Male','Female','Other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `password_changed_at` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL COMMENT 'User who created this account',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_username` (`username`),
  KEY `idx_email` (`email`),
  KEY `idx_status` (`status`),
  KEY `idx_role` (`role_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE RESTRICT,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','123','System Administrator','admin@laptopwms.com','0985290363','Male',1,'active','2025-12-18 04:03:50','2025-12-03 12:19:13','2025-12-18 04:03:50',NULL,NULL),(2,'keeper1','123','Nguyen Van A','aaa1@gmail.com','0123231233','Male',2,'active','2025-12-18 04:05:48','2025-12-07 14:12:07','2025-12-18 04:05:48',NULL,NULL),(3,'sale1','123456','Nguyễn Thị B','b@gmail.com','0214563841','Female',3,'active','2025-12-18 04:06:42','2025-12-15 11:27:22','2025-12-18 04:06:42',NULL,1),(4,'mystery_sale','123456','Mystery Sales Staff','mysteryme2312@gmail.com','0909000111','Male',3,'active',NULL,'2025-12-17 15:48:39','2025-12-17 15:48:39',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laptop_wms'
--

--
-- Dumping routines for database 'laptop_wms'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-18 11:25:39
