/*
===================================================================================================
Script Purpose: Execute and Validate ETL Pipeline
===================================================================================================
This script executes the master ETL pipeline and validates the execution results by reviewing
pipeline-level and file-level logs.

It is used for testing and monitoring the ETL process after creating or updating the ETL
stored procedures.
===================================================================================================
*/


EXEC etl.run_pipeline;

SELECT *
FROM etl.pipeline_log;

SELECT *
FROM etl.file_load_log;

