-- Migration Script: Add capacity and status columns to locations table
-- Date: 2025-12-18
-- Purpose: Support location capacity tracking and status management

USE laptop_wms;

-- Add capacity and status columns
ALTER TABLE locations 
ADD COLUMN capacity INT DEFAULT 100 AFTER bin,
ADD COLUMN status TINYINT(1) DEFAULT 1 AFTER capacity;

-- Update existing locations with sample data
UPDATE locations SET capacity = 50 WHERE location_id = 1;
UPDATE locations SET capacity = 30 WHERE location_id = 2;
UPDATE locations SET capacity = 40 WHERE location_id = 3;

-- Verify columns were added
DESCRIBE locations;

-- Add permission for location-list
INSERT INTO permissions (permission_url, permission_description, module) 
VALUES ('/location-list', 'View location list', 'location');

-- Grant permission to Admin (role_id=1), Warehouse Keeper (role_id=2)
INSERT INTO role_permissions (role_id, permission_id, granted_at)
SELECT 1, permission_id, NOW() FROM permissions WHERE permission_url = '/location-list';

INSERT INTO role_permissions (role_id, permission_id, granted_at)
SELECT 2, permission_id, NOW() FROM permissions WHERE permission_url = '/location-list';

