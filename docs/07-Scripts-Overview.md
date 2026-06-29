# 📂 SQL Scripts Overview

## Overview

This document provides an overview of all SQL scripts included in the project. The scripts are organized according to the development lifecycle, from database initialization and data ingestion to ETL orchestration and analytical reporting.

---

# 🏗 Database Initialization

| Script | Purpose |
|---------|---------|
| **01_init_database.sql** | Creates the **Sales** database, recreates it if it already exists, and creates the Bronze, Silver, Gold, and ETL schemas. |

---

# 🥉 Bronze Layer

The Bronze layer stores raw source data exactly as received from the **17 CSV source files**.

| Script | Purpose |
|---------|---------|
| **01_ddl_bronze.sql** | Creates all Bronze staging tables. |
| **02_load_bronze.sql** | Loads raw CSV files into the Bronze tables without applying transformations. |

---

# 🥈 Silver Layer

| Script | Purpose |
|---------|---------|
| **01_ddl_silver.sql** | Creates all Silver layer tables. |
| **02_load_silver.sql** | Cleanses and transforms Bronze data into standardized Silver tables. |

### Main Transformations

- NULL handling
- Duplicate removal
- Data type conversion
- Standardization
- Data quality validation
- Derived columns
- Business rule implementation

---

# 🥇 Gold Layer

| Script | Purpose |
|---------|---------|
| **01_ddl_gold.sql** | Creates the Sales Data Mart including Fact and Dimension tables. |
| **02_load_gold.sql** | Loads the Gold layer from the Silver layer using business transformations and surrogate keys. |

---

# 🔄 Slowly Changing Dimensions

| Script | Purpose |
|---------|---------|
| **03_scd2_customer_address** | Maintains historical changes for Customer Address using Slowly Changing Dimension Type 2 (SCD2). |

---

# ⚙ ETL Orchestration

| Script | Purpose |
|---------|---------|
| **etl.run_pipeline** | Executes the complete ETL workflow (Bronze → Silver → Gold). |
| **ETL Log Tables** | Records execution status, timestamps and errors for every ETL run. |

```text
Initialize Database
        │
        ▼
Load Bronze Layer
        │
        ▼
Transform Silver Layer
        │
        ▼
Populate Gold Layer
        │
        ▼
Log Execution
        │
        ▼
Analytics Ready
```

---

# ⏰ SQL Server Agent

The SQL Server Agent job automatically executes:

```sql
EXEC etl.run_pipeline;
```

This provides automated scheduling and execution monitoring.

---

## 📊 Analytics Scripts

| Script                     | Summary                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------- |
| **Database Exploration**   | Explore the data warehouse structure, schemas, tables, views, and metadata.               |
| **Dimension Exploration**  | Analyze dimension tables and validate business attributes.                                |
| **Date Exploration**       | Explore the Date dimension to support time-based analysis and reporting.                  |
| **KPI Analysis**           | Calculate key business metrics such as revenue, orders, customers, and average sales.     |
| **Magnitude Analysis**     | Measure overall business performance across products, customers, and sales.               |
| **Ranking Analysis**       | Rank products, customers, and categories based on business performance.                   |
| **Change Over Time**       | Analyze trends and growth patterns across different time periods.                         |
| **Cumulative Analysis**    | Calculate running totals and cumulative business metrics over time.                       |
| **Part-to-Whole Analysis** | Measure each category's contribution to overall business performance.                     |
| **Performance Analysis**   | Compare actual business performance across different dimensions and periods.              |
| **Customer Segmentation**  | Classify customers into meaningful business segments based on purchasing behavior.        |
| **Customer Report**        | Generate customer-centric reports including sales, orders, and purchasing activity.       |
| **Product Report**         | Generate product performance reports including revenue, quantity sold, and profitability. |


---

## Summary

This project includes a complete collection of SQL scripts covering database initialization, ETL pipelines, dimensional modeling, orchestration, scheduling, execution logging, and business analytics.
