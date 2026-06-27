/*
Purpose:
This script performs a commulative sales analysis to evaluate business performance over time.

Steps:
1. Aggregates sales at the month level by grouping all transactions within the same month.
2. Calculates total sales for each period.
3. Uses window functions to compute:
   - Running Total Sales: progressive accumulation of sales over time.
   - Commulative Sales: total sales across the entire dataset.
4. Helps identify sales trends and determine whether the business is growing or declining over time.
*/


-- Calculate the total sales per month and the running total of sales overtime

--total sales per month
select 
              DATEFROMPARTS(Year,Month,1) as Order_Date,  --grouping all transactions within the same month.
               sum(f.NetAmount) as NetAmount
from  gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey and f.PaymentStatus = 'PAID'
where FullDate is not null 
group by DATEFROMPARTS(Year,Month,1)
order by DATEFROMPARTS(Year,Month,1) 

--the running total of sales overtime

WITH Running_sales as (

select      DATEFROMPARTS(Year,1,1) as Order_Date,   --grouping all transactions within the same year.
            sum(f.NetAmount) as NetAmount
from  gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
where FullDate is not null and f.PaymentStatus = 'PAID'
group by DATEFROMPARTS(Year,1,1)
)
select
         Order_Date,
         NetAmount,
         sum(NetAmount) over(order by Order_Date) as Total_Running_Sales,
         sum(NetAmount) over() as Total_Comulative_Sales
from Running_sales
order by Order_Date desc