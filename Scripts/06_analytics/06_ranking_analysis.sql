/*---------------------------------------------------------------
EDA - Ranking Analysis

Purpose:
Rank products, categories, brands, and customers
based on sales performance.

Key Insights:
- Top and bottom revenue contributors.
- Most valuable customers.
- Most and least active customers.

Business Value:
Supports performance evaluation and business
prioritization.

----------------------------------------------------------------*/


-- Which 5 products generate the highest revenue?

select top 5 p.ProductName , sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by ProductName
order by Total_Revenue desc

-- Which 5 DepartmentName (category) generate the highest revenue?

select top 5 p.DepartmentName , sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by DepartmentName
order by Total_Revenue desc

-- Which 5 Brands generate the highest revenue?

select top 5 p.Brand , sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by Brand
order by Total_Revenue desc

-- What are the 5 worst-performing products in terms of sale?

select top 5 p.ProductName , sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by ProductName
order by Total_Revenue asc

-- Find the top 10 customers who have generated the highest revenue

select top 10 c.CustomerName , sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
where f.PaymentStatus = 'PAID'
group by CustomerName
order by Total_Revenue desc

-- Find the Highest 3 customers with the highest orders placed

select top 3 c.Customer_Key , c.CustomerName , count(distinct f.OrderID) as Total_Orders
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
group by c.Customer_Key,c.CustomerName
order by Total_Orders desc

-- Find the Highest 3 customers with the highest orders placed and completed the most purchases

select top 3 c.Customer_Key , c.CustomerName , count(distinct f.OrderID) as Total_Orders
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
where f.PaymentStatus = 'PAID'
group by c.Customer_Key,c.CustomerName
order by Total_Orders desc

-- Find the Lowest 3 customers with the fewest orders placed

select top 3 c.Customer_Key , c.CustomerName , count(distinct f.OrderID) as Total_Orders
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
group by c.Customer_Key,c.CustomerName
order by Total_Orders asc

