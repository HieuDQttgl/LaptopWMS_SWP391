-- Migration: Add password_changed_at column to users table
-- This column is used to invalidate sessions when password is changed

ALTER TABLE `users` ADD COLUMN `password_changed_at` TIMESTAMP NULL DEFAULT NULL AFTER `status`;

-- Optional: Set initial value for existing users
UPDATE `users` SET `password_changed_at` = CURRENT_TIMESTAMP WHERE `password_changed_at` IS NULL;
