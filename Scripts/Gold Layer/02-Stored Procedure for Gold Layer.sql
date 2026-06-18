/*
===================================================================================================
Stored Procedure: Load Gold Layer Tables
===================================================================================================
Script Purpose:
       This stored procedure loads the Gold Layer of the data warehouse using a
       full refresh strategy. It extracts cleaned data from the Silver Layer,
       applies required business transformations, and populates the final Star
       Schema tables for analytical reporting.

       In this procedure:
       - Dimension tables are refreshed and loaded before the Fact table.
       - Product data is enriched with department information.
       - The Date Dimension is generated to support time-based analysis.
       - The Sales Fact table is populated using Orders, Order Details,
         Payment Transactions, and Gold dimension keys.

Usage:
       Execute the procedure to refresh the Gold Layer before consuming the
       data through Power BI or other reporting tools.
===================================================================================================
*/

CREATE OR ALTER PROCEDURE gold.load_gold AS 
begin

print '>> Inserting Data Into: gold.dim_customer';

TRUNCATE TABLE gold.dim_customer;
INSERT INTO gold.dim_customer (
    CustomerID,
    CustomerName,
    Email,
    Phone )
SELECT
    CustomerID,
    CustomerName,
    Email,
    Phone 
FROM silver.Customer;

----------------------------------------------------------------

print '>> Inserting Data Into: gold.dim_CustomerAddress';

TRUNCATE TABLE gold.dim_CustomerAddress;
INSERT INTO gold.dim_CustomerAddress (
  AddressID,
  CustomerID,
  AddressType,
  AddressLine1,
  AddressLine2,
  City,
  START_DATE,
  END_DATE,
  Is_Current )

  SELECT 
          AddressID,
          CustomerID,
          AddressType,
          AddressLine1,
          AddressLine2,
          City,
          '2020-01-01'as START_DATE,
          NULL as END_DATE,
          1 as Is_Current
FROM Silver.CustomerAddress

------------------------------------------------------------------
print '>> Inserting Data Into: gold.dim_product';

TRUNCATE TABLE gold.dim_product;
INSERT INTO gold.dim_product
SELECT
    p.ProductID,
    p.DepartmentID,
    d.DepartmentName,
    p.ProductCode,
    p.ProductName,
    p.UnitPrice,
    p.Brand,
    p.ManufacturingDate
FROM silver.Product p
LEFT JOIN silver.Department d
ON p.DepartmentID = d.DepartmentID;

-----------------------------------------------------------------
----decide the date range , Use the minimum and maximum dates across silver tables.
----min_date = '2016-07-01' and max_date = '2026-05-28'

print '>> Inserting Data Into: gold.dim_date';

TRUNCATE TABLE gold.dim_date;
WITH DateSeries AS (
SELECT   CAST('2016-01-01' AS DATE) AS FullDate
UNION ALL
SELECT   DATEADD(DAY,1,FullDate) FROM DateSeries
WHERE FullDate < '2026-12-31' )

INSERT INTO gold.dim_date (
DateKey,
FullDate,
Day,
Month,
Year,
MonthName,
WeekdayName,
Quarter,
IsWeekend )

SELECT
          convert(INT,format(FullDate,'yyyyMMdd')) as DateKey,
          FullDate,
          day(FullDate) as Day,
          month(FullDate) as Month,
          year(FullDate) as Year,
          datename(month,FullDate) as MonthName,
          datename(weekday,FullDate) as WeekdayName,
          datepart(quarter,FullDate) as Quarter,

          CASE WHEN datename(weekday,FullDate) IN ('Friday' , 'Saturday') THEN 1 
               ELSE 0
          END AS IsWeekend
FROM DateSeries
OPTION (MAXRECURSION 0) --Without it, SQL Server stops recursion after 100 iterations by default.

----------------------------------------------------------------
print '>> Inserting Data Into: gold.dim_PaymentMethod';

TRUNCATE TABLE gold.dim_PaymentMethod;
INSERT INTO gold.dim_PaymentMethod
SELECT
    PaymentMethodID,
    MethodName
FROM silver.PaymentMethod;

-------------------------------------------------------------------------------
print '>> Inserting Data Into: gold.dim_ShippingCompany';

TRUNCATE TABLE gold.dim_ShippingCompany;
INSERT INTO gold.dim_ShippingCompany
SELECT
    ShippingCompanyID,
    CompanyName
FROM silver.ShippingCompany;

---------------------------------------------------------------------------------------
---Create Fact Table: (gold.fact_sales) (based on 3 tables Orders,OrderDetail and PaymentTransaction). 
---The grain of factSales is one row per product inside an order.

print '>> Inserting Data Into: gold.fact_sales';

TRUNCATE TABLE gold.fact_sales;
INSERT INTO gold.fact_sales

select
        c.Customer_Key,                                         --dimension key
        a.Address_Key,
        p.Product_Key,                                          
        pm.PaymentMethod_Key,                                  
        sc.Shipping_Key,                                        
        isnull(d.DateKey,-1) as DateKey,                                                 
        o.OrderID,                                              --degenerate dimension
        o.OrderStatus,
        od.Quantity,
        od.PriceAtPurchase,
        od.DiscountApplied,
        od.TotalAmount as NetAmount,                            -----Derived column calulated from price*quantity - discount = netamount
        pt.PaymentStatus

from silver.Orders o
left join silver.OrderDetail od
on o.OrderID = od.OrderID

left join silver.PaymentTransaction pt
on o.OrderID = pt.OrderID

left join gold.dim_customer c
on o.CustomerID = c.CustomerID 

left join gold.dim_product p
on od.ProductID = p.ProductID

left join gold.dim_PaymentMethod pm
on pt.PaymentMethodID = pm.PaymentMethodID

left join gold.dim_ShippingCompany sc
on o.ShippingCompanyID = sc.ShippingCompanyID

left join gold.dim_date d
on o.OrderDate = d.FullDate

left join gold.dim_CustomerAddress a
on o.ShippingAddressID = a.AddressID
and o.OrderDate >= cast(a.START_DATE as DATE)
and ( o.OrderDate < cast(a.END_DATE as DATE) or  a.END_DATE IS NULL )

end

----Excecute Stored Procedure For Gold Layer
EXEC gold.load_gold