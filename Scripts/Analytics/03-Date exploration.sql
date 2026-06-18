---Date Exploration

--Identify the earliest and latest dates (boundaries) and years between them (time span of business).
-- Find the date of the first and last order.



select max(FullDate) as last_order_date,
       min(FullDate) as first_order_date,
       DATEDIFF(year,min(FullDate),max(FullDate)) as time_span
from gold.fact_sales s
left join gold.dim_date d
on s.DateKey = d.DateKey
where d.DateKey <> -1

