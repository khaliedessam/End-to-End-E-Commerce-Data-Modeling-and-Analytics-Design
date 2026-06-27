

--The grain of fact table is one row per product inside one order.

--first check duplicate grain (OrderID , Product_key):

select OrderID , Product_key , count(*) as duplicates   --returns 0 rows, your grain is correct.
from gold.fact_sales
group by OrderID , Product_key           
having count(*) > 1


--second check missing dimension keys:

select * from gold.fact_sales
where Customer_Key is null
or    Product_key is null
or    Address_Key is null
or    PaymentMethod_Key is null
or    Shipping_Key is null
or    DateKey is null              ---- I have NULL values in DateKey column due to missing order date of some orders
                                   ---- I handle it by inserting fake row in dim_date to become DateKey = -1 instead of NULL.  



INSERT INTO gold.dim_date (
DateKey,
FullDate,
Day,
Month,
Year,
MonthName,
WeekdayName,
Quarter,
IsWeekend )

VALUES ( -1,'1900-01-01',0,0,1900,'Unknown','Unknown',0,0 )

---- check again
select * from gold.fact_sales
where  DateKey = -1  




