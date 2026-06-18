/*
=========================================================
SCD Type 2 Testing – Customer City Change
=========================================================

Purpose:
This test validates the SCD Type 2 implementation on the
Customer Dimension (gold.dim_customer).

Test Steps:
1. Display the current customer record from the Gold layer.
2. Modify the customer's city in the Silver layer.
3. Execute the SCD2 stored procedure.
4. Verify that:
   - The old customer record is preserved.
   - The old record is marked as inactive
     (Is_Current = 0).
   - The old record receives an End_Date.
   - A new customer record is inserted with the
     updated city.
   - The new record is marked as active
     (Is_Current = 1).
   - Customer history is maintained correctly.

Expected Result:
The same CustomerID should appear twice in
gold.dim_customer:
   - Historical version (old city)
   - Current version (new city)

This confirms that SCD Type 2 is functioning correctly
and customer attribute changes are tracked over time.
=========================================================
*/


---1. Display the current customer record from the Gold layer.

select * from silver.CustomerAddress
where CustomerID = 1

--2. Modify the customer's city in the Silver layer .

update silver.CustomerAddress
set City = 'ABHA'
where AddressID = 3

--3. Execute the SCD2 stored procedure.

EXEC gold.load_dim_CustomerAddress_Scd2

--4. Verify that.

select * from gold.dim_CustomerAddress
where CustomerID = 1

