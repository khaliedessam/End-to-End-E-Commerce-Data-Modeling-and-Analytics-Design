/*======================================================================
DDL Script: Create Silver Tables
======================================================================
Script Purpose:
This Script creates tables in the 'silver schema',dropping existing tables 
if they already exist.
Run this script to re-define the DDL structure of 'silver' Tables 
======================================================================*/

IF OBJECT_ID('silver.Customer','U') IS NOT NULL
   DROP TABLE silver.Customer
CREATE TABLE silver.Customer (
    CustomerID INT,
    CustomerName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(50),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.CustomerAddress','U') IS NOT NULL
   DROP TABLE silver.CustomerAddress
CREATE TABLE silver.CustomerAddress (
    AddressID INT,
    CustomerID INT,
    AddressType VARCHAR(50),
    AddressLine1 VARCHAR(255),
    AddressLine2 VARCHAR(255),
    City VARCHAR(50),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Department','U') IS NOT NULL
   DROP TABLE silver.Department
CREATE TABLE silver.Department (
    DepartmentID INT,
    DepartmentName VARCHAR(50),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Product','U') IS NOT NULL
   DROP TABLE silver.Product
CREATE TABLE silver.Product (
    ProductID INT,
    DepartmentID INT,
    ProductCode VARCHAR(50),
    ProductName VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Brand VARCHAR(100),
    ManufacturingDate DATE,
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Supplier','U') IS NOT NULL
   DROP TABLE silver.Supplier 
CREATE TABLE silver.Supplier (
    SupplierID INT,
    SupplierName VARCHAR(100),
    Phone VARCHAR(100),
    City VARCHAR(100),
    dwh_create_date DATETIME2 Default GETDATE()
);



IF OBJECT_ID('silver.ProductSupplier','U') IS NOT NULL
   DROP TABLE silver.ProductSupplier
CREATE TABLE silver.ProductSupplier (
    ProductID INT,
    SupplierID INT,
    Availability VARCHAR(50),
    AgreementPrice DECIMAL(10,2),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Orders','U') IS NOT NULL
   DROP TABLE silver.Orders
CREATE TABLE silver.Orders (
    OrderID INT,
    CustomerID INT,
    ShippingAddressID INT,
    ShippingCompanyID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(100),
    TotalAmount DECIMAL(10,2),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.OrderDetail','U') IS NOT NULL
   DROP TABLE silver.OrderDetail
CREATE TABLE silver.OrderDetail (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PriceAtPurchase DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.PaymentMethod','U') IS NOT NULL
    DROP TABLE silver.PaymentMethod
CREATE TABLE silver.PaymentMethod (
    PaymentMethodID INT,
    MethodName VARCHAR(100),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.PaymentTransaction','U') IS NOT NULL
   DROP TABLE silver.PaymentTransaction
CREATE TABLE silver.PaymentTransaction (
    TransactionID INT,
    OrderID INT,
    PaymentMethodID INT,
    PaymentDate DATE,
    PaidAmount DECIMAL(10,2),
    PaymentStatus VARCHAR(100),
    TransactionReferenceNumber VARCHAR(255),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.ShippingCompany','U') IS NOT NULL
   DROP TABLE silver.ShippingCompany
CREATE TABLE silver.ShippingCompany (
    ShippingCompanyID INT,
    CompanyName VARCHAR(255),
    dwh_create_date DATETIME2 Default GETDATE()
    
);


IF OBJECT_ID('silver.Promotion','U') IS NOT NULL
   DROP TABLE silver.Promotion
CREATE TABLE silver.Promotion (
    PromotionID INT,
    PromotionCode VARCHAR(255),
    PromotionName VARCHAR(255),
    DiscountPercentage DECIMAL(10,2),
    StartDate DATE,
    EndDate DATE,
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.ProductPromotion','U') IS NOT NULL
   DROP TABLE silver.ProductPromotion
CREATE TABLE silver.ProductPromotion (
    ProductID INT,
    PromotionID INT,
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Review','U') IS NOT NULL
   DROP TABLE silver.Review
CREATE TABLE silver.Review (
    CustomerID INT,
    ProductID INT,
    Rating INT,
    Comment VARCHAR(500),
    ReviewDate DATE,
    dwh_create_date DATETIME2 Default GETDATE()
);



IF OBJECT_ID('silver.Employee','U') IS NOT NULL
   DROP TABLE silver.Employee
CREATE TABLE silver.Employee (
    EmployeeID INT,
    DepartmentID INT,
    EmployeeName VARCHAR(255),
    JobTitle VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(10,2),
    dwh_create_date DATETIME2 Default GETDATE()
);


IF OBJECT_ID('silver.Warehouse','U') IS NOT NULL
   DROP TABLE silver.Warehouse
CREATE TABLE silver.Warehouse (
    WarehouseID INT,
    WarehouseName VARCHAR(50),
    City VARCHAR(50),
    Country VARCHAR(50),
    dwh_create_date DATETIME2 Default GETDATE()
);



IF OBJECT_ID('silver.Inventory','U') IS NOT NULL
   DROP TABLE silver.Inventory
CREATE TABLE silver.Inventory (
    WarehouseID INT,
    ProductID INT,
    Quantity INT,
    dwh_create_date DATETIME2 Default GETDATE()
);



