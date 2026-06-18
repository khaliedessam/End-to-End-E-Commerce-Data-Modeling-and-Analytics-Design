/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value (total_sales / total_orders)
		- average monthly spend
===============================================================================
*/


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
where FullDate is not null ),

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
		 CASE WHEN Total_Sales >= 1250000 THEN 'Vip'
            WHEN Total_Sales >= 760000 THEN 'Regular'
            ELSE 'New'
       END AS Customer_Segment,
	   Last_Order_Date,
	   DATEDIFF(month,Last_Order_Date,GETDATE()) as Recency,
	   Total_Orders,
	   Total_Products,
	   Total_Sales,
	   Total_Quantity,
	   LifeSpan,
	   round(cast(Total_Sales / Total_Orders as float),2) as Avg_Order_Value,
       round(cast(Total_Sales / LifeSpan as float),2) as Avg_Monthly_Spend
from Customer_Aggregation



-------------------------------------------------------------


select * from gold.report_customers