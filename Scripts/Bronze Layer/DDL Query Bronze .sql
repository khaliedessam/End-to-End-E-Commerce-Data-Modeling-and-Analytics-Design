/*
======================================================================
DDL Script: Create Bronze Tables
======================================================================
Script Purpose:
This Script creates tables in the 'bronze schema',dropping existing tables 
if they already exist.
Run this script to re-define the DDL structure of 'bronze' Tables 
======================================================================
*/


-------Table Creations----------------
IF OBJECT_ID('bronze.Customer','U') IS NOT NULL
   DROP TABLE bronze.Customer
CREATE TABLE bronze.Customer (
    CustomerID INT,
    CustomerName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(50)
);


IF OBJECT_ID('bronze.CustomerAddress','U') IS NOT NULL
   DROP TABLE bronze.CustomerAddress
CREATE TABLE bronze.CustomerAddress (
    AddressID INT,
    CustomerID INT,
    AddressType VARCHAR(50),
    AddressLine1 VARCHAR(255),
    AddressLine2 VARCHAR(255),   
    City VARCHAR(50)
);


IF OBJECT_ID('bronze.Department','U') IS NOT NULL
   DROP TABLE bronze.Department
CREATE TABLE bronze.Department (
    DepartmentID INT,
    DepartmentName VARCHAR(50)
);


IF OBJECT_ID('bronze.Product','U') IS NOT NULL
   DROP TABLE bronze.Product
CREATE TABLE bronze.Product (
    ProductID INT,
    DepartmentID INT,
    ProductCode VARCHAR(50),
    ProductName VARCHAR(50),
    Description VARCHAR(200),
    UnitPrice DECIMAL(10,2),
    Brand VARCHAR(100),
    ManufacturingDate DATE
);


IF OBJECT_ID('bronze.Supplier','U') IS NOT NULL
   DROP TABLE bronze.Supplier
CREATE TABLE bronze.Supplier (
    SupplierID INT,
    SupplierName VARCHAR(50),
    Phone VARCHAR(50),
    City VARCHAR(50)
);



IF OBJECT_ID('bronze.ProductSupplier','U') IS NOT NULL
   DROP TABLE bronze.ProductSupplier
CREATE TABLE bronze.ProductSupplier (
    ProductID INT,
    SupplierID VARCHAR(50),
    Availability VARCHAR(50),
    AgreementPrice DECIMAL(10,2)
);


IF OBJECT_ID('bronze.Orders','U') IS NOT NULL
   DROP TABLE bronze.Orders
CREATE TABLE bronze.Orders (
    OrderID INT,
    CustomerID INT,
    ShippingAddressID INT,
    ShippingCompanyID INT,
    OrderDate VARCHAR(50),
    OrderStatus VARCHAR(50),
    TotalAmount DECIMAL(10,2)
);


IF OBJECT_ID('bronze.OrderDetail','U') IS NOT NULL
   DROP TABLE bronze.OrderDetail 
CREATE TABLE bronze.OrderDetail (
    OrderID INT,
    ProductID INT,
    Quantity VARCHAR(50),
    PriceAtPurchase DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2)
);


IF OBJECT_ID('bronze.PaymentMethod','U') IS NOT NULL
   DROP TABLE bronze.PaymentMethod
CREATE TABLE bronze.PaymentMethod (
    PaymentMethodID VARCHAR(50),
    MethodName VARCHAR(100)
);


IF OBJECT_ID('bronze.PaymentTransaction','U') IS NOT NULL
   DROP TABLE  bronze.PaymentTransaction
CREATE TABLE bronze.PaymentTransaction (
    TransactionID INT,
    OrderID INT,
    PaymentMethodID INT,
    PaymentDate DATE,
    PaidAmount VARCHAR(50),
    PaymentStatus VARCHAR(100),
    TransactionReferenceNumber VARCHAR(255)
);


IF OBJECT_ID('bronze.ShippingCompany','U') IS NOT NULL
   DROP TABLE bronze.ShippingCompany
CREATE TABLE bronze.ShippingCompany (
    ShippingCompanyID INT,
    CompanyName VARCHAR(255),
    
);


IF OBJECT_ID('bronze.Promotion','U') IS NOT NULL
   DROP TABLE bronze.Promotion
CREATE TABLE bronze.Promotion (
    PromotionID INT,
    PromotionCode VARCHAR(255),
    PromotionName VARCHAR(255),
    DiscountPercentage VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
);


IF OBJECT_ID('bronze.ProductPromotion','U') IS NOT NULL
   DROP TABLE bronze.ProductPromotion
CREATE TABLE bronze.ProductPromotion (
    ProductID INT,
    PromotionID INT
);


IF OBJECT_ID('bronze.Review','U') IS NOT NULL
   DROP TABLE bronze.Review
CREATE TABLE bronze.Review (
    CustomerID INT,
    ProductID INT,
    Rating VARCHAR(50),
    Comment VARCHAR(500),
    ReviewDate DATE
);



IF OBJECT_ID('bronze.Employee','U') IS NOT NULL
   DROP TABLE bronze.Employee
CREATE TABLE bronze.Employee (
    EmployeeID INT,
    DepartmentID INT,
    EmployeeName VARCHAR(255),
    JobTitle VARCHAR(100),
    HireDate VARCHAR(50),
    Salary VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50)
);


IF OBJECT_ID('bronze.Warehouse','U') IS NOT NULL
   DROP TABLE bronze.Warehouse
CREATE TABLE bronze.Warehouse (
    WarehouseID INT,
    WarehouseName VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50)
);



IF OBJECT_ID('bronze.Inventory','U') IS NOT NULL
   DROP TABLE bronze.Inventory
CREATE TABLE bronze.Inventory (
    WarehouseID INT,
    ProductID VARCHAR(50),
    Quantity VARCHAR(50)
);


