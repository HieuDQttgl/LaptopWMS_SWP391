-- Migration 002: Add missing URL path permissions
-- Run this after 001_add_password_changed_at.sql
-- This adds all servlet URL paths not yet in the permissions table
-- and links them to appropriate roles

USE laptop_wms_lite;

-- =====================================================
-- STEP 1: Add missing permissions (URL paths)
-- =====================================================

-- User Management (Admin only)
INSERT IGNORE INTO permissions (permission_url, permission_description) VALUES
('/user-list', 'View User List'),
('/user-detail', 'View/Edit User Details'),
('/admin-reset-password', 'Admin Reset User Password');

-- Product Management (Admin and Sale)
INSERT IGNORE INTO permissions (permission_url, permission_description) VALUES
('/product-list', 'View Product List'),
('/add-product', 'Add New Product'),
('/edit-product', 'Edit Product'),
('/toggleProduct', 'Toggle Product Status'),
('/add-product-detail', 'Add Product Configuration'),
('/edit-product-detail', 'Edit Product Configuration');

-- Role Management (Admin only)
INSERT IGNORE INTO permissions (permission_url, permission_description) VALUES
('/role', 'View Roles'),
('/role-list', 'View Role List'),
('/add-role', 'Add New Role'),
('/edit-role', 'Edit Role'),
('/role-permission', 'Manage Role Permissions');

-- Ticket Management (extends existing)
INSERT IGNORE INTO permissions (permission_url, permission_description) VALUES
('/ticket-detail', 'View Ticket Details'),
('/process-ticket', 'Process/Approve Tickets');

-- Common pages (all authenticated users)
INSERT IGNORE INTO permissions (permission_url, permission_description) VALUES
('/profile', 'View/Edit Own Profile'),
('/change-password', 'Change Own Password'),
('/notifications', 'View Notifications');

-- =====================================================
-- STEP 2: Link permissions to roles
-- =====================================================

-- Get permission IDs for the newly added permissions
SET @perm_user_list = (SELECT permission_id FROM permissions WHERE permission_url = '/user-list');
SET @perm_user_detail = (SELECT permission_id FROM permissions WHERE permission_url = '/user-detail');
SET @perm_admin_reset = (SELECT permission_id FROM permissions WHERE permission_url = '/admin-reset-password');

SET @perm_product_list = (SELECT permission_id FROM permissions WHERE permission_url = '/product-list');
SET @perm_add_product = (SELECT permission_id FROM permissions WHERE permission_url = '/add-product');
SET @perm_edit_product = (SELECT permission_id FROM permissions WHERE permission_url = '/edit-product');
SET @perm_toggle_product = (SELECT permission_id FROM permissions WHERE permission_url = '/toggleProduct');
SET @perm_add_detail = (SELECT permission_id FROM permissions WHERE permission_url = '/add-product-detail');
SET @perm_edit_detail = (SELECT permission_id FROM permissions WHERE permission_url = '/edit-product-detail');

SET @perm_role = (SELECT permission_id FROM permissions WHERE permission_url = '/role');
SET @perm_role_list = (SELECT permission_id FROM permissions WHERE permission_url = '/role-list');
SET @perm_add_role = (SELECT permission_id FROM permissions WHERE permission_url = '/add-role');
SET @perm_edit_role = (SELECT permission_id FROM permissions WHERE permission_url = '/edit-role');
SET @perm_role_perm = (SELECT permission_id FROM permissions WHERE permission_url = '/role-permission');

SET @perm_ticket_detail = (SELECT permission_id FROM permissions WHERE permission_url = '/ticket-detail');
SET @perm_process_ticket = (SELECT permission_id FROM permissions WHERE permission_url = '/process-ticket');

SET @perm_profile = (SELECT permission_id FROM permissions WHERE permission_url = '/profile');
SET @perm_change_pwd = (SELECT permission_id FROM permissions WHERE permission_url = '/change-password');
SET @perm_notifications = (SELECT permission_id FROM permissions WHERE permission_url = '/notifications');

-- Role IDs:
-- 1 = Admin (Full Access)
-- 2 = Sale (Creates Tickets)
-- 3 = Keeper (Approves Tickets)

-- =====================================================
-- Admin (role_id = 1) - Gets ALL permissions
-- =====================================================
INSERT IGNORE INTO role_permissions (role_id, permission_id) VALUES
(1, @perm_user_list),
(1, @perm_user_detail),
(1, @perm_admin_reset),
(1, @perm_product_list),
(1, @perm_add_product),
(1, @perm_edit_product),
(1, @perm_toggle_product),
(1, @perm_add_detail),
(1, @perm_edit_detail),
(1, @perm_role),
(1, @perm_role_list),
(1, @perm_add_role),
(1, @perm_edit_role),
(1, @perm_role_perm),
(1, @perm_ticket_detail),
(1, @perm_process_ticket),
(1, @perm_profile),
(1, @perm_change_pwd),
(1, @perm_notifications);

-- =====================================================
-- Sale (role_id = 2) - Product view, Ticket creation
-- =====================================================
INSERT IGNORE INTO role_permissions (role_id, permission_id) VALUES
(2, @perm_product_list),
(2, @perm_add_product),
(2, @perm_edit_product),
(2, @perm_add_detail),
(2, @perm_edit_detail),
(2, @perm_ticket_detail),
(2, @perm_profile),
(2, @perm_change_pwd),
(2, @perm_notifications);

-- =====================================================
-- Keeper (role_id = 3) - Ticket approval, inventory
-- =====================================================
INSERT IGNORE INTO role_permissions (role_id, permission_id) VALUES
(3, @perm_product_list),
(3, @perm_ticket_detail),
(3, @perm_process_ticket),
(3, @perm_profile),
(3, @perm_change_pwd),
(3, @perm_notifications);

-- =====================================================
-- Verify: Show all permissions and their role assignments
-- =====================================================
SELECT 
    p.permission_id,
    p.permission_url,
    p.permission_description,
    GROUP_CONCAT(r.role_name ORDER BY r.role_id SEPARATOR ', ') AS assigned_roles
FROM permissions p
LEFT JOIN role_permissions rp ON p.permission_id = rp.permission_id
LEFT JOIN roles r ON rp.role_id = r.role_id
GROUP BY p.permission_id, p.permission_url, p.permission_description
ORDER BY p.permission_id;
