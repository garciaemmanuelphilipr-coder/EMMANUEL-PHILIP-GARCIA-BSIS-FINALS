-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 14, 2026 at 05:25 PM
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
-- Database: `eventsched`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `slot` enum('am_in','am_out','pm_in','pm_out') NOT NULL DEFAULT 'am_in',
  `scanned_by` int(11) NOT NULL,
  `scanned_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `event_id`, `student_id`, `slot`, `scanned_by`, `scanned_at`) VALUES
(41, 26, 1, 'am_in', 3, '2026-10-14 23:06:59'),
(42, 26, 5, 'am_in', 3, '2026-10-14 23:07:35'),
(43, 26, 5, 'am_out', 1, '2026-10-14 23:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `venue` varchar(150) NOT NULL,
  `category` enum('mandatory','optional') NOT NULL,
  `fine_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sessions` tinyint(4) NOT NULL DEFAULT 4,
  `status` enum('draft','published','closed') NOT NULL DEFAULT 'draft',
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `event_date`, `event_time`, `venue`, `category`, `fine_amount`, `sessions`, `status`, `created_by`) VALUES
(25, 'finals', '2026-10-15', '08:00:00', 'City College', 'mandatory', 100.00, 4, 'closed', 2),
(26, 'Finals2', '2026-10-16', '08:00:00', 'City College', 'mandatory', 50.00, 2, 'closed', 2);

-- --------------------------------------------------------

--
-- Table structure for table `excuses`
--

CREATE TABLE `excuses` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_no` varchar(30) NOT NULL,
  `name` varchar(120) NOT NULL,
  `program` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_no`, `name`, `program`) VALUES
(1, '2024-0001', 'Juan Dela Cruz', 'BSIS'),
(2, '2024-0002', 'Maria Santos', 'BSIS'),
(5, '2024-0006', 'FRANCISCO ACHLLES', 'BSIS'),
(6, '2024-0004', 'ana lopez', 'BSIS'),
(7, '2025-0005', 'MUARES JESSA', 'BSIS'),
(8, '2024-0008', 'juan dela Cruz', 'BSIS'),
(9, '2024-0009', 'gord vel', 'BSED'),
(10, '2024-0011', 'justin ulip', 'BSHM');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','organizer','staff') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `password`, `role`) VALUES
(1, 'admin', 'System Admin', '$2y$10$4AU/2VUmkBBdaiq56EwOauYCukko6w3X8wsw1CD5z1hQtMWZh5ek6', 'admin'),
(2, 'organizer', 'Event Organizer', '$2y$10$nedIXZRjQohhTcYltFQE.u9RF3a0KQfF9aQgrzjBiF9JsGuk5gDDi', 'organizer'),
(3, 'staff', 'Check-in Staff', '$2y$10$QizQ2hR2V1BkaNue2Ti5NOTDLk.QP2L9mk5Dzuz1DH2/NXM2vuT7C', 'staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `one_scan` (`event_id`,`student_id`,`slot`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `excuses`
--
ALTER TABLE `excuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `one_excuse` (`event_id`,`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_no` (`student_no`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `excuses`
--
ALTER TABLE `excuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
