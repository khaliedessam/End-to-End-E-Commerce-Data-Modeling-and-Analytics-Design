/*---------------------------------------------------------------
EDA - Performance Analysis (Comparing the current value to a targte value).
   
Purpose:
Compare actual performance against average benchmarks.

Key Insights:
- Products performing above or below average revenue.
- Departments generating above or below average revenue.

Business Value:
Identifies overperforming and underperforming areas to
support business improvement decisions.

----------------------------------------------------------------*/




/* Analyze the yearly performance of products by comparing each product sales to both
 its average sales performance and the previous year's sales. */

 WITH yearly_product_sales AS (
 select 
          p.ProductName,
          d.Year,
          sum(f.NetAmount) as Current_Sales
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
left join gold.dim_product p
on f.Product_key = p.Product_Key
group by d.Year,p.ProductName
   )

select
         ProductName,
         Year,
         Current_Sales,
         round(cast(avg(Current_Sales) over (partition by ProductName) as float),2) as avg_sales,
         Current_Sales - round(cast(avg(Current_Sales) over (partition by ProductName) as float),2) as diff_avg,
         CASE WHEN Current_Sales - round(cast(avg(Current_Sales) over (partition by ProductName) as float),2) > 0 THEN 'Above Avg'
              WHEN Current_Sales - round(cast(avg(Current_Sales) over (partition by ProductName) as float),2) < 0 THEN 'Below Avg'
              ELSE 'Avg'
         END AS Avg_Change,
         LAG(Current_Sales) OVER(PARTITION BY ProductName ORDER BY Year) as Previous_Year_Sales,
         CASE WHEN Current_Sales - LAG(Current_Sales) OVER(PARTITION BY ProductName ORDER BY Year) > 0 THEN 'Increase'
              WHEN Current_Sales - LAG(Current_Sales) OVER(PARTITION BY ProductName ORDER BY Year) < 0 THEN 'Decrease'
              ELSE 'No Change'
         END AS Previous_Change
from yearly_product_sales
order by ProductName,Year


/* Analyze the yearly performance of Department (Category of product) by comparing each Department sales to both
 its average sales performance and the previous year's sales. */

 WITH yearly_Department_sales AS (
 select 
          p.DepartmentName,
          d.Year,
          sum(f.NetAmount) as Current_Sales
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
left join gold.dim_product p
on f.Product_key = p.Product_Key
group by d.Year,p.DepartmentName
   )

select
         DepartmentName,
         Year,
         Current_Sales,
         round(cast(avg(Current_Sales) over (partition by DepartmentName) as float),2) as avg_sales,
         Current_Sales - round(cast(avg(Current_Sales) over (partition by DepartmentName) as float),2) as diff_avg,
         CASE WHEN Current_Sales - round(cast(avg(Current_Sales) over (partition by DepartmentName) as float),2) > 0 THEN 'Above Avg'
              WHEN Current_Sales - round(cast(avg(Current_Sales) over (partition by DepartmentName) as float),2) < 0 THEN 'Below Avg'
              ELSE 'Avg'
         END AS Avg_Change,
         LAG(Current_Sales) OVER(PARTITION BY DepartmentName ORDER BY Year) as Previous_Year_Sales,
         CASE WHEN Current_Sales - LAG(Current_Sales) OVER(PARTITION BY DepartmentName ORDER BY Year) > 0 THEN 'Increase'
              WHEN Current_Sales - LAG(Current_Sales) OVER(PARTITION BY DepartmentName ORDER BY Year) < 0 THEN 'Decrease'
              ELSE 'No Change'
         END AS Previous_Change
from yearly_Department_sales
order by DepartmentName,Year

