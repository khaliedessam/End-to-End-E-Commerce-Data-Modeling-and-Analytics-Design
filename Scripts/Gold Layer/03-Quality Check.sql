
-- 1. Expected grain from source
SELECT 
    COUNT(*) AS ExpectedRows
FROM silver.OrderDetail;

-- 2. Actual rows in fact_sales
SELECT 
    COUNT(*) AS ActualRows
FROM gold.fact_sales;

-- 3. Check duplicate rows at fact grain  (OrderID , Product_key)
select 
        OrderID,
        Product_Key,
        count(*) as Duplicate_Rows
from gold.fact_sales
group by OrderID,Product_Key
having count(*) > 1

-- 4. Check if one order joins to more than one address version

select
      o.OrderID,
      o.ShippingAddressID,
      count(a.Address_Key) as matching_address_rows
from silver.Orders o
left join gold.dim_CustomerAddress a
on o.ShippingAddressID = a.AddressID
and o.OrderDate >= cast(a.START_DATE as DATE)
and ( o.OrderDate < cast(a.END_DATE as DATE) or a.END_DATE IS NULL )
group by o.OrderID,o.ShippingAddressID
having count(a.Address_Key) > 1

-- 5. Orders with no matching address version
select
      o.OrderID,
      o.ShippingAddressID,
      o.OrderDate
from silver.Orders o
left join gold.dim_CustomerAddress a
on o.ShippingAddressID = a.AddressID
and o.OrderDate >= cast(a.START_DATE as DATE)
and ( o.OrderDate < cast(a.END_DATE as DATE) or a.END_DATE IS NULL )
where a.Address_Key is null

-- 6. Compare source grain vs fact grain
SELECT
    od.OrderID,
    od.ProductID,
    COUNT(*) AS SourceRows
FROM silver.OrderDetail od
GROUP BY od.OrderID, od.ProductID
HAVING COUNT(*) > 1;

-- Check null foreign keys in fact

SELECT
    SUM(CASE WHEN Customer_Key IS NULL THEN 1 ELSE 0 END) AS MissingCustomer,
    SUM(CASE WHEN Address_Key IS NULL THEN 1 ELSE 0 END) AS MissingAddress,
    SUM(CASE WHEN Product_Key IS NULL THEN 1 ELSE 0 END) AS MissingProduct,
    SUM(CASE WHEN PaymentMethod_Key IS NULL THEN 1 ELSE 0 END) AS MissingPaymentMethod,
    SUM(CASE WHEN Shipping_Key IS NULL THEN 1 ELSE 0 END) AS MissingShipping,
    SUM(CASE WHEN DateKey IS NULL THEN 1 ELSE 0 END) AS UnknownDate
FROM gold.fact_sales;

-- Check measure accuracy

SELECT
    *
FROM gold.fact_sales
WHERE NetAmount <> (Quantity * PriceAtPurchase - DiscountApplied);