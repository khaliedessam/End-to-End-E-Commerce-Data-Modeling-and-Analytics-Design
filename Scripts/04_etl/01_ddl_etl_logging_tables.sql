/*-----------------------------------------------------------------------------------------------------
This script creates the ETL logging tables used to monitor and audit the Data Warehouse ETL process.

The logging framework consists of:

1. etl.pipeline_log:
   - Records the execution details of each ETL pipeline step (Bronze, Silver, Gold, SCD2, etc.).
   - Stores the pipeline run ID, step name, execution time, status, and any error messages.

2. etl.file_load_log:
   - Records information about individual source file loads.
   - Stores the file name, target table, load duration, number of rows loaded, status, and errors.

These tables provide ETL monitoring, troubleshooting, execution history, and data load auditing.
-----------------------------------------------------------------------------------------------------*/

CREATE TABLE etl.pipeline_log (

log_id INT IDENTITY(1,1) PRIMARY KEY,
run_id UNIQUEIDENTIFIER NOT NULL,
pipeline_name VARCHAR(100) NOT NULL,
step_name VARCHAR(100) NOT NULL,
start_time DATETIME2 NOT NULL,
end_time DATETIME2 NULL,
status VARCHAR(20) NOT NULL,
error_message VARCHAR(MAX) NULL );

--Each time one CSV file loads, we insert one record.


CREATE TABLE etl.file_load_log (
file_log_id INT IDENTITY(1,1) PRIMARY KEY,
run_id UNIQUEIDENTIFIER NOT NULL,
file_name VARCHAR(255),
target_table VARCHAR(255),
start_time DATETIME2 NOT NULL,
end_time DATETIME2 NULL,
rows_loaded INT NULL,
status VARCHAR(255),
error_message VARCHAR(MAX) NULL );


