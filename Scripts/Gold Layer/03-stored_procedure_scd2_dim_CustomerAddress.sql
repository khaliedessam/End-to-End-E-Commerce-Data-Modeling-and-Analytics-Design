/*-----------------------------------------------------------------------------------------------------
This stored procedure implements Slowly Changing Dimension Type 2 (SCD2) for the customer address dimension.

Its purpose is to:

Detect changes in customer address city.
Preserve the old customer record.
Create a new version of the customer record.
Maintain historical customer information.

*/------------------------------------------------------------------------------------------------------


 CREATE OR ALTER PROCEDURE gold.load_dim_CustomerAddress_Scd2
    @run_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------
    -- Step 1: Initial insert for brand new addresses
    ------------------------------------------------
    INSERT INTO gold.dim_CustomerAddress
    (
        AddressID,
        CustomerID,
        AddressType,
        AddressLine1,
        AddressLine2,
        City,
        START_DATE,
        END_DATE,
        Is_Current
    )
    SELECT
        source.AddressID,
        source.CustomerID,
        source.AddressType,
        source.AddressLine1,
        source.AddressLine2,
        source.City,
        CAST('2020-01-01' AS DATETIME2) AS START_DATE,
        NULL AS END_DATE,
        1 AS Is_Current
    FROM silver.CustomerAddress source
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM gold.dim_CustomerAddress target
        WHERE target.AddressID = source.AddressID
    );


    ------------------------------------------------
    -- Step 2: Close old current version when City changes
    ------------------------------------------------
    UPDATE target
    SET
        END_DATE = GETDATE(),
        Is_Current = 0
    FROM gold.dim_CustomerAddress target
    INNER JOIN silver.CustomerAddress source
        ON target.AddressID = source.AddressID
    WHERE target.Is_Current = 1
      AND ISNULL(target.City, '') <> ISNULL(source.City, '');


    ------------------------------------------------
    -- Step 3: Insert new version for changed City
    ------------------------------------------------
    INSERT INTO gold.dim_CustomerAddress
    (
        AddressID,
        CustomerID,
        AddressType,
        AddressLine1,
        AddressLine2,
        City,
        START_DATE,
        END_DATE,
        Is_Current
    )
    SELECT
        source.AddressID,
        source.CustomerID,
        source.AddressType,
        source.AddressLine1,
        source.AddressLine2,
        source.City,
        GETDATE() AS START_DATE,
        NULL AS END_DATE,
        1 AS Is_Current
    FROM silver.CustomerAddress source
    WHERE EXISTS
    (
        SELECT 1
        FROM gold.dim_CustomerAddress old_version
        WHERE old_version.AddressID = source.AddressID
          AND old_version.Is_Current = 0
          AND ISNULL(old_version.City, '') <> ISNULL(source.City, '')
    )
    AND NOT EXISTS
    (
        SELECT 1
        FROM gold.dim_CustomerAddress current_version
        WHERE current_version.AddressID = source.AddressID
          AND current_version.Is_Current = 1
    );

END;
GO
----check

declare @run_id UNIQUEIDENTIFIER = NEWID();
EXEC gold.load_dim_CustomerAddress_Scd2  @run_id