-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2026 at 08:44 PM
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
-- Database: `geomanage`
--
CREATE DATABASE IF NOT EXISTS `geomanage` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `geomanage`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
CREATE TABLE `certificate` (
  `certificate_id` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `application_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract` (
  `contract_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `signing_date` date NOT NULL,
  `salary` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliverable`
--

DROP TABLE IF EXISTS `deliverable`;
CREATE TABLE `deliverable` (
  `deliverable_id` int(11) NOT NULL,
  `deliverable_name` varchar(100) NOT NULL,
  `deliverable_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `submission_date` date NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_type`
--

DROP TABLE IF EXISTS `document_type`;
CREATE TABLE `document_type` (
  `document_type_id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL,
  `equipment_name` varchar(100) NOT NULL,
  `equipment_type` varchar(100) NOT NULL,
  `serial_number` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `maintenance_note` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
CREATE TABLE `expense` (
  `expense_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `description` text NOT NULL,
  `expense_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `has_servicerequest_submitteddocument`
--

DROP TABLE IF EXISTS `has_servicerequest_submitteddocument`;
CREATE TABLE `has_servicerequest_submitteddocument` (
  `has_servicerequest_submitteddocument_id` int(11) NOT NULL,
  `service_request_id` int(11) NOT NULL,
  `submitted_document_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hr`
--

DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr` (
  `hr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `includes_project_land`
--

DROP TABLE IF EXISTS `includes_project_land`;
CREATE TABLE `includes_project_land` (
  `includes_project_land_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `land_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `interview_schedule`
--

DROP TABLE IF EXISTS `interview_schedule`;
CREATE TABLE `interview_schedule` (
  `schedule_id` int(11) NOT NULL,
  `interview_date` date NOT NULL,
  `interview_time` time NOT NULL,
  `interview_type` varchar(50) NOT NULL,
  `result` varchar(50) DEFAULT 'Pending',
  `status` varchar(50) DEFAULT 'Scheduled',
  `interview_location` varchar(255) DEFAULT NULL,
  `hr_id` int(11) NOT NULL,
  `application_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_application`
--

DROP TABLE IF EXISTS `job_application`;
CREATE TABLE `job_application` (
  `application_id` int(11) NOT NULL,
  `applicant_name` varchar(100) NOT NULL,
  `application_date` date NOT NULL DEFAULT current_timestamp(),
  `applicant_email` varchar(100) NOT NULL,
  `applicant_phone` int(20) NOT NULL,
  `cover_letter` text DEFAULT NULL,
  `cv_file_path` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `hr_id` int(11) DEFAULT NULL,
  `interview_date` date DEFAULT NULL,
  `interview_time` time DEFAULT NULL,
  `interview_location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_opportunity`
--

DROP TABLE IF EXISTS `job_opportunity`;
CREATE TABLE `job_opportunity` (
  `job_id` int(11) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `number_of_positions` int(11) NOT NULL,
  `requirements` text NOT NULL,
  `responsibilities` text NOT NULL,
  `status` varchar(50) NOT NULL,
  `hr_id` int(11) NOT NULL,
  `job_type` varchar(11) NOT NULL,
  `job_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `land`
--

DROP TABLE IF EXISTS `land`;
CREATE TABLE `land` (
  `land_id` int(11) NOT NULL,
  `land_address` varchar(255) DEFAULT NULL,
  `land_area` decimal(10,2) DEFAULT NULL,
  `land_type` varchar(100) DEFAULT NULL,
  `coordinates_latitude` decimal(10,6) DEFAULT NULL,
  `coordinates_longitude` decimal(10,6) DEFAULT NULL,
  `general_description` text DEFAULT NULL,
  `specific_location_notes` text DEFAULT NULL,
  `land_number` varchar(50) DEFAULT NULL,
  `elevation_avg` int(11) DEFAULT NULL,
  `slope` decimal(5,2) DEFAULT NULL,
  `distance_from_office` decimal(10,3) DEFAULT NULL,
  `elevation_min` int(11) DEFAULT NULL,
  `elevation_max` int(11) DEFAULT NULL,
  `terrain_factor` double DEFAULT NULL,
  `geometry_approved` int(11) NOT NULL DEFAULT 0,
  `terrain_approved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `land_listing`
--

DROP TABLE IF EXISTS `land_listing`;
CREATE TABLE `land_listing` (
  `listing_id` int(11) NOT NULL,
  `listing_date` date NOT NULL,
  `asking_price` decimal(12,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `company_percentage` decimal(30,0) DEFAULT 4,
  `company_profit` int(20) DEFAULT NULL,
  `approval_status` varchar(100) NOT NULL,
  `rejection_reason` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `sales_person_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `land_number` varchar(100) DEFAULT NULL,
  `land_area` decimal(10,2) DEFAULT NULL,
  `land_type` varchar(50) DEFAULT NULL,
  `land_address` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `land_photos`
--

DROP TABLE IF EXISTS `land_photos`;
CREATE TABLE `land_photos` (
  `photo_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `photo_path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `land_price_prediction`
--

DROP TABLE IF EXISTS `land_price_prediction`;
CREATE TABLE `land_price_prediction` (
  `prediction_id` int(11) NOT NULL,
  `predicted_price` decimal(12,2) NOT NULL,
  `prediction_date` date NOT NULL,
  `land_features` text NOT NULL,
  `land_type` varchar(100) NOT NULL,
  `land_area` varchar(255) NOT NULL,
  `location_address` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_engineer`
--

DROP TABLE IF EXISTS `lead_engineer`;
CREATE TABLE `lead_engineer` (
  `lead_engineer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `license_number` varchar(100) NOT NULL,
  `years_experience` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance` (
  `maintenance_id` int(11) NOT NULL,
  `maintenance_type` varchar(100) DEFAULT NULL,
  `maintenance_date` date DEFAULT NULL,
  `request_date` date DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  `description` text NOT NULL,
  `bill_file_path` varchar(255) DEFAULT NULL,
  `equipment_id` int(11) NOT NULL,
  `maintenance_technician_id` int(11) DEFAULT NULL,
  `requested_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_technician`
--

DROP TABLE IF EXISTS `maintenance_technician`;
CREATE TABLE `maintenance_technician` (
  `maintenance_technician_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
CREATE TABLE `office` (
  `office_id` int(11) NOT NULL,
  `coordinates_latitude` decimal(10,6) DEFAULT NULL,
  `coordinates_longitude` decimal(10,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owns_client_land`
--

DROP TABLE IF EXISTS `owns_client_land`;
CREATE TABLE `owns_client_land` (
  `owns_client_land_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `land_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `project_id` int(11) NOT NULL,
  `project_name` varchar(150) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_cost` decimal(12,2) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(50) NOT NULL,
  `payment_status` varchar(100) NOT NULL,
  `lead_engineer_id` int(11) NOT NULL,
  `team_size` int(11) NOT NULL,
  `progress` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requires_service_documenttype`
--

DROP TABLE IF EXISTS `requires_service_documenttype`;
CREATE TABLE `requires_service_documenttype` (
  `requires_service_documenttype_id` int(11) NOT NULL,
  `is_mandatory` enum('yes','no') NOT NULL,
  `service_id` int(11) NOT NULL,
  `document_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary_payment`
--

DROP TABLE IF EXISTS `salary_payment`;
CREATE TABLE `salary_payment` (
  `salary_payment_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `date_paid` date NOT NULL,
  `notes` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `hr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales_person`
--

DROP TABLE IF EXISTS `sales_person`;
CREATE TABLE `sales_person` (
  `sales_person_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `commission_rate` decimal(30,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `max_price` double NOT NULL,
  `min_price` double NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `service_name`, `description`, `max_price`, `min_price`, `status`) VALUES
(1, 'Boundary Survey', 'Precise property boundary determination', 1200, 200, 'active'),
(2, 'Topographic Survey', 'Detailed land elevation and feature mapping', 1200, 200, 'active'),
(3, 'Construction Staking', 'Marking construction points on sitee', 1200, 200, 'active'),
(4, 'Subdivision Planning', 'Land division planning and surveying', 1200, 200, 'active'),
(5, 'GIS Mapping', 'Geographic information system data creation', 1200, 200, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `service_request`
--

DROP TABLE IF EXISTS `service_request`;
CREATE TABLE `service_request` (
  `request_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `request_date` date NOT NULL,
  `approval_status` varchar(50) DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `land_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submitted_document`
--

DROP TABLE IF EXISTS `submitted_document`;
CREATE TABLE `submitted_document` (
  `document_id` int(11) NOT NULL,
  `upload_date` date NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `document_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `surveyor`
--

DROP TABLE IF EXISTS `surveyor`;
CREATE TABLE `surveyor` (
  `surveyor_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `years_experience` int(11) NOT NULL,
  `status` varchar(100) NOT NULL,
  `assigned_date` date DEFAULT NULL,
  `role_description` varchar(100) NOT NULL,
  `project_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `role` enum('Admin','Client','Surveyor','LeadEngineer','HR','Sales_Person','Maintenance_Technician') NOT NULL,
  `created_at` datetime NOT NULL,
  `active` int(255) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `full_name`, `email`, `password`, `phone`, `role`, `created_at`, `active`) VALUES
(51, 'John Smith', 'admin@company.com', 'hashed_admin_pass', '555-0101', 'Admin', '2024-01-15 09:00:00', 1),
(52, 'Sarah Johnson', 'hr.sarah@company.com', 'hashed_password_2', '555-0102', 'HR', '2024-01-16 09:00:00', 1),
(53, 'Mike Chen', 'engineer.mike@company.com', 'hashed_password_3', '555-0103', 'LeadEngineer', '2024-01-17 09:00:00', 1),
(54, 'Emily Davis', 'sales.emily@company.com', 'hashed_password_4', '555-0104', 'Sales_Person', '2024-01-18 09:00:00', 1),
(55, 'David Wilson', 'tech.david@company.com', 'hashed_password_5', '555-0105', 'Maintenance_Technician', '2024-01-19 09:00:00', 1),
(56, 'Michael Thompson', 'surveyor.michael@company.com', 'hashed_password_11', '555-0401', 'Surveyor', '2024-01-20 09:00:00', 1),
(57, 'Sarah Clark', 'surveyor.sarah@company.com', 'hashed_password_12', '555-0402', 'Surveyor', '2024-01-21 09:00:00', 1),
(58, 'Daniel Lewis', 'surveyor.daniel@company.com', 'hashed_password_13', '555-0403', 'Surveyor', '2024-01-22 09:00:00', 1),
(59, 'Michelle Walker', 'surveyor.michelle@company.com', 'hashed_password_14', '555-0404', 'Surveyor', '2024-01-23 09:00:00', 1),
(60, 'Kevin Hall', 'surveyor.kevin@company.com', 'hashed_password_15', '555-0405', 'Surveyor', '2024-01-24 09:00:00', 1),
(62, 'HR Manager', 'hr.manager@company.com', 'hashed_hr_pass', '555-0002', 'HR', '2024-11-07 10:00:00', 1),
(63, 'Lead Engineer 1', 'engineer.lead1@company.com', 'hashed_eng1_pass', '555-0003', 'LeadEngineer', '2024-11-07 10:00:00', 1),
(64, 'Sales Person 1', 'sales.person1@company.com', 'hashed_sales1_pass', '555-0004', 'Sales_Person', '2024-11-07 10:00:00', 1),
(65, 'Tech 1', 'tech1@company.com', 'hashed_tech1_pass', '555-0005', 'Maintenance_Technician', '2024-11-07 10:00:00', 1),
(66, 'Client User 1', '92330378@students.liu.edu.lb', 'hashed_client1_pass', '555-0006', 'Client', '2024-11-07 10:00:00', 1),
(67, 'Client User 2', 'client2@email.com', 'hashed_client2_pass', '555-0007', 'Client', '2024-11-07 10:00:00', 1),
(68, 'Client User 3', 'client3@email.com', 'hashed_client3_pass', '555-0008', 'Client', '2024-11-07 10:00:00', 1),
(69, 'Client User 4', 'client4@email.com', 'hashed_client4_pass', '555-0009', 'Client', '2024-11-07 10:00:00', 1),
(70, 'Client User 5', 'client5@email.com', 'hashed_client5_pass', '555-0010', 'Client', '2024-11-07 10:00:00', 1),
(71, 'Elie habka', 'alice@example.com', '$2y$10$NQk1ZYoyOkkIjICUSqP5t.QCl20r1EscxKi3.u9SS.PxmZVNp44Qq', '81394968', 'Client', '2025-11-09 15:01:53', 1),
(72, 'elie habka', 'ahmad.khalil@email.com', '$2y$10$yJoV7.7kMBrrpuO.OfmONeLAvd3y4yosHaqlbo1ckPaBfj4frydAW', '81394968', 'Client', '2025-11-09 18:11:49', 1),
(73, 'elie habka', 'joelle.frem@hospital.lb', 'f2958022fe2213742b677f8060075a84', '81394968', 'Client', '2025-11-09 18:41:07', 1),
(76, 'elie habka', 'joelle.fredggdgdgm@hospital.lb', '8c00424082589c90b72bb0f48fedda1b', '81394968', 'Client', '2026-01-01 11:25:25', 1),
(84, 'jhon macphee', 'john@1efef23444gmail.com', '$2y$10$gs7uXUaNZlEXlbD3VmOj9OXhUievB9ItmK6IvW2LmUH6WviuECVAm', '342432432', 'Surveyor', '2026-01-09 16:22:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `uses_project_equipment`
--

DROP TABLE IF EXISTS `uses_project_equipment`;
CREATE TABLE `uses_project_equipment` (
  `uses_project_equipment_id` int(11) NOT NULL,
  `return_date` date NOT NULL,
  `assigned_date` date NOT NULL,
  `project_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `certificate`
--
ALTER TABLE `certificate`
  ADD PRIMARY KEY (`certificate_id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`contract_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `deliverable`
--
ALTER TABLE `deliverable`
  ADD PRIMARY KEY (`deliverable_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `document_type`
--
ALTER TABLE `document_type`
  ADD PRIMARY KEY (`document_type_id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`equipment_id`);

--
-- Indexes for table `expense`
--
ALTER TABLE `expense`
  ADD PRIMARY KEY (`expense_id`);

--
-- Indexes for table `has_servicerequest_submitteddocument`
--
ALTER TABLE `has_servicerequest_submitteddocument`
  ADD PRIMARY KEY (`has_servicerequest_submitteddocument_id`),
  ADD KEY `service_request_id` (`service_request_id`),
  ADD KEY `submitted_document_id` (`submitted_document_id`);

--
-- Indexes for table `hr`
--
ALTER TABLE `hr`
  ADD PRIMARY KEY (`hr_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `includes_project_land`
--
ALTER TABLE `includes_project_land`
  ADD PRIMARY KEY (`includes_project_land_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `land_id` (`land_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `interview_schedule`
--
ALTER TABLE `interview_schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `hr_id` (`hr_id`);

--
-- Indexes for table `job_application`
--
ALTER TABLE `job_application`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `hr_id` (`hr_id`);

--
-- Indexes for table `job_opportunity`
--
ALTER TABLE `job_opportunity`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `hr_id` (`hr_id`);

--
-- Indexes for table `land`
--
ALTER TABLE `land`
  ADD PRIMARY KEY (`land_id`);

--
-- Indexes for table `land_listing`
--
ALTER TABLE `land_listing`
  ADD PRIMARY KEY (`listing_id`),
  ADD KEY `sales_person_id` (`sales_person_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `land_photos`
--
ALTER TABLE `land_photos`
  ADD PRIMARY KEY (`photo_id`),
  ADD KEY `listing_id` (`listing_id`);

--
-- Indexes for table `land_price_prediction`
--
ALTER TABLE `land_price_prediction`
  ADD PRIMARY KEY (`prediction_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `lead_engineer`
--
ALTER TABLE `lead_engineer`
  ADD PRIMARY KEY (`lead_engineer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`maintenance_id`),
  ADD KEY `equipment_id` (`equipment_id`),
  ADD KEY `repairman_id` (`maintenance_technician_id`),
  ADD KEY `requested_by` (`requested_by`);

--
-- Indexes for table `maintenance_technician`
--
ALTER TABLE `maintenance_technician`
  ADD PRIMARY KEY (`maintenance_technician_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `office`
--
ALTER TABLE `office`
  ADD PRIMARY KEY (`office_id`);

--
-- Indexes for table `owns_client_land`
--
ALTER TABLE `owns_client_land`
  ADD PRIMARY KEY (`owns_client_land_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `land_id` (`land_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `lead_enginer_id` (`lead_engineer_id`);

--
-- Indexes for table `requires_service_documenttype`
--
ALTER TABLE `requires_service_documenttype`
  ADD PRIMARY KEY (`requires_service_documenttype_id`),
  ADD KEY `document_type` (`document_type_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `salary_payment`
--
ALTER TABLE `salary_payment`
  ADD PRIMARY KEY (`salary_payment_id`),
  ADD KEY `hr_id` (`hr_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sales_person`
--
ALTER TABLE `sales_person`
  ADD PRIMARY KEY (`sales_person_id`),
  ADD UNIQUE KEY `User_ID` (`user_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `service_request`
--
ALTER TABLE `service_request`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `land_id` (`land_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `submitted_document`
--
ALTER TABLE `submitted_document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `document_type_id` (`document_type_id`);

--
-- Indexes for table `surveyor`
--
ALTER TABLE `surveyor`
  ADD PRIMARY KEY (`surveyor_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `uses_project_equipment`
--
ALTER TABLE `uses_project_equipment`
  ADD PRIMARY KEY (`uses_project_equipment_id`),
  ADD KEY `equipment_id` (`equipment_id`),
  ADD KEY `project_id` (`project_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificate`
--
ALTER TABLE `certificate`
  MODIFY `certificate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contract`
--
ALTER TABLE `contract`
  MODIFY `contract_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliverable`
--
ALTER TABLE `deliverable`
  MODIFY `deliverable_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_type`
--
ALTER TABLE `document_type`
  MODIFY `document_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense`
--
ALTER TABLE `expense`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `has_servicerequest_submitteddocument`
--
ALTER TABLE `has_servicerequest_submitteddocument`
  MODIFY `has_servicerequest_submitteddocument_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hr`
--
ALTER TABLE `hr`
  MODIFY `hr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `includes_project_land`
--
ALTER TABLE `includes_project_land`
  MODIFY `includes_project_land_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interview_schedule`
--
ALTER TABLE `interview_schedule`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_application`
--
ALTER TABLE `job_application`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_opportunity`
--
ALTER TABLE `job_opportunity`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land`
--
ALTER TABLE `land`
  MODIFY `land_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_listing`
--
ALTER TABLE `land_listing`
  MODIFY `listing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_photos`
--
ALTER TABLE `land_photos`
  MODIFY `photo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_price_prediction`
--
ALTER TABLE `land_price_prediction`
  MODIFY `prediction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_engineer`
--
ALTER TABLE `lead_engineer`
  MODIFY `lead_engineer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `maintenance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maintenance_technician`
--
ALTER TABLE `maintenance_technician`
  MODIFY `maintenance_technician_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `office`
--
ALTER TABLE `office`
  MODIFY `office_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `owns_client_land`
--
ALTER TABLE `owns_client_land`
  MODIFY `owns_client_land_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requires_service_documenttype`
--
ALTER TABLE `requires_service_documenttype`
  MODIFY `requires_service_documenttype_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salary_payment`
--
ALTER TABLE `salary_payment`
  MODIFY `salary_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_person`
--
ALTER TABLE `sales_person`
  MODIFY `sales_person_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `service_request`
--
ALTER TABLE `service_request`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submitted_document`
--
ALTER TABLE `submitted_document`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `surveyor`
--
ALTER TABLE `surveyor`
  MODIFY `surveyor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `uses_project_equipment`
--
ALTER TABLE `uses_project_equipment`
  MODIFY `uses_project_equipment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `certificate`
--
ALTER TABLE `certificate`
  ADD CONSTRAINT `certificate_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `job_application` (`application_id`);

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `deliverable`
--
ALTER TABLE `deliverable`
  ADD CONSTRAINT `deliverable_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `has_servicerequest_submitteddocument`
--
ALTER TABLE `has_servicerequest_submitteddocument`
  ADD CONSTRAINT `has_servicerequest_submitteddocument_ibfk_1` FOREIGN KEY (`service_request_id`) REFERENCES `service_request` (`request_id`),
  ADD CONSTRAINT `has_servicerequest_submitteddocument_ibfk_2` FOREIGN KEY (`submitted_document_id`) REFERENCES `submitted_document` (`document_id`);

--
-- Constraints for table `hr`
--
ALTER TABLE `hr`
  ADD CONSTRAINT `hr_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `includes_project_land`
--
ALTER TABLE `includes_project_land`
  ADD CONSTRAINT `includes_project_land_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  ADD CONSTRAINT `includes_project_land_ibfk_2` FOREIGN KEY (`land_id`) REFERENCES `land` (`land_id`),
  ADD CONSTRAINT `includes_project_land_ibfk_3` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `interview_schedule`
--
ALTER TABLE `interview_schedule`
  ADD CONSTRAINT `interview_schedule_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `job_application` (`application_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `interview_schedule_ibfk_2` FOREIGN KEY (`hr_id`) REFERENCES `hr` (`hr_id`);

--
-- Constraints for table `job_application`
--
ALTER TABLE `job_application`
  ADD CONSTRAINT `job_application_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `job_application_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job_opportunity` (`job_id`),
  ADD CONSTRAINT `job_application_ibfk_3` FOREIGN KEY (`hr_id`) REFERENCES `hr` (`hr_id`);

--
-- Constraints for table `job_opportunity`
--
ALTER TABLE `job_opportunity`
  ADD CONSTRAINT `job_opportunity_ibfk_1` FOREIGN KEY (`hr_id`) REFERENCES `hr` (`hr_id`);

--
-- Constraints for table `land_listing`
--
ALTER TABLE `land_listing`
  ADD CONSTRAINT `land_listing_ibfk_1` FOREIGN KEY (`sales_person_id`) REFERENCES `sales_person` (`sales_person_id`),
  ADD CONSTRAINT `land_listing_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

--
-- Constraints for table `land_photos`
--
ALTER TABLE `land_photos`
  ADD CONSTRAINT `land_photos_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `land_listing` (`listing_id`) ON DELETE CASCADE;

--
-- Constraints for table `land_price_prediction`
--
ALTER TABLE `land_price_prediction`
  ADD CONSTRAINT `land_price_prediction_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`);

--
-- Constraints for table `lead_engineer`
--
ALTER TABLE `lead_engineer`
  ADD CONSTRAINT `lead_engineer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `maintenance_technician`
--
ALTER TABLE `maintenance_technician`
  ADD CONSTRAINT `maintenance_technician_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `owns_client_land`
--
ALTER TABLE `owns_client_land`
  ADD CONSTRAINT `owns_client_land_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  ADD CONSTRAINT `owns_client_land_ibfk_2` FOREIGN KEY (`land_id`) REFERENCES `land` (`land_id`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`lead_engineer_id`) REFERENCES `lead_engineer` (`lead_engineer_id`);

--
-- Constraints for table `requires_service_documenttype`
--
ALTER TABLE `requires_service_documenttype`
  ADD CONSTRAINT `requires_service_documenttype_ibfk_1` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`document_type_id`),
  ADD CONSTRAINT `requires_service_documenttype_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`);

--
-- Constraints for table `salary_payment`
--
ALTER TABLE `salary_payment`
  ADD CONSTRAINT `salary_payment_ibfk_1` FOREIGN KEY (`hr_id`) REFERENCES `hr` (`hr_id`),
  ADD CONSTRAINT `salary_payment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `sales_person`
--
ALTER TABLE `sales_person`
  ADD CONSTRAINT `sales_person_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `service_request`
--
ALTER TABLE `service_request`
  ADD CONSTRAINT `service_request_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `service_request_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `service_request_ibfk_3` FOREIGN KEY (`land_id`) REFERENCES `land` (`land_id`),
  ADD CONSTRAINT `service_request_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `submitted_document`
--
ALTER TABLE `submitted_document`
  ADD CONSTRAINT `submitted_document_ibfk_1` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`document_type_id`) ON UPDATE CASCADE;

--
-- Constraints for table `surveyor`
--
ALTER TABLE `surveyor`
  ADD CONSTRAINT `surveyor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `surveyor_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

--
-- Constraints for table `uses_project_equipment`
--
ALTER TABLE `uses_project_equipment`
  ADD CONSTRAINT `uses_project_equipment_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`),
  ADD CONSTRAINT `uses_project_equipment_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
