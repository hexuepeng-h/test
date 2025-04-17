-- 创建通知数据库
CREATE DATABASE IF NOT EXISTS `notification_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `notification_db`;

-- 创建通知记录表
CREATE TABLE IF NOT EXISTS `notification` (
  `id` varchar(50) NOT NULL COMMENT '通知ID',
  `type` varchar(20) NOT NULL COMMENT '通知类型：email-邮件，sms-短信',
  `event_type` varchar(50) NOT NULL COMMENT '事件类型：appointment-created-预约创建，appointment-rescheduled-预约改期，appointment-cancelled-预约取消',
  `recipient` varchar(100) NOT NULL COMMENT '接收者',
  `content` text COMMENT '通知内容',
  `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT '状态：pending-待发送，sent-已发送，failed-发送失败',
  `retry_count` int NOT NULL DEFAULT 0 COMMENT '重试次数',
  `event_id` varchar(50) NOT NULL COMMENT '事件ID（关联的业务ID）',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  `sent_at` datetime DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `idx_event_id` (`event_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知记录表';

-- 创建通知模板表
CREATE TABLE IF NOT EXISTS `notification_template` (
  `id` varchar(50) NOT NULL COMMENT '模板ID',
  `code` varchar(50) NOT NULL COMMENT '模板代码',
  `name` varchar(100) NOT NULL COMMENT '模板名称',
  `type` varchar(20) NOT NULL COMMENT '模板类型：email-邮件，sms-短信',
  `subject` varchar(200) DEFAULT NULL COMMENT '主题（邮件）',
  `content` text NOT NULL COMMENT '模板内容',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知模板表';

-- 插入默认邮件模板
INSERT INTO `notification_template` (`id`, `code`, `name`, `type`, `subject`, `content`, `created_at`, `updated_at`)
VALUES
(REPLACE(UUID(),'-',''), 'appointment-created', '预约创建通知', 'email', '您的预约已创建', 
'<div style="max-width: 600px; margin: 0 auto; padding: 20px; font-family: Arial, sans-serif;">
  <h2 style="color: #3498db;">预约创建通知</h2>
  <p>尊敬的 <strong>${patientName}</strong>：</p>
  <p>您已成功预约 <strong>${doctorName}</strong> 医生的诊疗服务。</p>
  <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 15px 0;">
    <p><strong>预约日期：</strong> ${appointmentDate}</p>
    <p><strong>预约时间：</strong> ${startTime} - ${endTime}</p>
    <p><strong>备注：</strong> ${remark}</p>
  </div>
  <p>请按时到达，如需取消或改期，请提前联系我们。</p>
  <p>此致<br>医疗平台团队</p>
</div>', NOW(), NOW()),

(REPLACE(UUID(),'-',''), 'appointment-rescheduled', '预约改期通知', 'email', '您的预约已改期', 
'<div style="max-width: 600px; margin: 0 auto; padding: 20px; font-family: Arial, sans-serif;">
  <h2 style="color: #e67e22;">预约改期通知</h2>
  <p>尊敬的 <strong>${patientName}</strong>：</p>
  <p>您与 <strong>${doctorName}</strong> 医生的预约已改期。</p>
  <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 15px 0;">
    <p><strong>原预约日期：</strong> ${oldAppointmentDate}</p>
    <p><strong>原预约时间：</strong> ${oldStartTime} - ${oldEndTime}</p>
    <p><strong>新预约日期：</strong> ${appointmentDate}</p>
    <p><strong>新预约时间：</strong> ${startTime} - ${endTime}</p>
    <p><strong>备注：</strong> ${remark}</p>
  </div>
  <p>如有任何疑问，请联系我们。</p>
  <p>此致<br>医疗平台团队</p>
</div>', NOW(), NOW()),

(REPLACE(UUID(),'-',''), 'appointment-cancelled', '预约取消通知', 'email', '您的预约已取消', 
'<div style="max-width: 600px; margin: 0 auto; padding: 20px; font-family: Arial, sans-serif;">
  <h2 style="color: #e74c3c;">预约取消通知</h2>
  <p>尊敬的 <strong>${patientName}</strong>：</p>
  <p>您与 <strong>${doctorName}</strong> 医生的预约已取消。</p>
  <div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 15px 0;">
    <p><strong>预约日期：</strong> ${appointmentDate}</p>
    <p><strong>预约时间：</strong> ${startTime} - ${endTime}</p>
    <p><strong>备注：</strong> ${remark}</p>
  </div>
  <p>如需重新预约，请访问我们的平台。</p>
  <p>此致<br>医疗平台团队</p>
</div>', NOW(), NOW()); 