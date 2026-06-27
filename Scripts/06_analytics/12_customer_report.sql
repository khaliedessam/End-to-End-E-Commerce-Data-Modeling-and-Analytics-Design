/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and purchasing behaviors
      based on completed (PAID) transactions only.

Highlights:
    1. Gathers essential customer and sales information from paid orders.
    2. Segments customers into categories (VIP, Regular, New).
    3. Aggregates customer-level metrics:
       - total completed orders
       - total sales revenue
       - total quantity purchased
       - total products purchased
       - customer lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last paid order)
       - average order value (total_sales / total_orders)
       - average monthly spend

Notes:
    - Only transactions with PaymentStatus = 'PAID' are included.
    - Pending, Failed, and Refunded transactions are excluded from all
      calculations to ensure metrics reflect actual realized revenue.
===============================================================================
*/


select * from gold.dim_customer
/*------------------------------------------------------------------------------
1) Base Query: Gathers essential fields from tables 
-------------------------------------------------------------------------------*/
IF OBJECT_ID('gold.report_customers','V') IS NOT NULL
   DROP VIEW gold.report_customers
GO
  CREATE VIEW gold.report_customers AS
WITH Base_Query as (
select
        c.Customer_Key,
		c.CustomerID,
		c.CustomerName,
		f.Product_Key,
		f.Quantity,
		f.OrderID,
		f.NetAmount,
		d.FullDate,
		c.phone	
			
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
left join gold.dim_date d
on f.DateKey = d.DateKey
where FullDate is not null and f.PaymentStatus = 'PAID' ),

/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/

Customer_Aggregation as (
select
        Customer_Key,
		CustomerID,
		CustomerName,
		count(distinct OrderID) as Total_Orders,
		count(distinct Product_Key) as Total_Products,
		sum(NetAmount) as Total_Sales,
		sum(Quantity) as Total_Quantity,
		max(FullDate) as Last_Order_Date,
		DATEDIFF(month,min(FullDate),max(FullDate)) as LifeSpan
from Base_Query
group by Customer_Key,CustomerID,CustomerName )

select
         Customer_Key,
		 CustomerID,
		 CustomerName,
		 CASE WHEN Total_Sales >= 30000 THEN 'Vip'
            WHEN Total_Sales >= 10000 THEN 'Regular'
            ELSE 'New'
       END AS Customer_Segment,
	   Last_Order_Date,
	   DATEDIFF(month,Last_Order_Date,GETDATE()) as Recency,
	   Total_Orders,
	   Total_Products,
	   Total_Sales,
	   Total_Quantity,
	   LifeSpan,
	   round(cast(Total_Sales as float) / nullif(Total_Orders,0 ),2) as Avg_Order_Value,
       round(cast(Total_Sales as float) / nullif(LifeSpan,0) ,2) as Avg_Monthly_Spend
from Customer_Aggregation







