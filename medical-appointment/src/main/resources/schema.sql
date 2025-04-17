-- 创建预约数据库
CREATE DATABASE IF NOT EXISTS `appointment_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `appointment_db`;

-- 创建预约表
CREATE TABLE IF NOT EXISTS `appointment` (
  `id` varchar(50) NOT NULL COMMENT '预约ID',
  `patient_id` varchar(50) NOT NULL COMMENT '病人ID',
  `doctor_id` varchar(50) NOT NULL COMMENT '医生ID',
  `date` date NOT NULL COMMENT '预约日期',
  `start_time` time NOT NULL COMMENT '开始时间',
  `end_time` time NOT NULL COMMENT '结束时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `status` varchar(20) NOT NULL DEFAULT 'normal' COMMENT '状态：normal-正常，to_be_rescheduled-待重新安排，cancelled-已取消',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_patient_id` (`patient_id`),
  KEY `idx_doctor_id` (`doctor_id`),
  KEY `idx_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='预约表'; 