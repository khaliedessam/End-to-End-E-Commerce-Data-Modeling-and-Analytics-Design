/*---------------------------------------------------------------
EDA - Part-to-Whole Analysis

Purpose:
Measure the contribution of individual dimensions to
overall business performance.

Key Insights:
- Percentage contribution of each department to total sales.
- Identify dominant and underperforming categories.
- Understand revenue distribution across the business.

Business Value:
Highlights which categories drive the largest share
of revenue and supports strategic decision-making.

----------------------------------------------------------------*/

-- which categories (Department) contribute the most to over sales?

WITH Category_Percentage AS (
select
        p.DepartmentName,
        sum(f.NetAmount) as Total_Sales
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
group by p.DepartmentName
 )

select
          DepartmentName,
          Total_Sales,
          sum(Total_Sales) over() as Overall_Sales,
          concat(cast (round(Total_Sales*100 / sum(Total_Sales) over(),2) as float),'%') as Percentage_Of_Total
from Category_Percentage
group by DepartmentName,Total_Sales
order by Total_Sales desc


-- which Brand  contribute the most to over sales?

WITH Brand_Percentage AS (
select
        p.Brand,
        sum(f.NetAmount) as Total_Sales
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
group by p.Brand )

select
          Brand,
          Total_Sales,
          sum(Total_Sales) over() as Overall_Sales,
          concat(cast (round(Total_Sales*100 / sum(Total_Sales) over(),2) as float),'%') as Percentage_Of_Total
from Brand_Percentage
order by Total_Sales desc


