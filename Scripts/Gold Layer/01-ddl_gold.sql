/*
===================================================================================================
DDL Script: Create Gold Layer Tables
===================================================================================================
Script Purpose:
       This script creates the physical tables for the Gold Layer in the data warehouse.

       The Gold Layer represents the final business-ready Star Schema designed for 
       analytical reporting and business intelligence. It contains dimension tables 
       with surrogate keys and a fact table that stores sales transactions at the 
       defined business grain.

       In this script:
       - Dimension tables are created to store descriptive business entities such as
         customers, products, dates, payment methods, shipping companies, and customer 
         addresses.
       - Surrogate keys are created for dimensions to provide stable relationships
         between dimensions and the fact table.
       - The Customer Address dimension is designed to support Slowly Changing 
         Dimension (SCD) Type 2 historical tracking.
       - The grain of factSales is one row per product inside an order.

Usage:
       - Execute this script during the database deployment phase to create the
         Gold Layer schema objects.
===================================================================================================
*/


IF OBJECT_ID('gold.dim_customer','U') IS NOT NULL
    DROP TABLE gold.dim_customer;
CREATE TABLE gold.dim_customer (
    Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(50) )





IF OBJECT_ID('gold.dim_CustomerAddress','U') IS NOT NULL
   DROP TABLE gold.dim_CustomerAddress
GO

  CREATE TABLE gold.dim_CustomerAddress (
   Address_Key INT IDENTITY(1,1) PRIMARY KEY,
   AddressID INT NOT NULL,
   CustomerID INT,
   AddressType VARCHAR(100),
   AddressLine1 VARCHAR(100),
   AddressLine2 VARCHAR(100),
   City VARCHAR(100),
   START_DATE DATETIME2 NOT NULL,
   END_DATE DATETIME2  NULL,
   Is_Current BIT NOT NULL )

  

IF OBJECT_ID('gold.dim_product','U') IS NOT NULL
   DROP TABLE gold.dim_product
GO

CREATE TABLE gold.dim_product (
    Product_Key INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    DepartmentID INT,
    DepartmentName VARCHAR(100),
    ProductCode VARCHAR(50),
    ProductName VARCHAR(255),
    UnitPrice DECIMAL(10,2),
    Brand VARCHAR(100),
    ManufacturingDate DATE
);




IF OBJECT_ID ('gold.dim_date' , 'U') IS NOT NULL
   DROP TABLE gold.dim_date
GO

CREATE TABLE gold.dim_date (
    DateKey INT,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    MonthName VARCHAR(20),
    WeekdayName VARCHAR(20),
    Quarter INT,
    IsWeekend BIT  )





IF OBJECT_ID ('gold.dim_PaymentMethod' , 'U') IS NOT NULL
   DROP TABLE gold.dim_PaymentMethod
GO

CREATE TABLE gold.dim_PaymentMethod (
    PaymentMethod_Key INT IDENTITY(1,1) PRIMARY KEY,
    PaymentMethodID INT,
    MethodName VARCHAR(100)
);




IF OBJECT_ID ('gold.dim_ShippingCompany' , 'U') IS NOT NULL
   DROP TABLE gold.dim_ShippingCompany
GO
CREATE TABLE gold.dim_ShippingCompany (
    Shipping_Key INT IDENTITY(1,1) PRIMARY KEY,
    ShippingCompanyID INT,
    CompanyName VARCHAR(100)
);



---The grain of factSales is one row per product inside an order.
IF OBJECT_ID ('gold.fact_sales' , 'U') IS NOT NULL
   DROP TABLE gold.fact_sales
GO

CREATE TABLE gold.fact_sales (
    Customer_Key INT,
    Address_Key INT,
    Product_Key INT,
    PaymentMethod_Key INT,
    Shipping_Key INT,
    DateKey INT,
    OrderID INT,
    OrderStatus VARCHAR(50),
    Quantity INT,
    PriceAtPurchase DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2),
    NetAmount DECIMAL(18,2),
    PaymentStatus VARCHAR(50)
);


