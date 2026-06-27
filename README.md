# End-to-End-E-Commerce-Data-Modeling-and-Analytics-Design

## Project Overview

This repository documents a full e-commerce data warehouse project built on SQL Server. It covers the business case, entity relationship modeling, operational normalization, medallion architecture, ETL pipeline orchestration, and analytics reporting.

## Recommended Diagram Placement

The diagrams should appear where they best support the text:

- **Conceptual Model**: next to the entity/cardiinality explanation.
- **Normalized OLTP Schema**: next to the 3NF operational model description.
- **Medallion Architecture**: next to the Bronze/Silver/Gold layer explanation.
- **Star Schema / Sales Data Mart**: next to the Gold layer / analytics description.

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

## Conceptual Data Model

The conceptual diagram illustrates the high-level e-commerce entities, relationships, and cardinalities.

![OLTP Data Model](docs/Conceptual%20Data%20Modeling.drawio.png)

## Normalized OLTP Model

The normalized transactional model shows the 3NF structure used in the operational layer.

![OLTP Normalized Schema](docs/Normalized%20OLTP%20Schema.png)

## Medallion Data Warehouse Architecture

This architecture diagram explains how raw source data flows through the Bronze, Silver, and Gold layers into analytics consumption.

![Data Warehouse Medallion Architecture](docs/Data_Architecture.png)

## Star Schema and Sales Data Mart

The star schema diagram shows the fact sales table and related dimension tables used for reporting.

![Sales Data Mart](docs/Star%20Schema%20Model.png)

## Scripts and ETL Flow

The SQL scripts are organized into the following layers:

- `Scripts/Bronze Layer` — raw ingestion and bronze staging tables
- `Scripts/Silver Layer` — cleansed, standardized silver tables
- `Scripts/Gold Layer` — dimensional model, SCD2 logic, and fact loading
- `Scripts/ETL` — pipeline orchestration and logging
- `Scripts/Analytics` — reporting and exploration queries

## My Opinion

Yes — adding the diagrams in the README is a good idea because it helps readers immediately understand each architectural phase. If you want to keep the README clean, you can also provide thumbnails here and link to a dedicated `docs/` diagram page for more detail.
