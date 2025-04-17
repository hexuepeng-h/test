# 医疗平台微服务架构

## 项目概述
该项目是一个基于Spring Cloud的微服务架构的医疗平台系统，用于管理用户、预约和通知等功能。

## 技术栈
- Spring Boot 3.0.2
- Spring Cloud 
- Spring Cloud Gateway
- Spring Cloud Netflix Eureka
- MyBatis-Plus
- MySQL 8.x
- Redis
- Spring Security + JWT
- Knife4j
- Maven

## 服务模块
1. **Eureka Server**: 服务注册中心，管理服务注册与发现
2. **Gateway服务**: 网关服务，负责请求的路由和过滤
3. **用户服务**: 管理用户信息，处理用户注册、登录和个人信息管理
4. **预约服务**: 管理预约信息，处理预约的创建、修改和查询
5. **通知服务**: 管理通知信息，处理消息的发送和查询
6. **Common模块**: 公共模块，包含各服务共用的工具类和配置

## 数据库设计
- **user_db**: 用户数据库，存储用户相关信息
- **appointment_db**: 预约数据库，存储预约相关信息
- **notification_db**: 通知数据库，存储通知相关信息

## 开发环境搭建
1. JDK 17+
2. Maven 3.6+
3. MySQL 8.x
4. Redis

## 服务端口分配
- Eureka Server: 8761
- Gateway服务: 8080
- 用户服务: 8081
- 预约服务: 8082
- 通知服务: 8083

## 数据库连接信息
- IP: 123.60.186.10
- 端口: 3306
- 用户名: root
- 密码: hxp123

## 项目结构
```
medical-platform/
├── medical-eureka-server/        # Eureka服务注册中心
├── medical-common/               # 公共模块
├── medical-gateway/              # 网关服务
├── medical-user/                 # 用户服务
├── medical-appointment/          # 预约服务
├── medical-notification/         # 通知服务
└── pom.xml                       # 父POM文件
```

## 当前进度
- [x] 项目基础结构搭建
- [x] common模块开发完成
- [x] Eureka Server开发完成
- [x] Gateway服务开发完成
- [x] 开发指南文档编写
- [x] 使用指南文档编写
- [ ] 用户服务开发
- [ ] 预约服务开发
- [ ] 通知服务开发
- [ ] 系统集成测试

## 下一步开发计划
1. 完成用户服务的开发，包括用户注册、登录和个人信息管理
2. 完成预约服务的开发，包括预约创建、修改、查询和取消
3. 完成通知服务的开发，包括消息发送、查询和标记已读
4. 进行系统集成测试，确保各个服务之间的协作正常
5. 部署系统到测试环境，进行性能测试和功能验证
6. 根据测试结果进行优化和调整

## 文档说明
- **README.md**: 项目基本介绍和说明
- **DEVELOPMENT_GUIDE.md**: 开发指南，包含详细的开发规范和流程
- **USER_GUIDE.md**: 使用指南，包含系统功能和API接口说明 