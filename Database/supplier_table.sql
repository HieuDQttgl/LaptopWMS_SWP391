-- ========================================
-- Supplier Table for Laptop WMS
-- Run this script after laptop_wms.sql
-- ========================================

-- Create suppliers table
CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) DEFAULT NULL COMMENT 'User who created this supplier',
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `supplier_name` (`supplier_name`),
  KEY `idx_supplier_status` (`status`),
  KEY `idx_supplier_name` (`supplier_name`),
  CONSTRAINT `fk_suppliers_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- Add supplier permissions
-- ========================================
INSERT INTO `permissions` (`permission_name`, `permission_description`, `module`, `created_at`, `updated_at`) VALUES
('supplier.view', 'View supplier list and details', 'supplier', NOW(), NOW()),
('supplier.create', 'Create new suppliers', 'supplier', NOW(), NOW()),
('supplier.edit', 'Edit supplier information', 'supplier', NOW(), NOW()),
('supplier.delete', 'Delete/deactivate suppliers', 'supplier', NOW(), NOW());

-- ========================================
-- Grant supplier permissions to Administrator role (role_id = 1)
-- ========================================
INSERT INTO `role_permissions` (`role_id`, `permission_id`, `granted_at`)
SELECT 1, permission_id, NOW() FROM permissions WHERE module = 'supplier';

-- Grant supplier.view permission to Warehouse Keeper role (role_id = 2)
INSERT INTO `role_permissions` (`role_id`, `permission_id`, `granted_at`)
SELECT 2, permission_id, NOW() FROM permissions WHERE permission_name = 'supplier.view';

-- ========================================
-- Sample supplier data
-- ========================================
INSERT INTO `suppliers` (`supplier_name`, `contact_person`, `email`, `phone_number`, `address`, `status`, `created_by`) VALUES
('Dell Vietnam', 'Nguyen Van A', 'contact@dell.vn', '0901234567', '123 Nguyen Hue, District 1, Ho Chi Minh City', 'active', 1),
('HP Vietnam', 'Tran Thi B', 'sales@hp.vn', '0912345678', '456 Le Loi, District 1, Ho Chi Minh City', 'active', 1),
('Lenovo Vietnam', 'Le Van C', 'info@lenovo.vn', '0923456789', '789 Dong Khoi, District 1, Ho Chi Minh City', 'active', 1),
('ASUS Vietnam', 'Pham Thi D', 'support@asus.vn', '0934567890', '321 Hai Ba Trung, District 3, Ho Chi Minh City', 'active', 1),
('Acer Vietnam', 'Hoang Van E', 'sales@acer.vn', '0945678901', '654 Cach Mang Thang 8, District 10, Ho Chi Minh City', 'inactive', 1);

COMMIT;
