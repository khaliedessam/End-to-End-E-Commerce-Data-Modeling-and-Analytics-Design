
/*-----------------------------------------------------------------------------------------------------
This stored procedure acts as the master ETL pipeline controller for the Sales Data Warehouse.

Its purpose is to:

- Generate a unique run_id for each ETL execution to enable end-to-end pipeline tracking.
- Execute all ETL layers in the correct sequence:
      1. Load raw data into the Bronze layer.
      2. Transform and cleanse data in the Silver layer.
      3. Load dimensions and facts into the Gold layer.
      4. Apply Slowly Changing Dimension Type 2 (SCD2) logic for Customer Address history.
- Record the execution status of each step in the etl.pipeline_log table.
- Capture start and end execution times for monitoring and performance analysis.
- Handle failures by logging error details and stopping the pipeline execution.

This master procedure provides centralized orchestration, monitoring, and error handling for the complete
Sales Data Warehouse ETL workflow.
-----------------------------------------------------------------------------------------------------*/



CREATE OR ALTER PROCEDURE etl.run_pipeline AS
  begin
       set nocount on;
       
       declare @run_id UNIQUEIDENTIFIER = NEWID();
       declare @log_id INT;
  
  begin try
        ------------------------------------------------
        -- Step 1: Bronze
        ------------------------------------------------
       insert into etl.pipeline_log (
       run_id,
       pipeline_name,
       step_name,
       start_time,
       status )

       values( @run_id,
               'Sales_Dw_ETL',
               'bronze.load_bronze',
               SYSDATETIME(),
               'Running' );

       set @log_id = SCOPE_IDENTITY();

       EXEC bronze.load_bronze @run_id = @run_id;

       update etl.pipeline_log
       set
           end_time = SYSDATETIME(),
           status = 'Success'
       where log_id = @log_id;

       
        ------------------------------------------------
        -- Step 2: Silver
        ------------------------------------------------

        insert into etl.pipeline_log (
        run_id,
        pipeline_name,
        step_name,
        start_time,
        status )

        values( @run_id,
                'Sales_Dw_ETL',
                'silver.load_silver',
                SYSDATETIME(),
                'Running' );
 
        set @log_id = SCOPE_IDENTITY();

        EXEC silver.load_silver @run_id = @run_id;

        update etl.pipeline_log
        set
               end_time= SYSDATETIME(),
               status = 'Success'
        where log_id = @log_id;
       
       ------------------------------------------------
       -- Step 3: Gold
       ------------------------------------------------

       insert into etl.pipeline_log (
       run_id,
       pipeline_name,
       step_name,
       start_time,
       status )

       values( @run_id,
               'Sales_Dw_ETL',
               'gold.load_gold',
               SYSDATETIME(),
               'Running' );
       
       set @log_id = SCOPE_IDENTITY();
       EXEC gold.load_gold @run_id = @run_id;

       update etl.pipeline_log
       set
           end_time = SYSDATETIME(),
           status = 'Success'
       where log_id = @log_id;
       
        ------------------------------------------------
        -- Step 4: Customer Address SCD2
        ------------------------------------------------

        insert into etl.pipeline_log (
        run_id,
        pipeline_name,
        step_name,
        start_time,
        status )

        values( @run_id,
                'Sales_Dw_ETL',
                'gold.load_dim_CustomerAddress_SCD2',
                SYSDATETIME(),
                'Running' );

        set @log_id = SCOPE_IDENTITY();
        EXEC gold.load_dim_CustomerAddress_Scd2 @run_id = @run_id;

        update etl.pipeline_log
        set
             end_time = SYSDATETIME(),
             status = 'Success'
        where log_id = @log_id;

  end try


  begin catch

        update etl.pipeline_log
        set
             end_time = SYSDATETIME(),
             status = 'Failed',
             error_message = ERROR_MESSAGE()
        where log_id = @log_id;

        THROW;

  end catch

  end;

 
