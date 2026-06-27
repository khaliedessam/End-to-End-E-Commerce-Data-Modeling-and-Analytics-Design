/*
===================================================================================================
Stored Procedure: Load Silver Layer Tables
===================================================================================================
Script Purpose:
       This stored procedure loads cleaned and standardized data from the Bronze
       Layer into the Silver Layer using a full refresh strategy.

       The procedure transforms raw Bronze data by:
       - Removing duplicate records using ROW_NUMBER().
       - Filtering out records with missing business keys.
       - Standardizing text values using TRIM(), UPPER(), and LOWER().
       - Converting raw date and numeric values into proper data types.
       - Handling invalid values such as negative quantities, prices, salaries,
         and out-of-range ratings.
       - Calculating derived columns such as OrderDetail TotalAmount.

       Each Silver table is truncated before loading to ensure the layer always
       represents the latest cleaned version of the raw source data.

       The @run_id parameter links this Silver load to the main ETL pipeline
       execution for monitoring and traceability.

Usage:
       This procedure is executed by etl.run_pipeline after the Silver Layer
       has been loaded successfully.
===================================================================================================
*/

create or alter procedure silver.load_silver
         @run_id UNIQUEIDENTIFIER   as
 begin

TRUNCATE TABLE silver.Customer;
INSERT INTO silver.Customer (
CustomerID,
CustomerName,
Email,
Phone
)

select
        CustomerID,
        UPPER(TRIM(CustomerName)) as CustomerName,
        Email,
        CAST(CAST(Phone as FLOAT) as BIGINT) as Phone
from  ( select * , ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY CustomerID ) as RN 
         from bronze.Customer
          where CustomerID is not null )t
where RN = 1

-------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.CustomerAddress;
INSERT INTO silver.CustomerAddress (
AddressID,
CustomerID,
AddressType,
AddressLine1,
AddressLine2,
City
     )

select
      AddressID,
      CustomerID,
      ISNULL(AddressType,'N/A') as AddressType,
      AddressLine1,
      AddressLine2,
      UPPER(TRIM(City)) as City
from 
    ( select *,
             ROW_NUMBER() OVER (PARTITION BY AddressID ORDER BY AddressID) as RN
      from bronze.CustomerAddress 
      where AddressID is not null )t
WHERE RN = 1

-------------------------------------------------------------------------------------------------------------


TRUNCATE TABLE silver.Employee
INSERT INTO silver.Employee (
EmployeeID,
DepartmentID,
EmployeeName,
JobTitle,
HireDate,
Salary  )

select 
         EmployeeID,
         DepartmentID,
         EmployeeName,
         UPPER(TRIM(JobTitle)) as JobTitle,
         CAST(HireDate as date) as HireDate,
         abs(Salary) as Salary
from bronze.Employee

-------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.Inventory
INSERT INTO silver.Inventory (
WarehouseID,
ProductID,
Quantity )

select
         WarehouseID,
         ProductID,
         CASE WHEN Quantity < 0 THEN null
              ELSE Quantity
         END AS Quantity

from ( select *, ROW_NUMBER() OVER(PARTITION BY WarehouseID,ProductID ORDER BY WarehouseID,ProductID) as RN
        from bronze.Inventory
        where WarehouseID is not null and ProductID is not null )t
where RN = 1


-------------------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.Orders
INSERT INTO silver.Orders (
OrderID,
CustomerID,
ShippingAddressID,
ShippingCompanyID,
OrderDate,
OrderStatus,
TotalAmount )

select
          OrderID,
          CustomerID,
          ShippingAddressID,
          ShippingCompanyID,
          CASE WHEN TRY_CONVERT(date,OrderDate,101) > GETDATE() THEN CAST('2026-05-28' AS DATE)
               ELSE TRY_CONVERT(date,OrderDate,101)
          END AS OrderDate,
          lower(TRIM(OrderStatus)) as OrderStatus,
          TotalAmount
from ( select * , ROW_NUMBER() OVER (PARTITION BY OrderID ORDER BY OrderID) AS RN
       from bronze.Orders 
         where OrderID is not null )t
where RN = 1

-----------------------------------------------------------------------------------------

TRUNCATE TABLE silver.OrderDetail
INSERT INTO silver.OrderDetail (
OrderID,
ProductID,
Quantity,
PriceAtPurchase,
DiscountApplied,
TotalAmount )

select
              OrderID,
              ProductID,
              cast(cast(Quantity as decimal(10,2)) as int) as Quantity,
              PriceAtPurchase,
              DiscountApplied,
              (Quantity*PriceAtPurchase)-DiscountApplied as TotalAmount

from ( select * , ROW_NUMBER() OVER(PARTITION BY OrderID,ProductID ORDER BY OrderID,ProductID ) AS RN
                   from bronze.OrderDetail
                   where OrderID is not null and ProductID is not null )t
where  RN = 1

----------------------------------------------------------------------------------------
TRUNCATE TABLE silver.PaymentMethod
INSERT INTO silver.PaymentMethod (
PaymentMethodID,
MethodName )

