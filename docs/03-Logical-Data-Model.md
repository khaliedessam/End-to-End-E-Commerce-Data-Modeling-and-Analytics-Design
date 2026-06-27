# 🗄️ Logical Data Model (3NF)

## Overview

After validating the conceptual data model, the next step was to transform the business requirements into a fully normalized **Operational Database (OLTP)**.

The logical model introduces primary keys, foreign keys, bridge tables, and business constraints to ensure data integrity while eliminating redundancy through **Third Normal Form (3NF)**.

---
## Normalized OLTP Database Schema

The following diagram illustrates the logical database design after applying Third Normal Form (3NF). 

![Normalized OLTP Schema](images/Normalized_OLTP_Schema.png)

## Objectives

The logical data model was designed to:

- Convert the conceptual model into an implementable database design.
- Eliminate data redundancy using **Third Normal Form (3NF)**.
- Resolve all many-to-many relationships using bridge tables.
- Create a scalable transactional database for daily business operations.

---

## Normalization Strategy

The operational database follows **Third Normal Form (3NF)**.

### Benefits

- Reduce data redundancy.
- Improve data consistency.

---

## Bridge Tables

The following many-to-many relationships identified during conceptual modeling were resolved using bridge tables:

| Business Relationship | Bridge Table |
|----------------------|--------------|
| Product ↔ Supplier | ProductSupplier |
| Product ↔ Promotion | ProductPromotion |
| Product ↔ Warehouse | Inventory |
| Customer ↔ Product | Review |
| Order ↔ Product | OrderDetail |

---

## Main Business Entities

The normalized schema includes:

- Customer
- CustomerAddress
- Orders
- OrderDetail
- Product
- Department
- Employee
- Supplier
- ProductSupplier
- Warehouse
- Inventory
- Promotion
- ProductPromotion
- ShippingCompany
- PaymentMethod
- PaymentTransaction
- Review

---

---



## Next Step

Once the logical design is complete, the project transitions from database modeling to implementation. During this phase, the normalized OLTP database is physically built in SQL Server by creating all tables, relationships, primary and foreign keys, constraints, and bridge tables defined in the logical model. This operational database provides the foundation for the ETL pipeline and the analytical Data Warehouse developed in the following stages.
