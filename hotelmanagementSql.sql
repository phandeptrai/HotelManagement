-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th6 26, 2025 lúc 02:26 AM
-- Phiên bản máy phục vụ: 8.4.3
-- Phiên bản PHP: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hotelbookingdb`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `invoices`
--

CREATE TABLE `invoices` (
  `invoiceID` int NOT NULL,
  `bookingID` int DEFAULT NULL,
  `paymentMethodID` int DEFAULT NULL,
  `invoiceDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `paymentmethods`
--

CREATE TABLE `paymentmethods` (
  `paymentMethodID` int NOT NULL,
  `methodName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `paymentmethods`
--

INSERT INTO `paymentmethods` (`paymentMethodID`, `methodName`) VALUES
(1, 'vnpay'),
(2, 'cash');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roombookings`
--

CREATE TABLE `roombookings` (
  `bookingID` int NOT NULL,
  `userID` int DEFAULT NULL,
  `roomID` int DEFAULT NULL,
  `checkInDate` date DEFAULT NULL,
  `checkOutDate` date DEFAULT NULL,
  `bookingStatus` enum('CONFIRMED','CANCELLED','PENDING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'CONFIRMED',
  `totalAmount` decimal(10,2) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `cancelledAt` timestamp NULL DEFAULT NULL,
  `cancelReason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `roombookings`
--

INSERT INTO `roombookings` (`bookingID`, `userID`, `roomID`, `checkInDate`, `checkOutDate`, `bookingStatus`, `totalAmount`, `createdAt`, `cancelledAt`, `cancelReason`) VALUES
(1, 1, 2, '2025-06-02', '2025-06-20', 'CONFIRMED', NULL, '2025-06-04 15:29:20', NULL, NULL),
(2, 1, 1, '2025-06-05', '2025-06-13', 'CONFIRMED', NULL, '2025-06-09 14:16:14', NULL, NULL),
(3, 1, 1, '2025-06-13', '2025-06-20', 'CONFIRMED', NULL, '2025-06-09 14:32:18', NULL, NULL),
(4, 1, 1, '2025-06-20', '2025-06-28', 'CONFIRMED', NULL, '2025-06-11 14:40:25', NULL, NULL),
(5, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 0.00, '2025-06-11 14:45:54', NULL, NULL),
(6, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 0.00, '2025-06-11 14:49:54', NULL, NULL),
(7, 1, 1, '2025-06-11', '2025-06-13', 'CONFIRMED', 20000.00, '2025-06-11 15:02:06', NULL, NULL),
(8, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 160250.00, '2025-06-11 15:13:36', NULL, NULL),
(9, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 160250.00, '2025-06-11 15:14:46', NULL, NULL),
(10, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 160250.00, '2025-06-11 15:16:18', NULL, NULL),
(11, 1, 1, '2025-06-12', '2025-06-20', 'CONFIRMED', 160250.00, '2025-06-11 15:17:22', NULL, NULL),
(12, 1, 1, '2025-06-13', '2025-06-20', 'CONFIRMED', 140560.00, '2025-06-11 15:19:34', NULL, NULL),
(13, 1, 1, '2025-06-13', '2025-06-29', 'CONFIRMED', 320560.00, '2025-06-11 15:27:27', NULL, NULL),
(14, 4, 1, '2025-06-17', '2025-06-27', 'CONFIRMED', 200450.00, '2025-06-16 14:54:26', NULL, NULL),
(15, 4, 2, '2025-06-17', '2025-06-27', 'CONFIRMED', 200450.00, '2025-06-16 14:59:06', NULL, NULL),
(16, 4, 1, '2025-06-21', '2025-07-06', 'CONFIRMED', 32700.00, '2025-06-20 14:07:56', NULL, NULL),
(17, 4, 1, '2025-06-21', '2025-12-07', 'CONFIRMED', 84950.00, '2025-06-20 14:12:50', NULL, NULL),
(18, 4, 1, '2025-06-20', '2025-12-28', 'CONFIRMED', 95500.00, '2025-06-20 14:14:50', NULL, NULL),
(19, 4, 1, '2025-06-21', '2025-10-25', 'CONFIRMED', 63000.00, '2025-06-20 14:27:27', NULL, NULL),
(20, 4, 2, '2025-06-21', '2025-09-28', 'CONFIRMED', 74580.00, '2025-06-20 14:29:25', NULL, NULL),
(21, 4, 1, '2025-06-21', '2025-06-29', 'CONFIRMED', 4000.00, '2025-06-20 14:36:34', NULL, NULL),
(22, 4, 1, '2025-06-28', '2025-06-29', 'CANCELLED', 500.00, '2025-06-21 17:15:40', '2025-06-21 17:16:15', 'super sun day'),
(23, 4, 1, '2025-06-29', '2025-07-06', 'CANCELLED', 3500.00, '2025-06-21 17:17:02', '2025-06-21 17:44:52', 'tapemono suberrád'),
(24, 4, 1, '2025-06-24', '2025-06-29', 'CANCELLED', 2500.00, '2025-06-21 17:48:08', '2025-06-21 17:48:18', 'con cac to bum bo bee'),
(25, 4, 1, '2025-06-24', '2025-06-29', 'CANCELLED', 2500.00, '2025-06-21 18:00:35', '2025-06-21 18:15:23', 'bakayaro ssđsđ'),
(26, 4, 1, '2025-06-24', '2025-06-28', 'CANCELLED', 2910.00, '2025-06-23 13:42:40', '2025-06-23 13:42:52', 'domain expansion');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rooms`
--

CREATE TABLE `rooms` (
  `roomID` int NOT NULL,
  `roomNumber` varchar(10) DEFAULT NULL,
  `roomTypeID` int DEFAULT NULL,
  `status` enum('AVAILABLE','BOOKED','MAINTENANCE') DEFAULT 'AVAILABLE',
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `rooms`
--

INSERT INTO `rooms` (`roomID`, `roomNumber`, `roomTypeID`, `status`, `price`) VALUES
(1, '101', 1, 'AVAILABLE', 500000.04),
(2, '102', 2, 'BOOKED', 750000.00),
(3, '103', 1, 'MAINTENANCE', 550000.00),
(4, '104', 1, 'AVAILABLE', 520000.00),
(5, '105', 2, 'BOOKED', 750000.00),
(6, '106', 1, 'AVAILABLE', 510000.00),
(7, '107', 3, 'MAINTENANCE', 500000.00),
(8, '108', 3, 'AVAILABLE', 780000.00),
(9, '109', 1, 'BOOKED', 540000.00),
(10, '110', 2, 'AVAILABLE', 790000.00),
(11, '201', 2, 'AVAILABLE', 800000.00),
(12, '202', 3, 'BOOKED', 820000.00),
(13, '203', 1, 'AVAILABLE', 550000.00),
(14, '204', 1, 'AVAILABLE', 560000.00),
(15, '205', 3, 'MAINTENANCE', 770000.00),
(16, '206', 1, 'AVAILABLE', 530000.00),
(17, '207', 2, 'BOOKED', 830000.00),
(18, '208', 3, 'AVAILABLE', 500000.00),
(19, '209', 1, 'BOOKED', 515000.00),
(20, '210', 3, 'AVAILABLE', 850000.00),
(21, '301', 3, 'AVAILABLE', 580000.00),
(22, '302', 2, 'BOOKED', 900000.00),
(23, '303', 3, 'AVAILABLE', 880000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roomtypes`
--

CREATE TABLE `roomtypes` (
  `roomTypeID` int NOT NULL,
  `typeName` enum('SINGLE','DOUBLE','SUITE') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `roomtypes`
--

INSERT INTO `roomtypes` (`roomTypeID`, `typeName`) VALUES
(1, 'SINGLE'),
(2, 'DOUBLE'),
(3, 'SUITE');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `servicebookings`
--

CREATE TABLE `servicebookings` (
  `id` int NOT NULL,
  `bookingID` int NOT NULL,
  `serviceID` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `servicebookings`
--

INSERT INTO `servicebookings` (`id`, `bookingID`, `serviceID`, `quantity`) VALUES
(1, 1, 1, 4),
(2, 1, 2, 3),
(3, 1, 3, 1),
(4, 2, 1, 3),
(5, 3, 3, 1),
(6, 7, 2, 3),
(7, 7, 3, 4),
(8, 7, 4, 4),
(9, 11, 1, 5),
(10, 12, 3, 7),
(11, 13, 3, 7),
(12, 14, 1, 9),
(13, 15, 1, 9),
(14, 16, 1, 4),
(15, 16, 10, 100),
(16, 17, 1, 9),
(17, 20, 1, 6),
(18, 20, 2, 1),
(19, 26, 1, 4),
(20, 26, 2, 5),
(21, 26, 3, 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `services`
--

CREATE TABLE `services` (
  `serviceID` int NOT NULL,
  `serviceName` varchar(100) DEFAULT NULL,
  `servicePrice` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `services`
--

INSERT INTO `services` (`serviceID`, `serviceName`, `servicePrice`) VALUES
(1, 'Laundry', 50000.00),
(2, 'Room Cleaning', 30000.00),
(3, 'Breakfast', 80000.00),
(4, 'Airport Pickup', 150000.00),
(5, 'Spa', 200000.00),
(6, 'Gym Access', 60000.00),
(7, 'Massage', 120000.00),
(8, 'Dinner Buffet', 180000.00),
(9, 'Mini Bar', 90000.00),
(10, 'City Tour', 250000.00),
(11, 'Late Checkout', 100000.00),
(12, 'Early Check-in', 90000.00),
(13, 'Dinner Room Service', 200000.00),
(14, 'Swimming Pool Access', 60000.00),
(15, 'Private Parking', 40000.00),
(16, 'Premium Internet', 30000.00),
(17, 'Birthday Room Setup', 250000.00),
(18, 'Laundry Express', 80000.00),
(19, 'In-room Entertainment', 70000.00),
(20, 'Business Center Access', 150000.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `userID` int NOT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  `role` enum('ROLE_ADMIN','ROLE_USER') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ROLE_USER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`userID`, `fullName`, `username`, `password`, `email`, `phoneNumber`, `role`) VALUES
(4, 'Phận đẹn trai', 'user', '$2a$10$hPfOPQrhoNCFnrvnplytbO4adpCgM6CgQnigWbrlyWJCy9IagCtfi', 'bbqdd3241@gmail.com', '0774445387', 'ROLE_USER'),
(5, NULL, 'user1', '$2a$10$ru2DSYBcla5ELZcowXiJReRVWVgW7A2t3JmiQ6wB6WjzpT6PRu4Fa', NULL, NULL, 'ROLE_ADMIN'),
(6, NULL, 'user123', '$2a$10$ATErYZoKv0nHvmrC2z8NTOTdht.Ju.Q3wGpk2yqHIjz7v1yE40WAK', NULL, NULL, 'ROLE_USER'),
(7, NULL, 'user4', '$2a$10$UJP/76zRt2vAFwRobvYHnOIpRbt5wb957HvhTOONsa5lmDfnOcUpO', NULL, NULL, 'ROLE_USER');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoiceID`),
  ADD KEY `bookingID` (`bookingID`),
  ADD KEY `paymentMethodID` (`paymentMethodID`);

--
-- Chỉ mục cho bảng `paymentmethods`
--
ALTER TABLE `paymentmethods`
  ADD PRIMARY KEY (`paymentMethodID`);

--
-- Chỉ mục cho bảng `roombookings`
--
ALTER TABLE `roombookings`
  ADD PRIMARY KEY (`bookingID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `roomID` (`roomID`);

--
-- Chỉ mục cho bảng `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`roomID`),
  ADD UNIQUE KEY `roomNumber` (`roomNumber`),
  ADD KEY `roomTypeID` (`roomTypeID`);

--
-- Chỉ mục cho bảng `roomtypes`
--
ALTER TABLE `roomtypes`
  ADD PRIMARY KEY (`roomTypeID`);

--
-- Chỉ mục cho bảng `servicebookings`
--
ALTER TABLE `servicebookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `serviceID` (`serviceID`),
  ADD KEY `servicebookings_ibfk_1` (`bookingID`);

--
-- Chỉ mục cho bảng `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`serviceID`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoiceID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `paymentmethods`
--
ALTER TABLE `paymentmethods`
  MODIFY `paymentMethodID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `roombookings`
--
ALTER TABLE `roombookings`
  MODIFY `bookingID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT cho bảng `rooms`
--
ALTER TABLE `rooms`
  MODIFY `roomID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `roomtypes`
--
ALTER TABLE `roomtypes`
  MODIFY `roomTypeID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `servicebookings`
--
ALTER TABLE `servicebookings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `services`
--
ALTER TABLE `services`
  MODIFY `serviceID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `userID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ràng buộc đối với các bảng kết xuất
--

--
-- Ràng buộc cho bảng `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`bookingID`) REFERENCES `roombookings` (`bookingID`),
  ADD CONSTRAINT `invoices_ibfk_2` FOREIGN KEY (`paymentMethodID`) REFERENCES `paymentmethods` (`paymentMethodID`);

--
-- Ràng buộc cho bảng `roombookings`
--
ALTER TABLE `roombookings`
  ADD CONSTRAINT `roombookings_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`),
  ADD CONSTRAINT `roombookings_ibfk_2` FOREIGN KEY (`roomID`) REFERENCES `rooms` (`roomID`);

--
-- Ràng buộc cho bảng `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`roomTypeID`) REFERENCES `roomtypes` (`roomTypeID`);

--
-- Ràng buộc cho bảng `servicebookings`
--
ALTER TABLE `servicebookings`
  ADD CONSTRAINT `servicebookings_ibfk_1` FOREIGN KEY (`bookingID`) REFERENCES `roombookings` (`bookingID`),
  ADD CONSTRAINT `servicebookings_ibfk_2` FOREIGN KEY (`serviceID`) REFERENCES `services` (`serviceID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
