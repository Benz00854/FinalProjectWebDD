-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2026 at 07:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `repair_helpdesk`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'คอมพิวเตอร์และ PC', 'ปัญหาเกี่ยวกับคอมพิวเตอร์ตั้งโต๊ะ, Laptop, All-in-one'),
(2, 'Printer & Scanner', 'เครื่องพิมพ์, เครื่องสแกน, Ink/Toner'),
(3, 'Network & Internet', 'ปัญหาเน็ตเวิร์ค, Wifi, Switch, VPN, Firewall'),
(4, 'Software & OS', 'ปัญหาซอฟต์แวร์, Windows, macOS, Microsoft Office, Antivirus'),
(5, 'อุปกรณ์ต่อพ่วง', 'Mouse, Keyboard, Monitor, USB Hub, Webcam'),
(6, 'อื่นๆ', 'ปัญหาอื่นๆ ที่ไม่อยู่ในหมวดหมู่ข้างต้น');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `body` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL COMMENT 'relative path to storage/uploads/',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `ticket_id`, `user_id`, `body`, `image_path`, `created_at`) VALUES
(1, 2, 2, 'ตรวจสอบ Event Viewer พบ Intel Wireless Adapter หลุดซ้ำๆ', NULL, '2026-10-01 11:54:53'),
(2, 2, 2, 'อัปเดต Driver เป็น Version 22.230.0 แล้ว กำลังสังเกตอาการต่อ', NULL, '2026-10-01 11:54:53'),
(3, 3, 3, 'ปิด Windows Update แล้วรัน offline installer ผ่านแล้ว', NULL, '2026-10-01 11:54:53'),
(4, 4, 2, 'ลบ Printer port เก่าออก ติดตั้งใหม่ เลือก TCP/IP port ตรงแทน USB', NULL, '2026-10-01 11:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `score` tinyint(4) NOT NULL COMMENT '1-5 ดาว',
  `feedback` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `ticket_id`, `score`, `feedback`, `created_at`) VALUES
