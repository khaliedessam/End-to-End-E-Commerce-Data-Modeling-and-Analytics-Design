/*
==============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
      This stored procedure loads data into the 'bronze' schema from external CSV files.

Actions Perofrmed:
      -Truncate the bronze tables before loading data
      -use the 'Bulk insert' command to load data from csv files to bronze tables.

Parameters:
      None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
      EXEC bronze.load_bronze;
==============================================================================
*/

create or alter procedure bronze.load_bronze as
  begin

BULK INSERT bronze.Customer
FROM 'D:\SQL ITI\Sales\Datasets\Customer.csv'
WITH (
firstrow=2,
fieldterminator=',',
tablock
);


BULK INSERT bronze.CustomerAddress
FROM 'D:\SQL ITI\Sales\Datasets\CustomerAddress.csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Department
FROM 'D:\SQL ITI\Sales\Datasets\Department.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Product
FROM 'D:\SQL ITI\Sales\Datasets\Product.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Supplier
FROM 'D:\SQL ITI\Sales\Datasets\Supplier.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.ProductSupplier
FROM 'D:\SQL ITI\Sales\Datasets\ProductSupplier.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Orders
FROM 'D:\SQL ITI\Sales\Datasets\Orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    TABLOCK
);



BULK INSERT bronze.OrderDetail
FROM 'D:\SQL ITI\Sales\Datasets\OrderDetail.csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.PaymentMethod
FROM 'D:\SQL ITI\Sales\Datasets\PaymentMethod.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.PaymentTransaction
FROM 'D:\SQL ITI\Sales\Datasets\PaymentTransaction.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.ShippingCompany
FROM 'D:\SQL ITI\Sales\Datasets\ShippingCompany.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Promotion
FROM 'D:\SQL ITI\Sales\Datasets\Promotion.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.ProductPromotion
FROM 'D:\SQL ITI\Sales\Datasets\ProductPromotion.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Review
FROM 'D:\SQL ITI\Sales\Datasets\Review.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Employee
FROM 'D:\SQL ITI\Sales\Datasets\Employee.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Warehouse
FROM 'D:\SQL ITI\Sales\Datasets\Warehouse.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

BULK INSERT bronze.Inventory
FROM 'D:\SQL ITI\Sales\Datasets\Inventory.csv'
WITH (
    FORMAT='CSV',
    FIRSTROW=2
);

end


----Excecute Stored Procedure For Bronze Layer
EXEC bronze.load_bronze