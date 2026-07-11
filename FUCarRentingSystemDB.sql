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
CREATE TABLE Account (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,          
    Password VARCHAR(255) NOT NULL,              
    AccountName NVARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,                   
    Status INT NOT NULL DEFAULT 1                
);

-- Bảng Hồ sơ Khách hàng (Liên kết 1-1 với Account)
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL UNIQUE,               
    CustomerName NVARCHAR(150) NOT NULL,
    Mobile VARCHAR(15) NOT NULL,
    Birthday DATE NOT NULL,
    IdentityCard VARCHAR(20) NOT NULL,
    LicenceNumber VARCHAR(20) NOT NULL,
    LicenceDate DATE NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID) ON DELETE CASCADE
);

-- Bảng Nhà sản xuất xe
CREATE TABLE CarProducer (
    ProducerID INT IDENTITY(1,1) PRIMARY KEY,
    ProducerName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    Country NVARCHAR(100) NOT NULL
);

-- Bảng Thông tin Xe
CREATE TABLE Car (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    CarName NVARCHAR(100) NOT NULL,
    CarModelYear INT NOT NULL,
    Color NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    ImportDate DATE NOT NULL,
    ProducerID INT NOT NULL,
    RentPrice DECIMAL(18,2) NOT NULL,            
    Status INT NOT NULL DEFAULT 1,               
    FOREIGN KEY (ProducerID) REFERENCES CarProducer(ProducerID)
);

-- Bảng Đơn hàng Thuê xe (Master - Lưu tổng quan đơn hàng)
CREATE TABLE RentOrder (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalPrice DECIMAL(18,2) NOT NULL DEFAULT 0,
    Status INT NOT NULL DEFAULT 1,               
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Bảng Chi tiết Thuê xe (Detail - Lưu từng xe trong giỏ hàng)
CREATE TABLE RentOrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    CarID INT NOT NULL,
    PickupDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    RentPrice DECIMAL(18,2) NOT NULL,            
    Status INT NOT NULL DEFAULT 1,
    FOREIGN KEY (OrderID) REFERENCES RentOrder(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    CONSTRAINT CHK_RentalDates CHECK (PickupDate <= ReturnDate)
);

-- Bảng Đánh giá của khách hàng
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CarID INT NOT NULL,
    ReviewStar INT NOT NULL CHECK (ReviewStar BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
GO