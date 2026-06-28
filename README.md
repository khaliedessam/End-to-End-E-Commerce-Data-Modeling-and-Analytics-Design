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

## 🏗️ Data Architecture
The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

<p align="center">
    <img src="docs/images/Data_Architecture.png" width="1000">
</p>
