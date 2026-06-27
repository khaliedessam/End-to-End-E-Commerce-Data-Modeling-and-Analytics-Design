# 🏗️ Data Warehouse Architecture

## Overview

After implementing the normalized operational database (OLTP), the project transitions to building the analytical Data Warehouse. The solution adopts the **Medallion Architecture**, organizing data into three layers—**Bronze**, **Silver**, and **Gold**—to improve data quality, simplify transformations, and provide business-ready data for reporting and analytics.

---

## Data Warehouse Architecture

<p align="center">
    <img src="images/Data_Architecture.png"
         alt="Data Warehouse Architecture"
         width="1000">
</p>

<p align="center">
<i>Figure 1. Data Warehouse Architecture using the Medallion Architecture.</i>
</p>

---

## Architecture Layers

### 📥 Source Systems

The Data Warehouse integrates data from multiple operational sources:

- CRM System
- ERP System
- CSV Files

These sources provide transactional and reference data that is ingested through batch ETL processes.

---

### 🥉 Bronze Layer (Raw Data)

The Bronze layer stores the raw data exactly as received from the source systems.

**Responsibilities**

- Load all source CSV files
- Preserve raw data without modifications
- Perform full batch loading
- Maintain an audit-ready copy of source data

---

### 🥈 Silver Layer (Cleaned Data)

The Silver layer improves data quality by applying cleansing and standardization rules.

**Responsibilities**

- Data cleansing
- NULL value handling
- Remove duplicate records
- Data type conversion
- Standardize formats
- Data enrichment
- Apply quality validation rules

---

### 🥇 Gold Layer (Business-Ready Data)

The Gold layer transforms the cleaned data into a dimensional model optimized for analytical workloads.

**Responsibilities**

- Build the Sales Data Mart
- Create Fact and Dimension tables
- Generate surrogate keys
- Apply business rules
- Implement Slowly Changing Dimension (SCD Type 2)
- Optimize data for reporting and analytics

---

## Consumption Layer

The Gold layer supports:

- Business Intelligence (BI) Dashboards
- SQL Reporting
- Ad-hoc Analytical Queries
- Machine Learning and Predictive Analytics

---

## Infrastructure & Orchestration

The Data Warehouse is implemented in **SQL Server** and orchestrated through automated ETL pipelines.

**Key Components**

- SQL Server
- ETL / ELT Pipelines
- Data Quality Validation
- ETL Execution Logging
- Scheduling (SQL Server Agent)
- Monitoring

---

## Benefits

- Layered and scalable architecture
- Improved data quality and consistency
- Separation of raw, cleansed, and analytical data
- Optimized performance for analytics
- Reliable foundation for business intelligence

---

## Next Step

The next phase implements the ETL pipeline, which automates data extraction, transformation, and loading across the Bronze, Silver, and Gold layers.