(1, 4, 5, 'ช่างมาเร็ว แก้ไขได้ภายใน 30 นาที ประทับใจมาก', '2026-10-01 11:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `status_logs`
--

CREATE TABLE `status_logs` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `changed_by` int(11) NOT NULL COMMENT 'user.id ที่เปลี่ยนสถานะ',
  `from_status` varchar(50) DEFAULT NULL COMMENT 'NULL = สร้างใหม่',
  `to_status` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status_logs`
--

INSERT INTO `status_logs` (`id`, `ticket_id`, `changed_by`, `from_status`, `to_status`, `note`, `created_at`) VALUES
(1, 1, 4, NULL, 'Open', 'สร้างรายการแจ้งซ่อมใหม่', '2026-10-01 11:54:53'),
(2, 2, 4, NULL, 'Open', 'สร้างรายการแจ้งซ่อมใหม่', '2026-10-01 11:54:53'),
(3, 2, 1, 'Open', 'Assigned', 'มอบหมายให้ช่างสมชาย', '2026-10-01 11:54:53'),
(4, 2, 2, 'Assigned', 'InProgress', 'รับงานแล้ว กำลังตรวจสอบ Driver และ Firmware', '2026-10-01 11:54:53'),
(5, 3, 5, NULL, 'Open', 'สร้างรายการแจ้งซ่อมใหม่', '2026-10-01 11:54:53'),
(6, 3, 1, 'Open', 'Assigned', 'มอบหมายให้ช่างสมหญิง', '2026-10-01 11:54:53'),
(7, 3, 3, 'Assigned', 'InProgress', 'กำลังดำเนินการ', '2026-10-01 11:54:53'),
(8, 3, 3, 'InProgress', 'Resolved', 'แก้ไขโดยเปิด Windows Update Feature แล้วติดตั้งใหม่', '2026-10-01 11:54:53'),
(9, 4, 4, NULL, 'Open', 'สร้างรายการแจ้งซ่อมใหม่', '2026-10-01 11:54:53'),
(10, 4, 1, 'Open', 'Assigned', 'มอบหมายให้ช่างสมชาย', '2026-10-01 11:54:53'),
(11, 4, 2, 'Assigned', 'InProgress', 'รับงานแล้ว', '2026-10-01 11:54:53'),
(12, 4, 2, 'InProgress', 'Resolved', 'ลบและติดตั้ง Driver Printer ใหม่ ใช้งานได้ปกติ', '2026-10-01 11:54:53'),
(13, 4, 4, 'Resolved', 'Closed', 'ผู้แจ้งยืนยันผลงาน ให้คะแนน 5 ดาว', '2026-10-01 11:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'ผู้แจ้งซ่อม',
  `category_id` int(11) NOT NULL,
  `technician_id` int(11) DEFAULT NULL COMMENT 'ช่างที่ได้รับมอบหมาย',
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `status` enum('Open','Assigned','InProgress','Resolved','Closed') NOT NULL DEFAULT 'Open',
  `priority` enum('Low','Medium','High','Urgent') NOT NULL DEFAULT 'Medium',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resolved_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `user_id`, `category_id`, `technician_id`, `title`, `description`, `status`, `priority`, `created_at`, `updated_at`, `resolved_at`, `closed_at`) VALUES
(1, 4, 1, NULL, 'คอมพิวเตอร์ไม่สามารถเปิดได้ หน้าจอดำ', 'เปิดเครื่องแล้วหน้าจอดำสนิท ไม่มีเสียง POST ไฟ Power LED ติด\nอาการเกิดขึ้นหลังจากไฟดับกะทันหันเมื่อวานนี้\nเครื่อง: Dell OptiPlex 7090', 'Open', 'High', '2026-10-01 11:54:53', '2026-10-01 11:54:53', NULL, NULL),
(2, 4, 3, 2, 'Wifi หลุดบ่อย ต้องรีสตาร์ท Adapter ทุกชั่วโมง', 'Wifi disconnect ทุก 1 ชั่วโมง ต้อง disable/enable NIC ถึงจะกลับมาใช้งานได้\nระบบ: Windows 11, อแดปเตอร์ Intel AX201\nIP: 192.168.1.105', 'InProgress', 'Medium', '2026-10-01 11:54:53', '2026-10-01 11:54:53', NULL, NULL),
(3, 5, 4, 3, 'ติดตั้ง Microsoft Office 365 ไม่ได้ ขึ้น Error 0x800F0954', 'ติดตั้ง Office 365 แล้วขึ้น error \"Something went wrong 0x800F0954\"\nOS: Windows 11 Home, RAM: 8GB', 'Resolved', 'Medium', '2026-10-01 11:54:53', '2026-10-01 11:54:53', '2026-10-01 10:54:53', NULL),
(4, 4, 2, 2, 'Printer HP LaserJet พิมพ์ไม่ออก ขึ้น Offline', 'Printer ขึ้น Offline ทั้งที่เสียบ USB อยู่\nรุ่น: HP LaserJet Pro M404dn\nOS: Windows 10', 'Closed', 'Low', '2026-10-01 11:54:53', '2026-10-01 11:54:53', '2026-09-29 11:54:53', '2026-09-30 11:54:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','technician','admin') NOT NULL DEFAULT 'user',
  `line_user_id` varchar(100) DEFAULT NULL COMMENT 'LINE Messaging API User ID',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role`, `line_user_id`, `created_at`) VALUES
(1, 'ผู้ดูแลระบบ (Admin)', 'admin@demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', NULL, '2026-10-01 11:54:53'),
(2, 'สมชาย ช่างเทคนิค', 'tech@demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'technician', NULL, '2026-10-01 11:54:53'),
(3, 'สมหญิง วิทยา', 'tech2@demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'technician', NULL, '2026-10-01 11:54:53'),
(4, 'นายทดสอบ ระบบ', 'user@demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', NULL, '2026-10-01 11:54:53'),
(5, 'นางสาวสุนิสา มาก', 'user2@demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user', NULL, '2026-10-01 11:54:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comments_ticket` (`ticket_id`),
  ADD KEY `idx_comments_user` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ratings_ticket_unique` (`ticket_id`);

--
-- Indexes for table `status_logs`
--
ALTER TABLE `status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_statuslog_ticket` (`ticket_id`),
  ADD KEY `idx_statuslog_user` (`changed_by`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tickets_user` (`user_id`),
  ADD KEY `idx_tickets_tech` (`technician_id`),
  ADD KEY `idx_tickets_status` (`status`),
  ADD KEY `idx_tickets_priority` (`priority`),
  ADD KEY `idx_tickets_category` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status_logs`
--
ALTER TABLE `status_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `status_logs`
--
ALTER TABLE `status_logs`
  ADD CONSTRAINT `fk_statuslog_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_statuslog_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_tickets_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_tickets_tech` FOREIGN KEY (`technician_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tickets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
