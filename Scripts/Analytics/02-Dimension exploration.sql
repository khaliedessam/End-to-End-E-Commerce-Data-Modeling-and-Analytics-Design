select * from gold.dim_PaymentMethod
select * from gold.fact_sales


---1. Revenue by Payment Method

select
        pm.MethodName,
        sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_PaymentMethod pm
on f.PaymentMethod_Key = pm.PaymentMethod_Key
group by pm.MethodName
order by Total_Revenue desc

--2. Orders by Payment Method

select
        pm.MethodName,
        count(distinct f.OrderID) as Total_Orders
from gold.fact_sales f
left join gold.dim_PaymentMethod pm
on f.PaymentMethod_Key = pm.PaymentMethod_Key
group by pm.MethodName
order by Total_Orders desc

