
/*---------------------------------------------------------------
EDA - Product Magnitude Analysis

Purpose:
Measure sales performance across product dimensions.

Key Insights:
- Revenue by department, brand, and product.
- Average price by department.
- Product count by department and brand.

Business Value:
Identifies high-performing products, brands, and categories
to support business decisions.

----------------------------------------------------------------*/


-- What is the total revenue generated for each category (DepartmentName) ?

select p.DepartmentName , sum(f.NetAmount) as NetAmount
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by p.DepartmentName
order by NetAmount desc



-- What is the total revenue generated for each Brand ?

select p.Brand , sum(f.NetAmount) as NetAmount
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by p.Brand
order by NetAmount desc

-- What is the total revenue generated for each ProductName ?

select p.ProductName , sum(f.NetAmount) as NetAmount
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
where f.PaymentStatus = 'PAID'
group by p.ProductName
order by NetAmount desc

-- What is the average costs in each category?

select DepartmentName , avg(UnitPrice) as avg_UnitPrice 
from gold.dim_product
group by DepartmentName
order by avg_UnitPrice desc

-- Find total products by category (DepartmentName)

select DepartmentName , count(ProductID) as Total_Product 
from gold.dim_product
group by DepartmentName
order by Total_Product desc

-- Find total products by Brand 

select Brand , count(ProductID) as Total_Product 
from gold.dim_product
group by Brand
order by Total_Product desc

