/*---------------------------------------------------------------
EDA - Change Over Time Analysis

Purpose:
Analyze sales, orders, and customer activity across time.

Key Insights:
- Revenue trends by year, quarter, and month.
- Order volume trends over time.
- Customer purchasing activity by time period.
- Seasonal patterns and business growth trends.

Business Value:
Supports sales forecasting, seasonality analysis,
and business performance tracking.

----------------------------------------------------------------*/

-- Analyze Sale Performance Over Time

--Revenue by Year
select 
         d.Year , count(distinct Customer_Key) as Total_Customers , sum(f.NetAmount) as Total_Year_Revenue
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
where d.DateKey <> -1
group by d.Year
order by Total_Year_Revenue desc

--Revenue by Month
select 
         d.Year , d.Month , sum(f.NetAmount) as Total_Year_Revenue
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
where d.DateKey <> -1
group by d.Year , d.Month
order by Total_Year_Revenue desc

--Revenue by Quarter
select 
       d.Year , d.Quarter , sum(f.NetAmount) as Total_Year_Revenue
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
where d.DateKey <> -1
group by d.Year , d.Quarter
order by Total_Year_Revenue desc

--Orders by Year
select
        d.Year , count(distinct f.OrderID) as Total_Year_Orders
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
where d.DateKey <> -1
group by d.Year
order by Total_Year_Orders desc


