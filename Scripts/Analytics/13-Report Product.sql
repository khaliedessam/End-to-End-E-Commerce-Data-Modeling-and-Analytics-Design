/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
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
where FullDate is not null ),

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
         round(cast(Total_Sales / Total_Orders as float),2) as Avg_Order_Value,
         round(cast(Total_Sales / LifeSpan as float),2) as Avg_Monthly_Spend       
from Product_Aggregation


------------------------------------------------------------------------------------------------
select * from gold.report_products

