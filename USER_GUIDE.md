# 医疗平台微服务系统使用指南

## 系统概述
医疗平台微服务系统是一个基于Spring Cloud开发的医疗服务平台，集成了用户管理、预约管理和通知管理等功能，为医疗服务提供了完整的技术支持。

## 系统功能

### 1. 用户管理
- 用户注册：新用户可以进行账号注册
- 用户登录：已注册用户可以登录系统
- 个人信息管理：用户可以查看和修改个人信息
- 权限控制：区分普通用户和医生用户

### 2. 预约管理
- 创建预约：用户可以选择医生和时间段进行预约
- 预约查询：用户可以查看自己的预约记录
- 预约修改：用户可以修改尚未确认的预约
- 预约取消：用户可以取消未完成的预约
- 预约确认：医生可以确认预约请求

### 3. 通知管理
- 系统通知：系统可以向用户发送通知消息
- 消息查看：用户可以查看收到的通知
- 已读标记：用户可以将通知标记为已读
- 消息删除：用户可以删除不需要的通知

## 系统部署

### 环境要求
- JDK 17+
- Maven 3.6+
- MySQL 8.x
- Redis (可选)
- Eureka (内置在项目中)

### 部署步骤

1. **准备数据库**
   - 创建三个数据库:
     ```sql
     CREATE DATABASE user_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
     CREATE DATABASE appointment_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
     CREATE DATABASE notification_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
     ```

2. **编译项目**
   ```bash
   cd medical-platform
   mvn clean package -DskipTests
   ```

3. **启动服务**
   按照以下顺序启动各个服务:
   ```bash
   # 启动Eureka服务器
   java -jar medical-eureka-server/target/medical-eureka-server-1.0-SNAPSHOT.jar
   
   # 启动网关服务
   java -jar medical-gateway/target/medical-gateway-1.0-SNAPSHOT.jar
   
   # 启动用户服务
   java -jar medical-user/target/medical-user-1.0-SNAPSHOT.jar
   
   # 启动预约服务
   java -jar medical-appointment/target/medical-appointment-1.0-SNAPSHOT.jar
   
   # 启动通知服务
   java -jar medical-notification/target/medical-notification-1.0-SNAPSHOT.jar
   ```

4. **验证部署**
   - 访问Eureka管理控制台: http://localhost:8761
   - 访问网关: http://localhost:8080
   - 访问API文档: http://localhost:8080/doc.html (如已配置Knife4j)

## API接口使用

### 认证接口
所有需要认证的API都需要在请求头中携带JWT令牌:
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 用户服务接口
- **用户注册**: `POST /api/user/register`
  ```json
  {
    "username": "test_user",
    "password": "password123",
    "email": "test@example.com",
    "phone": "13800138000",
    "realName": "张三"
  }
  ```

- **用户登录**: `POST /api/user/login`
  ```json
  {
    "username": "test_user",
    "password": "password123"
  }
  ```
  
- **获取用户信息**: `GET /api/user/info`

- **更新用户信息**: `PUT /api/user/info`
  ```json
  {
    "email": "new_email@example.com",
    "phone": "13900139000",
    "realName": "李四"
  }
  ```

### 预约服务接口
- **创建预约**: `POST /api/appointment`
  ```json
  {
    "doctorId": 1,
    "appointmentTime": "2023-09-15T10:00:00",
    "description": "头痛，需要检查"
  }
  ```

- **获取预约列表**: `GET /api/appointment/list`

- **获取预约详情**: `GET /api/appointment/{id}`

- **更新预约状态**: `PUT /api/appointment/{id}/status`
  ```json
  {
    "status": "CONFIRMED"
  }
  ```

- **取消预约**: `DELETE /api/appointment/{id}`

### 通知服务接口
- **发送通知**: `POST /api/notification/send`
  ```json
  {
    "userId": 1,
    "title": "预约确认通知",
    "content": "您的预约已被确认",
    "type": "APPOINTMENT"
  }
  ```

- **获取通知列表**: `GET /api/notification/list`

- **标记通知为已读**: `PUT /api/notification/{id}/read`

- **删除通知**: `DELETE /api/notification/{id}`

## 常见问题与解决方案

### 1. 无法连接服务
- 检查服务是否启动成功
- 检查网关配置是否正确
- 确认请求路径是否正确

### 2. 认证失败
- 确认JWT令牌是否有效
- 检查令牌格式是否正确
- 验证令牌是否过期

### 3. 数据库连接失败
- 检查数据库服务是否运行
- 验证数据库连接信息是否正确
- 确认数据库用户权限是否足够

### 4. 服务注册失败
- 检查Eureka服务是否正常运行
- 验证服务配置中的Eureka地址是否正确
- 确认网络连接是否正常

## 联系支持
如有任何使用问题，请联系系统管理员或开发团队获取支持。 