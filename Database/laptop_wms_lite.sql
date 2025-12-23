CREATE DATABASE  IF NOT EXISTS `laptop_wms_lite` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptop_wms_lite`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: laptop_wms_lite
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`announcement_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (1,2,'System Update: Please finalize all Export tickets by 5 PM.','2025-12-20 18:18:50'),(2,3,'Testing Team Board','2025-12-20 18:29:06'),(4,2,'aaabbbbbbbbbbb','2025-12-20 18:54:08'),(6,3,'u sure bout dis','2025-12-20 19:04:21');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,3,'New Assignment','You have been assigned to Ticket #IMP-NOV-001',NULL,1,'2025-12-19 10:06:57'),(2,3,'New Ticket Assignment','You have been assigned to a new IMPORT ticket.\n\nTicket Details:\n- Title: Start Import\n- Type: IMPORT\n- Created by: Sarah Sales\n\nPlease review and process this ticket.','/ticket-detail?id=1',1,'2025-12-20 10:24:51'),(3,4,'New Ticket Assignment','You have been assigned to a new EXPORT ticket.\n\nTicket Details:\n- Title: Test Export\n- Type: EXPORT\n- Created by: Sarah Sales\n\nPlease review and process this ticket.','/ticket-detail?id=2',1,'2025-12-20 10:31:07'),(4,2,'Ticket Status Updated','Your ticket has been updated to APPROVED.\n\nTicket Details:\n- Title: Start Import\n- Type: IMPORT\n- Status: APPROVED\n- Processed by: Kevin Keeper\n','/ticket-detail?id=1',1,'2025-12-20 10:31:52'),(5,2,'Ticket Status Updated','Your ticket has been updated to APPROVED.\n\nTicket Details:\n- Title: Test Export\n- Type: EXPORT\n- Status: APPROVED\n- Processed by: LamNguyen\n','/ticket-detail?id=2',1,'2025-12-20 10:32:18'),(6,3,'New Ticket Assignment','You have been assigned to a new IMPORT ticket.\n\nTicket Details:\n- Title: New import\n- Type: IMPORT\n- Created by: Sarah Sales\n\nPlease review and process this ticket.','/ticket-detail?id=3',1,'2025-12-20 10:50:10'),(7,2,'Ticket Status Updated','Your ticket has been updated to APPROVED.\n\nTicket Details:\n- Title: New import\n- Type: IMPORT\n- Status: APPROVED\n- Processed by: Kevin Keeper\n','/ticket-detail?id=3',1,'2025-12-20 10:50:51'),(8,3,'New Ticket Assignment','You have been assigned to a new IMPORT ticket.\n\nTicket Details:\n- Title: h\n- Type: IMPORT\n- Created by: Sarah Sales\n\nPlease review and process this ticket.','/ticket-detail?id=55',0,'2025-12-21 06:10:17'),(9,2,'Ticket Status Updated','Your ticket has been updated to REJECTED.\n\nTicket Details:\n- Title: ha\n- Type: IMPORT\n- Status: REJECTED\n- Processed by: System Admin\n','/ticket-detail?id=55',0,'2025-12-21 06:41:55'),(10,3,'New Ticket Assignment','You have been assigned to a new EXPORT ticket.\n\nTicket Details:\n- Title: h\n- Type: EXPORT\n- Created by: Sarah Sales\n\nPlease review and process this ticket.','/ticket-detail?id=56',1,'2025-12-21 06:45:49'),(11,2,'Ticket Approved ✓','Your ticket has been approved and completed.\n\nTicket Details:\n- Title: h\n- Type: EXPORT\n- Status: COMPLETED\n- Processed by: Kevin Keeper\n\nKeeper\'s Note:\nhaha','/ticket-detail?id=56',1,'2025-12-21 06:46:06');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partners` (
  `partner_id` int NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL COMMENT '1=Supplier, 2=Customer',
  `partner_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `partner_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `partner_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  PRIMARY KEY (`partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
INSERT INTO `partners` VALUES (8,1,'Nhà phân phối A','supplier@dell.com','0123456789','active'),(9,1,'Nhà phân phối B','supplier@apple.com','0987654321','active'),(10,2,'TechStore Customer','order@techstore.vn','0111222333','active'),(11,2,'Laptop Retail','buy@laptopretail.vn','0444555666','active'),(12,1,'HP Quảng Ninh','hpquangninh@gmail.com','02154812116','active');
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permission_url` (`permission_url`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'/dashboard','View Dashboard'),(2,'/ticket-list','View Tickets'),(3,'/create-ticket','Create New Ticket'),(4,'/approve-ticket','Approve/Reject Tickets'),(5,'/report-inventory','View Balance Report'),(6,'/user-list','View User List'),(7,'/user-detail','View/Edit User Details'),(8,'/admin-reset-password','Admin Reset User Password'),(9,'/product-list','View Product List'),(10,'/add-product','Add New Product'),(11,'/edit-product','Edit Product'),(12,'/toggleProduct','Toggle Product Status'),(13,'/add-product-detail','Add Product Configuration'),(14,'/edit-product-detail','Edit Product Configuration'),(15,'/role','View Roles'),(16,'/role-list','View Role List'),(17,'/add-role','Add New Role'),(18,'/edit-role','Edit Role'),(19,'/role-permission','Manage Role Permissions'),(20,'/ticket-detail','View Ticket Details'),(21,'/process-ticket','Process/Approve Tickets'),(22,'/profile','View/Edit Own Profile'),(23,'/change-password','Change Own Password'),(24,'/notifications','View Notifications'),(25,'/add-announcement','Post Team Announcements'),(26,'/team-board','View Team Board'),(27,'/manage-announcement','Edit/Delete Announcements'),(28,'/report-import','View Import Reports'),(29,'/report-export','View Export Reports'),(30,'/customer-list','View Customer List'),(31,'/add-customer','Add New Customer'),(32,'/customer-detail','View Customer Details'),(33,'/customer-status','Block/Unblock Customer'),(34,'/supplier-list','View Supplier List'),(35,'/supplier-detail','View Supplier Details'),(36,'/add-supplier','Add New Supplier'),(37,'/supplier-status','Toggle Supplier Status'),(42,'/edit-supplier','Edit Supplier Details'),(43,'/edit-ticket','Edit Ticket Details'),(46,'/change-status','Change Customer Status');
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
  `cpu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ram` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `storage` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gpu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'piece',
  `quantity` int DEFAULT '0',
  PRIMARY KEY (`product_detail_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_details_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES (1,1,'Core i7','16GB','512GB',NULL,'piece',100),(2,2,'M3 Pro','16GB','512GB','NVIDIA RTX 2050 4GB ','piece',20),(3,1,'AMD Ryzen 5 5600','16GB','1TB','NVIDIA RTX 3050 4GB','piece',15),(50,50,'Ryzen 9 6900HS','32GB','1TB SSD','RTX 3080','piece',4),(51,51,'Core i7-1260P','24GB','512GB SSD','Intel Iris Xe','piece',9);
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Laptop',
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Dell XPS 13','Dell','Office',1),(2,'MacBook Pro 16','Apple','Office',1),(3,'aaaaaaaa','Dell','Gaming',1),(50,'ASUS ROG Zephyrus','ASUS','Gaming',1),(51,'Lenovo ThinkPad X1','Lenovo','Workstation',1);
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
  PRIMARY KEY (`role_permission_id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (1,1,4),(2,1,3),(3,1,1),(4,1,5),(5,1,2),(8,2,1),(9,2,2),(10,2,3),(11,3,1),(12,3,2),(13,3,4),(14,1,6),(15,1,7),(16,1,8),(17,1,9),(18,1,10),(19,1,11),(20,1,12),(21,1,13),(22,1,14),(23,1,15),(24,1,16),(25,1,17),(26,1,18),(27,1,19),(28,1,20),(29,1,21),(30,1,22),(31,1,23),(32,1,24),(33,2,9),(34,2,10),(35,2,11),(36,2,13),(37,2,14),(38,2,20),(39,2,22),(40,2,23),(41,2,24),(42,3,9),(43,3,20),(44,3,21),(45,3,22),(46,3,23),(47,3,24),(48,1,5),(49,2,5),(50,3,5),(51,1,14),(52,3,14),(53,1,25),(54,2,25),(55,3,25),(56,1,26),(57,1,27),(58,2,26),(59,2,27),(60,3,26),(61,3,27),(63,1,30),(64,1,29),(65,1,28),(66,2,30),(67,2,29),(68,2,28),(69,1,31),(70,1,32),(71,1,33),(72,2,31),(73,2,32),(74,2,33),(75,1,36),(76,1,35),(77,1,34),(78,1,37),(82,2,36),(83,2,35),(84,2,34),(85,2,37),(89,1,42),(90,2,42),(91,1,43),(92,2,43),(93,1,12),(94,2,12),(95,1,46),(96,2,46);
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
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','Full Access'),(2,'Sale','Creates Tickets'),(3,'Keeper','Approves Tickets');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_ledger`
--

DROP TABLE IF EXISTS `stock_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_ledger` (
  `ledger_id` int NOT NULL AUTO_INCREMENT,
  `product_detail_id` int NOT NULL,
  `ticket_id` int NOT NULL,
  `quantity_change` int NOT NULL,
  `balance_after` int NOT NULL,
  `type` enum('IMPORT','EXPORT') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ledger_id`),
  KEY `product_detail_id` (`product_detail_id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `stock_ledger_ibfk_1` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`product_detail_id`),
  CONSTRAINT `stock_ledger_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_ledger`
--

LOCK TABLES `stock_ledger` WRITE;
/*!40000 ALTER TABLE `stock_ledger` DISABLE KEYS */;
INSERT INTO `stock_ledger` VALUES (1,1,1,50,50,'IMPORT','2025-11-01 03:00:00'),(2,1,1,20,70,'IMPORT','2025-12-20 10:31:52'),(3,1,1,50,120,'IMPORT','2025-12-20 10:31:52'),(4,2,1,20,20,'IMPORT','2025-12-20 10:31:52'),(5,1,2,10,110,'EXPORT','2025-12-20 10:32:18'),(6,3,3,10,15,'IMPORT','2025-12-20 10:50:51'),(7,50,50,100,100,'IMPORT','2025-12-15 18:00:19'),(8,50,51,96,4,'EXPORT','2025-12-17 18:00:19'),(9,51,52,20,20,'IMPORT','2025-12-18 18:00:19'),(10,51,53,11,9,'EXPORT','2025-12-19 18:00:19'),(11,1,56,10,100,'EXPORT','2025-12-21 06:46:06');
/*!40000 ALTER TABLE `stock_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_items`
--

DROP TABLE IF EXISTS `ticket_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_items` (
  `ticket_item_id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  `product_detail_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`ticket_item_id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `product_detail_id` (`product_detail_id`),
  CONSTRAINT `ticket_items_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_items_ibfk_2` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`product_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_items`
--

LOCK TABLES `ticket_items` WRITE;
/*!40000 ALTER TABLE `ticket_items` DISABLE KEYS */;
INSERT INTO `ticket_items` VALUES (1,1,1,50),(2,1,1,20),(3,1,2,20),(4,2,1,10),(5,3,3,10),(6,50,50,100),(7,51,50,96),(8,52,51,20),(9,53,51,11),(10,54,50,50),(15,55,1,10),(16,56,1,10);
/*!40000 ALTER TABLE `ticket_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `ticket_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` enum('IMPORT','EXPORT') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `status` enum('PENDING','COMPLETED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'PENDING',
  `created_by` int NOT NULL,
  `assigned_keeper` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `processed_at` timestamp NULL DEFAULT NULL,
  `keeper_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `partner_id` int DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  UNIQUE KEY `ticket_code` (`ticket_code`),
  KEY `created_by` (`created_by`),
  KEY `assigned_keeper` (`assigned_keeper`),
  KEY `fk_tickets_partners` (`partner_id`),
  CONSTRAINT `fk_tickets_partners` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`partner_id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`assigned_keeper`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'IMP-DEC-001','IMPORT','Start Import','aaaa','COMPLETED',2,3,'2025-12-20 10:24:51','2025-12-20 10:31:52','',8),(2,'EXP-DEC-001','EXPORT','Test Export','','COMPLETED',2,4,'2025-12-20 10:31:07','2025-12-20 10:32:18','',10),(3,'IMP-DEC-002','IMPORT','New import','','COMPLETED',2,3,'2025-12-20 10:50:10','2025-12-20 10:50:51','',9),(50,'IMP-HIST-001','IMPORT','Bulk Import ASUS',NULL,'COMPLETED',2,3,'2025-12-15 18:00:19','2025-12-15 18:00:19',NULL,8),(51,'EXP-HIST-001','EXPORT','Wholesale ASUS Order',NULL,'COMPLETED',2,3,'2025-12-17 18:00:19','2025-12-17 18:00:19',NULL,11),(52,'IMP-HIST-002','IMPORT','Restock Lenovo',NULL,'COMPLETED',2,3,'2025-12-18 18:00:19','2025-12-18 18:00:19',NULL,8),(53,'EXP-HIST-002','EXPORT','Retail Lenovo Sales',NULL,'COMPLETED',2,3,'2025-12-19 18:00:19','2025-12-19 18:00:19',NULL,10),(54,'IMP-NEW-001','IMPORT','Urgent Restock Request',NULL,'PENDING',2,3,'2025-12-20 18:00:19',NULL,NULL,9),(55,'IMP-DEC-006','IMPORT','ha','haha','REJECTED',2,3,'2025-12-21 06:10:17','2025-12-21 06:41:55','',9),(56,'EXP-DEC-004','EXPORT','h','test','COMPLETED',2,3,'2025-12-21 06:45:49','2025-12-21 06:46:06','haha',11);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role_id` int NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'active',
  `password_changed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$11$cWSC8DYY71srI2t0e.rG/Oaaer7.X/FqHU.kACyGJUKrZi8iQ88eu','Pham Quang','admin@wms.com',1,'active','2025-12-20 09:27:53'),(2,'sale1','$2a$11$cWSC8DYY71srI2t0e.rG/Oaaer7.X/FqHU.kACyGJUKrZi8iQ88eu','Duong Hieu','sale1@wms.com',2,'active','2025-12-23 16:00:53'),(3,'keeper1','$2a$11$cWSC8DYY71srI2t0e.rG/Oaaer7.X/FqHU.kACyGJUKrZi8iQ88eu','Pham Minh','keeper1@wms.com',3,'active','2025-12-20 09:27:53'),(4,'keeper2','$2a$11$rscPq5OLOQi7izSoX.3zyuQbGCqmPuKtdl4aGYdXVd3q/LXUoIT6m','Nguyen Lam','keeper2@wms.com',3,'active','2025-12-23 16:31:01'),(5,'MysteryMe','$2a$11$GC7rKoO3pMD86RPgYVSenuW8BIAGwXHkq4C6Gjwap2T/1eioeI9bO','Phuc Lam','mysteryme2312@gmail.com',2,'active','2025-12-23 16:16:02'),(6,'sale3','$2a$11$tV3f55J0UIzcB9YalNV7QOChubKOT50HYm7KYvsikX5JB/4Ya/PGK','Tran Mai','sale3@wms.com',2,'active','2025-12-23 16:27:43'),(7,'keeper3','$2a$11$tV3f55J0UIzcB9YalNV7QOChubKOT50HYm7KYvsikX5JB/4Ya/PGK','Le Tuan','keeper3@wms.com',3,'active','2025-12-23 16:27:43'),(8,'keeper4','$2a$11$tV3f55J0UIzcB9YalNV7QOChubKOT50HYm7KYvsikX5JB/4Ya/PGK','Hoang Lan','keeper4@wms.com',3,'inactive','2025-12-23 16:27:43');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laptop_wms_lite'
--

--
-- Dumping routines for database 'laptop_wms_lite'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-23 23:37:33
