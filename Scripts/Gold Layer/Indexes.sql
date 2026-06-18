/*
==================================================
Create Indexes for Gold Layer Performance
==================================================
Purpose:
    Create nonclustered indexes on fact_sales to 
    improve analytical queries and Power BI reports.
==================================================
*/

-- DateKey Index
IF EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_fact_sales_DateKey'
      AND object_id = OBJECT_ID('gold.fact_sales')
)
DROP INDEX IX_fact_sales_DateKey ON gold.fact_sales;

CREATE INDEX IX_fact_sales_DateKey
ON gold.fact_sales(DateKey);
GO


-- Product Index
IF EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_fact_sales_Product_Key'
      AND object_id = OBJECT_ID('gold.fact_sales')
)
DROP INDEX IX_fact_sales_Product_Key ON gold.fact_sales;

CREATE INDEX IX_fact_sales_Product_Key
ON gold.fact_sales(Product_Key);
GO


-- Customer Index
IF EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_fact_sales_Customer_Key'
      AND object_id = OBJECT_ID('gold.fact_sales')
)
DROP INDEX IX_fact_sales_Customer_Key ON gold.fact_sales;

CREATE INDEX IX_fact_sales_Customer_Key
ON gold.fact_sales(Customer_Key);
GO


-- Order Index
IF EXISTS (
    SELECT 1 
    FROM sys.indexes 
    WHERE name = 'IX_fact_sales_OrderID'
      AND object_id = OBJECT_ID('gold.fact_sales')
)
DROP INDEX IX_fact_sales_OrderID ON gold.fact_sales;

CREATE INDEX IX_fact_sales_OrderID
ON gold.fact_sales(OrderID);
GO