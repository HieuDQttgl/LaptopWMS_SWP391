-- Migration: Create notifications table
-- Run this script to add notification functionality

USE `laptop_wms`;

-- Create notifications table
CREATE TABLE IF NOT EXISTS `notifications` (
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
  CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notification_related_user` FOREIGN KEY (`related_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
