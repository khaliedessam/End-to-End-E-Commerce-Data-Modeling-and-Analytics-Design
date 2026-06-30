# End-to-End Data Engineering and Analytics Project
![SQL Server](https://img.shields.io/badge/SQL%20Server-Data%20Warehouse-blue)
![ETL](https://img.shields.io/badge/ETL-Bronze%20%7C%20Silver%20%7C%20Gold-green)
![Analytics](https://img.shields.io/badge/Analytics-SQL-orange)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)

Welcome to the Data Engineering and Analytics Project repository. This project demonstrates a comprehensive end-to-end data engineering solution — from business analysis and relational database design to building a modern data warehouse and generating actionable insights. It highlights industry best practices in data engineering and analytics.

## 📖 Project Overview

The project involves:

1. **Business Analysis**: Understanding the business requirements, identifying core business entities, and defining their relationships.
2. **Data Modeling**: Designing a conceptual ERD, resolving many-to-many relationships using bridge tables, and implementing a normalized Third Normal Form (3NF) operational database.
3. **Data Warehouse Architecture**: Building a Medallion Architecture (Bronze, Silver, and Gold) to organize raw, cleansed, and business-ready data.
4. **ETL Pipelines**: Developing automated stored procedures to extract, cleanse, transform, and load data from  source files into the Data Warehouse.
5. **Dimensional Modeling**: Designing a Sales Data Mart using a Star Schema with fact and dimension tables optimized for analytical workloads.
6. **Data Quality & Governance**: Applying validation rules, execution logging, Slowly Changing Dimension (SCD Type 2), indexing, and ETL monitoring to ensure data reliability.
7. **ETL Automation**: Scheduling the complete ETL pipeline using SQL Server Agent for automated daily execution and monitoring.
8. **Analytics & Reporting**: Developing SQL-based analytical reports and KPIs to deliver business insights.

## Project Development Workflow
```text
Business Case Understanding
        |
        v
Identify Main Business Entities
        |
        v
Create ERD and Define Relationships
        |
        v
Resolve Many-to-Many Relationships Using Bridge Tables
        |
        v
Apply 3NF Normalization for the Operational Model
        |
        v
Design Data Warehouse Model
        |
        v
Build Star Schema with Facts and Dimensions
        |
        v
Develop ETL Pipeline and Analytics Reports
```
This workflow shows both sides of the data engineering process:

- **Operational database design** using ERD, relationship modeling, bridge tables, and 3NF normalization.
- **Analytical database design** using dimensional modeling, star schema, fact tables, dimension tables, and historical tracking.

- ## 📂 Repository Structure

```text
End-to-End-E-Commerce-Data-Modeling-and-Analytics-Design/
│
├── Datasets/                                       # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                                           # Project documentation
│   ├── images/                                     # Diagrams and screenshots
│   │   ├── Conceptual Data Modeling.png
│   │   ├── Normalized OLTP Schema.png
│   │   ├── Data_Architecture.png
│   │   ├── Star Schema Model.png
│   │   ├── ETL_Process.png
│   │   ├── ETL_Table_Logs.png
│   │   └── Power_BI_Dashboard.png
│   │
│   ├── 01-business_case.md                         # Business requirements and project scope
│   ├── 02-Conceptual-Data-Model.md                 # Conceptual Entity Relationship Diagram (ERD)
│   ├── 03-Logical-Data-Model.md                    # Normalized OLTP database design (3NF)
│   ├── 04-Data-Warehouse-Architecture.md           # Medallion Architecture (Bronze, Silver, Gold)
│   ├── 05-Dimensional-Model.md                     # Sales Data Mart (Star Schema)
│   ├── 06-etl_process.md                           # ETL pipeline implementation
│   ├── 07-Scripts-Overview.md                      # SQL scripts documentation
│   ├── 08-Data-Catalog.md                          # Catalog of datasets, including field descriptions and metadata
│   └── 09-PowerBI-Dashboard.md                     # Power BI dashboard documentation
│
├── Scripts/                                        # SQL implementation
│   ├── 00_init/                                    # Database creation, schemas and initialization
│   ├── 01_bronze/                                  # Scripts for extracting and loading raw data
│   ├── 02_silver/                                  # Scripts for cleaning and transforming data
│   ├── 03_gold/                                    # Scripts for creating analytical models
│   ├── 04_etl/                                     # Master ETL pipeline and logging
│   ├── 05_checks/                                  # Data quality validation 
│   └── 06_analytics/                               # Scripts for analytical SQL queries
│
├── PowerBi/                                        # Power BI dashboard
│   └── Executive_Sales_Dashboard.pbix
│
│
├── README.md                                        # Project overview and navigation
└── LICENSE 
```

## 🏗️ Data Architecture
The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

![Data Architecture](docs/images/Data_Architecture.png)


## 🚀 How to Run the Project

### 🛠️ Prerequisites

Before running the project, install:

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Desktop
- Draw.io (for creating architecture diagrams)

---

### Step 1: Prepare the Source Data

Download or clone this repository and ensure the **Source** CSV files are available in the **Datasets** folder.

> **Note:** Update the CSV file paths in the Bronze layer stored procedures to point to your local **Datasets** directory before executing the ETL pipeline.

---

### Step 2: Execute the SQL Scripts

Run the SQL scripts in the following order.

#### 📁 00_init

Creates the **Sales** database and required schemas.

```text
Scripts/
└── 00_init/
    └── 01_init_database.sql
```

---

#### 📁 01_bronze

Creates the Bronze tables and loads the **Source** CSV files.

```text
Scripts/
└── 01_bronze/
    ├── 01_ddl_bronze.sql
    └── 02_load_bronze.sql
```

---

#### 📁 02_silver

Creates the Silver tables and performs data cleansing, standardization, and transformations.

```text
Scripts/
└── 02_silver/
    ├── 01_ddl_silver.sql
    └── 02_load_silver.sql
```

---

#### 📁 03_gold

Creates the analytical layer including dimensions, fact tables, and business transformations.

```text
Scripts/
└── 03_gold/
    ├── 01_ddl_gold.sql
    ├── 02_load_gold.sql
    ├── 03_scd2_customer_address.sql
    
```

---

#### 📁 04_etl

Creates the ETL logging tables and executes the complete ETL pipeline.

```text
Scripts/
└── 04_etl/
    ├── 01_ddl_etl_logging_tables.sql
    ├── 02_run_pipeline_procedure.sql
    └── 03_execute_pipeline.sql
```

---

#### 📁 05_checks

Runs validation queries and verifies data quality.

```text
Scripts/
└── 05_checks/
   
```

---

#### 📁 06_analytics

Execute the analytical SQL scripts to generate business insights and validate the Gold layer.

```text
Scripts/
└── 06_analytics/
   
```

---

### Step 3: Verify the ETL Pipeline

After executing the ETL process:

- Verify that the Bronze, Silver, and Gold tables are populated successfully.
- Review the ETL logging tables to confirm successful execution.

---
### Step 4: Configure SQL Server Agent

Create a new **SQL Server Agent Job** to automate the ETL pipeline.

Configure the job with the following settings:

- **Job Name:** `Master ETL Pipeline`
- **Step Type:** Transact-SQL Script (T-SQL)
- **Database:** `Sales`
- **Command:**

```sql
EXEC etl.run_pipeline;

---
### Step 5: Open the Power BI Dashboard

Open the Power BI report located in:

```text
PowerBi/
└── Executive_Sales_Dashboard.pbix
```

Refresh the report to connect to the SQL Server **Gold** layer and explore the interactive dashboard.
