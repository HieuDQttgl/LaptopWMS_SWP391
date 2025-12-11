-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 11, 2025 lúc 02:22 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `laptop_wms`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int(11) NOT NULL,
  `permission_name` varchar(100) NOT NULL COMMENT 'e.g., user.view, user.create, product.manage',
  `permission_description` text DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL COMMENT 'Module name: user, product, warehouse, order, etc.',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_name`, `permission_description`, `module`, `created_at`, `updated_at`) VALUES
(1, 'user.view', 'View user list and details', 'user', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(2, 'user.create', 'Create new users', 'user', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(3, 'user.edit', 'Edit user information', 'user', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(4, 'user.delete', 'Delete users', 'user', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(5, 'user.manage_roles', 'Manage user roles', 'user', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(6, 'role.view', 'View roles list and details', 'role', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(7, 'role.create', 'Create new roles', 'role', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(8, 'role.edit', 'Edit role information', 'role', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(9, 'role.delete', 'Delete roles', 'role', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(10, 'role.manage_permissions', 'Manage role permissions', 'role', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(11, 'profile.view', 'View own profile', 'profile', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(12, 'profile.edit', 'Edit own profile', 'profile', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(13, 'dashboard.view', 'View dashboard', 'common', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(14, 'login', 'Login to system', 'common', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(15, 'logout', 'Logout from system', 'common', '2025-12-05 06:07:51', '2025-12-05 06:07:51');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL COMMENT 'e.g., Administrator, Warehouse Keeper, Sale',
  `role_description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'System administrator with full access to all modules', 'active', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(2, 'Warehouse Keeper', 'Manages warehouse operations, imports, exports, and inventory', 'active', '2025-12-05 06:07:51', '2025-12-05 06:07:51'),
(3, 'Sale', 'Handles sales orders and customer management', 'active', '2025-12-05 06:07:51', '2025-12-05 06:07:51');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `granted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `granted_by` int(11) DEFAULT NULL COMMENT 'User who granted this permission'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `role_permissions`
--

INSERT INTO `role_permissions` (`role_permission_id`, `role_id`, `permission_id`, `granted_at`, `granted_by`) VALUES
(1, 1, 13, '2025-12-05 06:07:51', NULL),
(2, 1, 14, '2025-12-05 06:07:51', NULL),
(3, 1, 15, '2025-12-05 06:07:51', NULL),
(4, 1, 11, '2025-12-05 06:07:51', NULL),
(5, 1, 12, '2025-12-05 06:07:51', NULL),
(6, 1, 6, '2025-12-05 06:07:51', NULL),
(7, 1, 7, '2025-12-05 06:07:51', NULL),
(8, 1, 8, '2025-12-05 06:07:51', NULL),
(9, 1, 9, '2025-12-05 06:07:51', NULL),
(10, 1, 10, '2025-12-05 06:07:51', NULL),
(11, 1, 1, '2025-12-05 06:07:51', NULL),
(12, 1, 2, '2025-12-05 06:07:51', NULL),
(13, 1, 3, '2025-12-05 06:07:51', NULL),
(14, 1, 4, '2025-12-05 06:07:51', NULL),
(15, 1, 5, '2025-12-05 06:07:51', NULL),
(16, 2, 13, '2025-12-05 06:07:51', NULL),
(17, 2, 14, '2025-12-05 06:07:51', NULL),
(18, 2, 15, '2025-12-05 06:07:51', NULL),
(19, 2, 12, '2025-12-05 06:07:51', NULL),
(20, 2, 11, '2025-12-05 06:07:51', NULL),
(23, 3, 13, '2025-12-05 06:07:51', NULL),
(24, 3, 14, '2025-12-05 06:07:51', NULL),
(25, 3, 15, '2025-12-05 06:07:51', NULL),
(26, 3, 12, '2025-12-05 06:07:51', NULL),
(27, 3, 11, '2025-12-05 06:07:51', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT 'Hashed password',
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) DEFAULT NULL COMMENT 'User who created this account'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `email`, `phone_number`, `gender`, `role_id`, `status`, `last_login_at`, `created_at`, `updated_at`, `created_by`) VALUES
(1, 'admin', '123456', 'System Administrator', 'admin@laptopwms.com', '0302151574', 'Male', 1, 'active', '2025-12-08 10:35:50', '2025-12-05 06:07:51', '2025-12-08 10:36:00', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `permission_name` (`permission_name`),
  ADD KEY `idx_permission_name` (`permission_name`),
  ADD KEY `idx_module` (`module`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`),
  ADD KEY `idx_role_name` (`role_name`),
  ADD KEY `idx_status` (`status`);

--
-- Chỉ mục cho bảng `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_permission_id`),
  ADD UNIQUE KEY `unique_role_permission` (`role_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `fk_role_permissions_granted_by` (`granted_by`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_role` (`role_id`),
  ADD KEY `created_by` (`created_by`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `role_permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_granted_by` FOREIGN KEY (`granted_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
