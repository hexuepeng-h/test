# 医疗平台微服务架构开发指南

## 项目概述
该项目是一个基于Spring Cloud的微服务架构的医疗平台系统，用于管理用户、预约和通知等功能，采用Eureka作为服务注册与发现中心。

## 技术栈
- **Spring Boot 3.0.2**: 基础框架
- **Spring Cloud**: 微服务框架
- **Spring Cloud Gateway**: API网关
- **Spring Cloud Netflix Eureka**: 服务注册与发现
- **MyBatis-Plus**: ORM框架
- **MySQL 8.x**: 数据库
- **Redis**: 缓存
- **Spring Security + JWT**: 安全认证
- **Knife4j**: API文档
- **Maven**: 项目构建管理

## 系统架构

```
          ┌─────────────┐
          │    客户端    │
          └──────┬──────┘
                 │
                 ▼
          ┌─────────────┐
          │  API网关    │
          │ (Gateway)   │
          └──────┬──────┘
                 │
         ┌───────┴──────────────┐
         │                      │
  ┌──────▼─────┐      ┌─────────▼──────┐      ┌──────────────────┐
  │  用户服务   │      │   预约服务      │      │    通知服务       │
  │  (User)    │      │ (Appointment) │      │ (Notification)   │
  └──────┬─────┘      └──────┬────────┘      └─────────┬────────┘
         │                   │                         │
  ┌──────▼─────┐      ┌──────▼────────┐      ┌─────────▼────────┐
  │  user_db   │      │ appointment_db │      │ notification_db  │
  └────────────┘      └───────────────┘      └──────────────────┘
```

## 服务模块说明

### 1. Eureka Server
- **功能**: 服务注册与发现中心
- **端口**: 8761
- **特点**: 简单易用、可靠性高

### 2. 网关服务 (Gateway)
- **功能**: 请求路由、统一认证、跨域处理
- **端口**: 8080
- **对外路径**:
  - `/api/user/**`: 路由到用户服务
  - `/api/appointment/**`: 路由到预约服务
  - `/api/notification/**`: 路由到通知服务

### 3. 用户服务 (User)
- **功能**: 用户管理、认证授权
- **端口**: 8081
- **数据库**: user_db
- **核心接口**:
  - 用户注册: POST `/user/register`
  - 用户登录: POST `/user/login`
  - 获取用户信息: GET `/user/info`
  - 更新用户信息: PUT `/user/info`

### 4. 预约服务 (Appointment)
- **功能**: 预约管理
- **端口**: 8082
- **数据库**: appointment_db
- **核心接口**:
  - 创建预约: POST `/appointment`
  - 获取预约列表: GET `/appointment/list`
  - 获取预约详情: GET `/appointment/{id}`
  - 更新预约状态: PUT `/appointment/{id}/status`
  - 取消预约: DELETE `/appointment/{id}`

### 5. 通知服务 (Notification)
- **功能**: 消息通知管理
- **端口**: 8083
- **数据库**: notification_db
- **核心接口**:
  - 发送通知: POST `/notification/send`
  - 获取通知列表: GET `/notification/list`
  - 已读通知: PUT `/notification/{id}/read`
  - 删除通知: DELETE `/notification/{id}`

### 6. 公共模块 (Common)
- **功能**: 共享的工具类、实体类、异常处理等
- **主要组件**:
  - 统一响应对象
  - 全局异常处理
  - JWT工具类
  - 其他通用工具

