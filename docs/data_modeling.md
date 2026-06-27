# Data Modeling Approach

This project includes both operational data modeling and analytical data modeling.

## 1. Business Case Understanding

The first step is understanding the business case and the questions the data should answer. This helps define the important business concepts, processes, and reporting goals.

## 2. Main Entity Extraction

After understanding the business case, the main entities are identified. These entities represent the core business objects that need to be stored and analyzed.

Examples of typical entities in a sales data model include:

- Customers
- Products
- Sales Orders
- Order Details
- Addresses
- Categories
- Dates

## 3. ERD Design

An Entity Relationship Diagram is created to describe:

- Entities
- Attributes
- Primary keys
- Foreign keys
- One-to-many relationships
- Many-to-many relationships

## 4. Resolving Many-to-Many Relationships

Many-to-many relationships are resolved by creating bridge tables. This improves the relational structure and makes the model easier to maintain and query.

Example pattern:

```text
Entity A  ---< Bridge Table >---  Entity B
```

## 5. 3NF Normalization

The operational model is normalized to Third Normal Form (3NF). This step helps:

- Reduce duplicate data
- Improve data consistency
- Separate entities clearly
- Protect data integrity
- Support reliable source-system design

## 6. Data Warehouse Modeling

After the normalized operational design, the project moves to Data Warehouse modeling. The analytical model is designed differently from the operational model because it is optimized for reporting and analysis.

## 7. Star Schema Design

The Gold layer uses a star schema. This design contains:

- Fact tables for measurable business events
- Dimension tables for descriptive business context

The star schema makes analytical queries easier, faster, and more business-friendly.

## 8. Historical Tracking

The project includes Slowly Changing Dimension Type 2 logic for customer address history. This allows the warehouse to preserve old customer address values while keeping the current version active.

