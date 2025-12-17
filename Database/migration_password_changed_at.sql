-- Migration Script: Add password_changed_at column
-- Date: 2025-12-16
-- Purpose: Track password changes to invalidate old sessions

USE laptop_wms;

-- Add column to users table
ALTER TABLE users 
ADD COLUMN password_changed_at TIMESTAMP NULL DEFAULT NULL 
AFTER updated_at;

-- Verify column was added
DESCRIBE users;
