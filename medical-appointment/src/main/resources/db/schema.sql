-- 创建数据库
CREATE DATABASE IF NOT EXISTS appointment_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE appointment_db;

-- 创建预约表
CREATE TABLE IF NOT EXISTS appointment (
  id VARCHAR(36) NOT NULL COMMENT '预约ID',
  patient_id VARCHAR(36) NOT NULL COMMENT '病人ID',
  doctor_id VARCHAR(36) NOT NULL COMMENT '医生ID',
  date DATE NOT NULL COMMENT '预约日期',
  start_time TIME NOT NULL COMMENT '开始时间',
  end_time TIME NOT NULL COMMENT '结束时间',
  remark VARCHAR(500) DEFAULT NULL COMMENT '备注',
  status VARCHAR(20) NOT NULL DEFAULT 'normal' COMMENT '状态：normal-正常，to_be_rescheduled-待重新安排，cancelled-已取消',
  created_at DATETIME NOT NULL COMMENT '创建时间',
  updated_at DATETIME NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  INDEX idx_patient_id (patient_id),
  INDEX idx_doctor_id (doctor_id),
  INDEX idx_date (date),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预约表'; 