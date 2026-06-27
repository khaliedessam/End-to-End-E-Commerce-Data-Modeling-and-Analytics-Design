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
| **DDL Query for Bronze Layer.sql** | Creates all Bronze staging tables. |
| **Stored Procedures for Bronze Layer.sql** | Loads raw CSV files into the Bronze tables without applying transformations. |

---

# 🥈 Silver Layer

| Script | Purpose |
|---------|---------|
| **DDL Query for Silver Layer.sql** | Creates all Silver layer tables. |
| **Stored Procedures for Silver Layer.sql** | Cleanses and transforms Bronze data into standardized Silver tables. |

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
| **DDL Query for Gold Layer.sql** | Creates the Sales Data Mart including Fact and Dimension tables. |
| **Stored Procedures for Gold Layer.sql** | Loads the Gold layer from the Silver layer using business transformations and surrogate keys. |

---

# 🔄 Slowly Changing Dimensions

| Script | Purpose |
|---------|---------|
| **SCD Type 2 Procedure** | Maintains historical changes for Customer Address using Slowly Changing Dimension Type 2 (SCD2). |

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

# 📊 Analytics Scripts

- Database Exploration
- Dimension Exploration
- Date Exploration
- KPI Analysis
- Magnitude Analysis
- Ranking Analysis
- Change Over Time
- Cumulative Analysis
- Part-to-Whole Analysis
- Performance Analysis
- Customer Segmentation
- Customer Report
- Product Report

---

## Summary

This project includes a complete collection of SQL scripts covering database initialization, ETL pipelines, dimensional modeling, orchestration, scheduling, execution logging, and business analytics.