## 项目结构
```
medical-platform/
├── medical-eureka-server/                # Eureka服务注册中心
│   ├── src/main/java/com/medical/eureka/
│   │   └── EurekaServerApplication.java  # Eureka服务主类
│   ├── src/main/resources/
│   │   └── application.yml               # Eureka服务配置
│   └── pom.xml                           # Eureka服务POM
│
├── medical-common/                       # 公共模块
│   ├── src/main/java/com/medical/common/
│   │   ├── config/                       # 通用配置
│   │   ├── exception/                    # 异常处理
│   │   │   ├── BusinessException.java    # 业务异常
│   │   │   └── GlobalExceptionHandler.java # 全局异常处理
│   │   ├── response/                     # 响应处理
│   │   │   ├── Result.java               # 统一响应对象
│   │   │   └── ResultCode.java           # 响应状态码
│   │   └── utils/                        # 工具类
│   │       └── JwtUtil.java              # JWT工具类
│   └── pom.xml                           # Common模块POM
│
├── medical-gateway/                      # 网关服务
│   ├── src/main/java/com/medical/gateway/
│   │   ├── config/                       # 配置类
│   │   │   ├── CorsConfig.java           # 跨域配置
│   │   │   ├── EurekaConfig.java         # Eureka配置
│   │   │   └── RouteConfig.java          # 路由配置
│   │   ├── filter/                       # 过滤器
│   │   │   ├── AuthFilter.java           # 认证过滤器
│   │   │   └── LoggingFilter.java        # 日志过滤器
│   │   └── GatewayApplication.java       # 网关服务主类
│   ├── src/main/resources/
│   │   ├── application.yml               # 应用配置
│   │   └── bootstrap.yml                 # 引导配置
│   └── pom.xml                           # Gateway模块POM
│
├── medical-user/                         # 用户服务(待创建)
│
├── medical-appointment/                  # 预约服务(待创建)
│
├── medical-notification/                 # 通知服务(待创建)
│
├── pom.xml                               # 父POM
└── README.md                             # 项目说明
```

## 如何启动项目

### 1. 环境准备
- JDK 17+
- Maven 3.6+
- MySQL 8.x
- Redis

### 2. 数据库准备
- 创建三个数据库: `user_db`, `appointment_db`, `notification_db`
- 数据库连接信息:
  - IP: 123.60.186.10
  - 端口: 3306
  - 用户名: root
  - 密码: hxp123

### 3. 启动服务
按照以下顺序启动各个服务:
1. Eureka Server: `medical-eureka-server`
   ```bash
   cd medical-eureka-server
   mvn spring-boot:run
   ```

2. 网关服务: `medical-gateway`
   ```bash
   cd medical-gateway
   mvn spring-boot:run
   ```

3. 用户服务: `medical-user` (待创建)
   ```bash
   cd medical-user
   mvn spring-boot:run
   ```

4. 预约服务: `medical-appointment` (待创建)
   ```bash
   cd medical-appointment
   mvn spring-boot:run
   ```

5. 通知服务: `medical-notification` (待创建)
   ```bash
   cd medical-notification
   mvn spring-boot:run
   ```

### 4. 验证服务
- 访问Eureka控制台: http://localhost:8761
- 访问网关: http://localhost:8080

## 开发指南

### 模块依赖关系
- **所有服务模块依赖common模块**
- Gateway不依赖于其他服务模块
- 业务服务模块之间可能存在服务调用关系

### API设计规范
- 遵循RESTful API设计规范
- 使用HTTP状态码表示请求结果
- 统一响应格式:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {}
  }
  ```

### 异常处理
- 使用全局异常处理器捕获异常
- 业务逻辑异常使用BusinessException
- 返回统一的错误响应格式

### 安全认证
- 基于JWT的认证机制
- 网关层统一认证
- 白名单路径无需认证

### 服务间通信
- 使用OpenFeign进行服务间调用
- 服务注册与发现通过Eureka实现
- 服务间调用传递用户上下文信息

## 后续开发计划
1. 用户服务开发
2. 预约服务开发
3. 通知服务开发
4. 服务间通信实现
5. 系统集成测试
6. 部署与上线

## 常见问题

### 启动问题
- 端口被占用: 修改配置文件中的端口号
- 数据库连接失败: 检查数据库连接信息
- Eureka连接失败: 检查Eureka服务是否正常运行

### 开发问题
- 服务注册失败: 检查Eureka配置和网络连接
- 服务调用失败: 检查服务名称、路径和认证信息
- 跨域问题: 网关已配置CORS，若仍有问题检查前端请求配置 