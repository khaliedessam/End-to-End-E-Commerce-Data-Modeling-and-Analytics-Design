/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Sales' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'Sales' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'Sales' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Sales')
BEGIN
    ALTER DATABASE Sales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Sales;
END;

-- Create the 'Sales' database
CREATE DATABASE  Sales;

GO

USE  Sales;

Go

-- Create Schemas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;