select
              PaymentMethodID,
              MethodName

from ( select * , ROW_NUMBER() OVER(PARTITION BY PaymentMethodID ORDER BY PaymentMethodID) AS RN
          from bronze.PaymentMethod
          where PaymentMethodID is not null )t
where RN = 1
          
------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.PaymentTransaction
INSERT INTO silver.PaymentTransaction (
TransactionID,
OrderID,
PaymentMethodID,
PaymentDate,
PaidAmount,
PaymentStatus,
TransactionReferenceNumber)

select
          TransactionID,
          OrderID,
          PaymentMethodID,
          cast(PaymentDate as date) as PaymentDate,
          PaidAmount,
          UPPER(TRIM(PaymentStatus)) as PaymentStatus,
          lower(trim(TransactionReferenceNumber)) as TransactionReferenceNumber

from ( select * , ROW_NUMBER() OVER(PARTITION BY TransactionID ORDER BY TransactionID ) as RN 
                   from bronze.PaymentTransaction
                   where TransactionID is not null )t
where RN = 1

-------------------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.Product
INSERT INTO silver.Product (
ProductID,
DepartmentID,
ProductCode,
ProductName,
UnitPrice,
Brand,
ManufacturingDate )

select
         ProductID,
         DepartmentID,
         ProductCode,
         left(ProductName, len(ProductName) - CHARINDEX(' ',REVERSE(ProductName))) as ProductName,      
         CASE WHEN UnitPrice  <= 0 THEN null
              ELSE UnitPrice
         END AS UnitPrice,
         Brand,
         ManufacturingDate

from ( select * , ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY ProductID ) as RN 
                  from bronze.Product
             where ProductID is not null )t
where RN = 1

------------------------------------------------------------------------------------

TRUNCATE TABLE silver.ProductPromotion
INSERT INTO silver.ProductPromotion (
ProductID,
PromotionID )

select
          ProductID,
          PromotionID
from ( select *, ROW_NUMBER() OVER(PARTITION BY ProductID , PromotionID ORDER BY ProductID , PromotionID) as RN
                          from bronze.ProductPromotion
                          where ProductID is not null  and PromotionID is not null )t
where RN = 1

---------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.Supplier
INSERT INTO silver.Supplier (
SupplierID,
SupplierName,
Phone,
City )

select
          SupplierID,
          SupplierName,
          Phone,
          City
from bronze.Supplier

-----------------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.ProductSupplier
INSERT INTO silver.ProductSupplier (
ProductID,
SupplierID,
Availability,
AgreementPrice )

select
              ProductID,
              SupplierID,
              Availability,
    CASE WHEN AgreementPrice < 0 THEN null
         ELSE AgreementPrice
    END AS AgreementPrice 

from ( select * , ROW_NUMBER() OVER(PARTITION BY ProductID,SupplierID ORDER BY ProductID,SupplierID ) as RN 
                      from bronze.ProductSupplier
                        where ProductID is not null and SupplierID is not null )t
where RN = 1


-----------------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.Promotion
INSERT INTO silver.Promotion (
PromotionID,
PromotionCode,
PromotionName,
DiscountPercentage,
StartDate,
EndDate )

select
                PromotionID,
                PromotionCode,
                PromotionName,
CASE WHEN  CAST(DiscountPercentage AS INT) > 100 THEN 70
          ELSE DiscountPercentage
 END AS DiscountPercentage,
                StartDate,
                EndDate 
from bronze.Promotion
where PromotionID is not null

---------------------------------------------------------------------------
TRUNCATE TABLE silver.Review
INSERT INTO silver.Review (
CustomerID,
ProductID,
Rating,
Comment,
ReviewDate )

select
              CustomerID,
              ProductID,
    CASE WHEN Rating > 5 THEN 5
         WHEN Rating < 0 THEN 0 
         ELSE Rating
         END AS Rating,
              Comment,
              ReviewDate
from bronze.Review

---------------------------------------------------------------------------------------
TRUNCATE TABLE silver.ShippingCompany
INSERT INTO silver.ShippingCompany (
ShippingCompanyID,
CompanyName)

select        
           ShippingCompanyID,
           CompanyName
from bronze.ShippingCompany
----------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.Warehouse
INSERT INTO silver.Warehouse (
WarehouseID,
WarehouseName,
City,
Country )

select
        WarehouseID,
        WarehouseName,
        City,
        Country
from ( select * , ROW_NUMBER() OVER(PARTITION BY WarehouseID ORDER BY WarehouseID ) as RN 
                      from bronze.Warehouse
                        where WarehouseID is not null )t
where RN = 1

------------------------------------------------------------------------------------------------------------------
TRUNCATE TABLE silver.Department
INSERT INTO silver.Department (
DepartmentID,
DepartmentName )

select
        DepartmentID,
        DepartmentName
from bronze.Department

end

----Excecute Stored Procedure For Bronze Layer
DECLARE @run_id UNIQUEIDENTIFIER = NEWID();

EXEC silver.load_silver @run_id;