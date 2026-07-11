-- ==============================================================================
-- 1. XÓA DATABASE CŨ (NẾU TỒN TẠI) & NGẮT KẾT NỐI
-- ==============================================================================
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FUCarRentingSystemDB')
BEGIN
    -- Ép ngắt tất cả các kết nối đang truy cập vào DB và Rollback transaction
    ALTER DATABASE FUCarRentingSystemDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Xóa DB sau khi đã an toàn
    DROP DATABASE FUCarRentingSystemDB;
END;
GO

-- ==============================================================================
-- 2. TẠO MỚI DATABASE
-- ==============================================================================
CREATE DATABASE FUCarRentingSystemDB;
GO

USE FUCarRentingSystemDB;
GO

-- ==============================================================================
-- 3. TẠO CẤU TRÚC CÁC BẢNG (TABLES)
-- ==============================================================================

-- Bảng Hệ thống Tài khoản (Quản lý Đăng nhập & Phân quyền)
CREATE TABLE accounts (
    account_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,          
    password VARCHAR(255) NOT NULL,              
    account_name NVARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,                   
    status INT NOT NULL DEFAULT 1                
);

-- Bảng Hồ sơ Khách hàng (Liên kết 1-1 với Account)
CREATE TABLE customers (
    customer_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    account_id BIGINT NOT NULL UNIQUE,               
    customer_name NVARCHAR(150) NOT NULL,
    mobile VARCHAR(15) NOT NULL,
    birthday DATE NOT NULL,
    identity_card VARCHAR(20) NOT NULL,
    licence_number VARCHAR(20) NOT NULL,
    licence_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- Bảng Nhà sản xuất xe
CREATE TABLE car_producers (
    producer_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    producer_name NVARCHAR(100) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    country NVARCHAR(100) NOT NULL
);

-- Bảng Thông tin Xe
CREATE TABLE cars (
    car_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    car_name NVARCHAR(100) NOT NULL,
    car_model_year INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    import_date DATE NOT NULL,
    producer_id BIGINT NOT NULL,
    rent_price DECIMAL(18,2) NOT NULL,            
    status INT NOT NULL DEFAULT 1,               
    FOREIGN KEY (producer_id) REFERENCES car_producers(producer_id)
);

-- Bảng Đơn hàng Thuê xe (Master - Lưu tổng quan đơn hàng)
CREATE TABLE rent_orders (
    order_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    total_price DECIMAL(18,2) NOT NULL DEFAULT 0,
    status INT NOT NULL DEFAULT 1,               
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Bảng Chi tiết Thuê xe (Detail - Lưu từng xe trong giỏ hàng)
CREATE TABLE rent_order_details (
    order_detail_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id BIGINT NOT NULL,
    car_id BIGINT NOT NULL,
    pickup_date DATE NOT NULL,
    return_date DATE NOT NULL,
    rent_price DECIMAL(18,2) NOT NULL,            
    status INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES rent_orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    CONSTRAINT CHK_RentalDates CHECK (pickup_date <= return_date)
);

-- Bảng Đánh giá của khách hàng
CREATE TABLE reviews (
    review_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    car_id BIGINT NOT NULL,
    review_star INT NOT NULL CHECK (review_star BETWEEN 1 AND 5),
    comment NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (car_id) REFERENCES cars(car_id)
);
GO