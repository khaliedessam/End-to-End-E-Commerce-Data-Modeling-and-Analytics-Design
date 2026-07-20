

/*
===============================================================================
Script Summary
-------------------------------------------------------------------------------
This script generates the key business metrics used in the Executive Sales
Dashboard.

Metrics calculated using only PAID orders:
- Revenue
- Total Quantity Sold
- Average Product Price
- Average Order Value (Revenue / Distinct Paid Orders)

Metrics calculated using all orders, regardless of payment status
(PAID, REFUND, CANCELLED, and PENDING):
- Total Orders

Additional metrics:
- Total Products (from gold.dim_product)
- Total Customers (from gold.dim_customer)

Note:
Revenue-related KPIs are intentionally filtered to PaymentStatus = 'PAID'
to reflect only completed sales transactions.
===============================================================================
*/


--Find Total Sales Value  
select sum(NetAmount) as Revenue from gold.fact_sales

--Find Paid  Revenue
select sum(NetAmount) as Revenue from gold.fact_sales
where PaymentStatus = 'PAID'

--Find Pending  Revenue
select sum(NetAmount) as PendingRevenue from gold.fact_sales
where PaymentStatus = 'PENDING'

--Find Refunded  Value
select sum(NetAmount) as PendingRevenue from gold.fact_sales
where PaymentStatus = 'REFUNDED'

--Find Failed Order Value   
select sum(NetAmount) as PendingRevenue from gold.fact_sales
where PaymentStatus = 'FAILED'

-- Find how many items are sold
select sum(Quantity) as Total_Quantity from gold.fact_sales
where PaymentStatus = 'PAID'

-- Find the average selling price
select sum(NetAmount)/sum(Quantity) as Avg_Price from gold.fact_sales
where PaymentStatus = 'PAID'

-- Find the Total number of Orders
select count(distinct OrderID) as Total_Orders from gold.fact_sales

-- Find the Total number of Products
select count(distinct ProductID) as Total_Products from gold.dim_product

-- Fint the Total number of Customers
select count(distinct CustomerID) as Total_Customers from gold.dim_customer


-- Generate a Report that shows all key metrics of the business
IF OBJECT_ID('gold.vw_business_KPIs', 'V') IS NOT NULL
    DROP VIEW gold.vw_business_KPIs;
GO

CREATE VIEW gold.vw_business_KPIs AS

select 'Revenue' as measure_name , sum(NetAmount) as measure_value from gold.fact_sales 
where PaymentStatus = 'PAID'
union all
select 'Total_Quantity' as measure_name , sum(Quantity) as measure_value from gold.fact_sales
where PaymentStatus = 'PAID'
union all
select 'Avg_Price' as measure_name ,  sum(NetAmount)/sum(Quantity) as measure_value from gold.fact_sales
where PaymentStatus = 'PAID'
union all
select 'Average_Order_Value' as measure_name , sum(NetAmount)/count(distinct OrderID) as measure_value from gold.fact_sales
where PaymentStatus = 'PAID'
union all
select 'Total_Orders' as measure_name , count(distinct OrderID) as Total_Orders from gold.fact_sales
union all
select 'Total_Products' as measure_name , count(distinct ProductID) as Total_Products from gold.dim_product
union all
select 'Total_Customers' as measure_name , count(distinct CustomerID) as Total_Customers from gold.dim_customer

-- Business KPI Summary

select * from gold.vw_business_KPIs
