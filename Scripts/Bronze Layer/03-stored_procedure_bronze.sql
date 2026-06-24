/*
===================================================================================================
Stored Procedure: Load Bronze Layer Tables with File-Level Monitoring
===================================================================================================
Script Purpose:
       This stored procedure loads raw data from CSV files into the Bronze Layer
       using a full refresh strategy. Each Bronze table is truncated before loading
       to prevent duplicate records from previous ETL executions.

       The procedure includes file-level monitoring by recording the execution
       details of each CSV load into etl.file_load_log.

       For each file:
       - A loading status is recorded before the BULK INSERT operation.
       - The target Bronze table is refreshed using TRUNCATE TABLE.
       - Data is loaded from the source CSV file using BULK INSERT.
       - The number of inserted rows is captured.
       - The execution status is updated as Success, Warning, or Failed.
       - Error messages are stored when a load failure occurs.

       The @run_id parameter links all file loads to a specific ETL pipeline
       execution, allowing complete traceability between pipeline-level and
       file-level monitoring.

Usage:
       This procedure is executed through etl.run_pipeline as part of the
       automated ETL workflow and should not be executed manually during
       regular scheduled operations.
===================================================================================================
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze
    @run_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @file_log_id INT;
    DECLARE @rows_loaded INT;

    ------------------------------------------------
    -- Customer.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Customer.csv', 'bronze.Customer', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Customer;

        BULK INSERT bronze.Customer
        FROM 'D:\SQL ITI\Sales\Datasets\Customer.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- CustomerAddress.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'CustomerAddress.csv', 'bronze.CustomerAddress', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.CustomerAddress;

        BULK INSERT bronze.CustomerAddress
        FROM 'D:\SQL ITI\Sales\Datasets\CustomerAddress.csv'
        WITH (FIRSTROW = 2, FORMAT = 'CSV', FIELDQUOTE = '"', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Department.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Department.csv', 'bronze.Department', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Department;

        BULK INSERT bronze.Department
        FROM 'D:\SQL ITI\Sales\Datasets\Department.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Product.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Product.csv', 'bronze.Product', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Product;

        BULK INSERT bronze.Product
        FROM 'D:\SQL ITI\Sales\Datasets\Product.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Supplier.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Supplier.csv', 'bronze.Supplier', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Supplier;

        BULK INSERT bronze.Supplier
        FROM 'D:\SQL ITI\Sales\Datasets\Supplier.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- ProductSupplier.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'ProductSupplier.csv', 'bronze.ProductSupplier', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.ProductSupplier;

        BULK INSERT bronze.ProductSupplier
        FROM 'D:\SQL ITI\Sales\Datasets\ProductSupplier.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Orders.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Orders.csv', 'bronze.Orders', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Orders;

        BULK INSERT bronze.Orders
        FROM 'D:\SQL ITI\Sales\Datasets\Orders.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- OrderDetail.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'OrderDetail.csv', 'bronze.OrderDetail', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.OrderDetail;

        BULK INSERT bronze.OrderDetail
        FROM 'D:\SQL ITI\Sales\Datasets\OrderDetail.csv'
        WITH (FIRSTROW = 2, FORMAT = 'CSV', FIELDQUOTE = '"', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- PaymentMethod.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'PaymentMethod.csv', 'bronze.PaymentMethod', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.PaymentMethod;

        BULK INSERT bronze.PaymentMethod
        FROM 'D:\SQL ITI\Sales\Datasets\PaymentMethod.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- PaymentTransaction.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'PaymentTransaction.csv', 'bronze.PaymentTransaction', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.PaymentTransaction;

        BULK INSERT bronze.PaymentTransaction
        FROM 'D:\SQL ITI\Sales\Datasets\PaymentTransaction.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- ShippingCompany.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'ShippingCompany.csv', 'bronze.ShippingCompany', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.ShippingCompany;

        BULK INSERT bronze.ShippingCompany
        FROM 'D:\SQL ITI\Sales\Datasets\ShippingCompany.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Promotion.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Promotion.csv', 'bronze.Promotion', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Promotion;

        BULK INSERT bronze.Promotion
        FROM 'D:\SQL ITI\Sales\Datasets\Promotion.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- ProductPromotion.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'ProductPromotion.csv', 'bronze.ProductPromotion', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.ProductPromotion;

        BULK INSERT bronze.ProductPromotion
        FROM 'D:\SQL ITI\Sales\Datasets\ProductPromotion.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Review.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Review.csv', 'bronze.Review', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Review;

        BULK INSERT bronze.Review
        FROM 'D:\SQL ITI\Sales\Datasets\Review.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Employee.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Employee.csv', 'bronze.Employee', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Employee;

        BULK INSERT bronze.Employee
        FROM 'D:\SQL ITI\Sales\Datasets\Employee.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Warehouse.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Warehouse.csv', 'bronze.Warehouse', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Warehouse;

        BULK INSERT bronze.Warehouse
        FROM 'D:\SQL ITI\Sales\Datasets\Warehouse.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;


    ------------------------------------------------
    -- Inventory.csv
    ------------------------------------------------
    BEGIN TRY
        INSERT INTO etl.file_load_log (run_id, file_name, target_table, start_time, status)
        VALUES (@run_id, 'Inventory.csv', 'bronze.Inventory', SYSDATETIME(), 'Running');

        SET @file_log_id = SCOPE_IDENTITY();

        TRUNCATE TABLE bronze.Inventory;

        BULK INSERT bronze.Inventory
        FROM 'D:\SQL ITI\Sales\Datasets\Inventory.csv'
        WITH (FORMAT = 'CSV', FIRSTROW = 2);

        SET @rows_loaded = @@ROWCOUNT;

        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(),
            rows_loaded = @rows_loaded,
            status = CASE WHEN @rows_loaded = 0 THEN 'Warning' ELSE 'Success' END,
            error_message = CASE WHEN @rows_loaded = 0 THEN 'File loaded successfully but contained 0 rows.' ELSE NULL END
        WHERE file_log_id = @file_log_id;
    END TRY
    BEGIN CATCH
        UPDATE etl.file_load_log
        SET end_time = SYSDATETIME(), status = 'Failed', error_message = ERROR_MESSAGE()
        WHERE file_log_id = @file_log_id;
        THROW;
    END CATCH;

END;
GO