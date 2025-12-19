-- Migration: Add link column to notifications table
-- This allows notifications to redirect to relevant pages when clicked

ALTER TABLE `notifications` ADD COLUMN `link` VARCHAR(255) NULL AFTER `message`;

-- Example links:
-- Ticket notifications: /ticket-detail?id=123
-- Password reset notifications: /user-detail?id=456
