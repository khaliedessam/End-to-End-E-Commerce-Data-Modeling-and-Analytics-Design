/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and sales performance
      based on completed (PAID) transactions only.

Highlights:
    1. Gathers essential product and sales information from paid orders.
    2. Evaluates product performance and revenue contribution.
    3. Aggregates product-level metrics:
       - total completed orders
       - total sales revenue
       - total quantity sold
       - total customers
       - product lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last paid sale)
       - average order value (total_sales / total_orders)
       - average monthly revenue

Notes:
    - Only transactions with PaymentStatus = 'PAID' are included.
    - Pending, Failed, and Refunded transactions are excluded from all
      calculations to ensure metrics reflect actual realized revenue.
===============================================================================
*/

/*------------------------------------------------------------------------------
1) Base Query: Gathers essential fields from tables 
-------------------------------------------------------------------------------*/
IF OBJECT_ID('gold.report_products','V') IS NOT NULL
   DROP VIEW gold.report_products
GO
  CREATE VIEW gold.report_products AS
WITH Base_Query AS (
select
       p.Product_Key,
       f.Customer_Key,
       p.ProductName,
       p.Brand,
       f.OrderID,
       f.Quantity,
       f.NetAmount,
       d.FullDate,
       p.UnitPrice
            
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
left join gold.dim_date d
on f.DateKey = d.DateKey
where FullDate is not null and f.PaymentStatus = 'PAID' ),

/*------------------------------------------------------------------------
2) Product Aggregationn: Summarizes key metrics at the product level
-------------------------------------------------------------------------*/

Product_Aggregation AS (

select
         Product_Key,
         ProductName,
         Brand,
         UnitPrice,
         count(distinct OrderID) as Total_Orders,
         count(distinct Customer_Key) as Total_Customers,
         sum(NetAmount) as Total_Sales,
         sum(Quantity) as Total_Quantity,
         max(FullDate) as Last_Order_Date,
         DATEDIFF(month,min(FullDate),max(FullDate)) as LifeSpan
from Base_Query
group by Product_Key,ProductName,Brand,UnitPrice )

select
         Product_Key,
         ProductName,
         Brand,
         UnitPrice,
         Total_Orders,
         Total_Customers,
         Total_Sales,
         Total_Quantity,
         Last_Order_Date,
         LifeSpan,
         DATEDIFF(month,Last_Order_Date,GETDATE()) as Recency_In_Months,
         round(cast(Total_Sales as float) / nullif(Total_Orders,0),2) as Avg_Order_Value,
         round(cast(Total_Sales as float) / nullif(LifeSpan,0),2) as Avg_Monthly_Spend       
from Product_Aggregation




