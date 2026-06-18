/*-----------------------------------------------------------------------------------------------------
This stored procedure implements Slowly Changing Dimension Type 2 (SCD2) for the customer address dimension.

Its purpose is to:

Detect changes in customer address city.
Preserve the old customer record.
Create a new version of the customer record.
Maintain historical customer information.

*/------------------------------------------------------------------------------------------------------


 ---- Close Old Customer Version
 CREATE OR ALTER PROCEDURE gold.load_dim_CustomerAddress_Scd2 AS
 BEGIN

 UPDATE target
 SET
     END_DATE = GETDATE(),
     Is_Current = 0
FROM gold.dim_CustomerAddress target
inner join silver.CustomerAddress source
on  target.AddressID = source.AddressID 
WHERE target.Is_Current = 1 and ISNULL(target.City,'') <> ISNULL(source.City,'')

 ------ Insert New Customer Version
 INSERT INTO gold.dim_CustomerAddress (
   AddressID,
   CustomerID,
   AddressType,
   AddressLine1,
   AddressLine2,
   City,
   START_DATE,
   END_DATE,
   Is_Current )

SELECT
       source.AddressID,
       source.CustomerID,
       source.AddressType,
       source.AddressLine1,
       source.AddressLine2,
       source.City,
       GETDATE(),
       NULL,
       1
FROM silver.CustomerAddress source
left join gold.dim_CustomerAddress target
on source.AddressID = target.AddressID 
      and target.Is_Current = 1
where target.AddressID is null                                    -----this insert the new value of city that doesn`t exist so target.AddressID is null after join

END;

