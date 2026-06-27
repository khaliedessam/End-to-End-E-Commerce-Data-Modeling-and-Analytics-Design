# 🗄️ Logical Data Model (3NF)

## Overview

After validating the conceptual data model, the next step was to transform the business requirements into a fully normalized **Operational Database (OLTP)**.

The logical model introduces primary keys, foreign keys, bridge tables, and business constraints to ensure data integrity while eliminating redundancy through **Third Normal Form (3NF)**.

---

## Objectives

The logical data model was designed to:

- Convert the conceptual model into an implementable database design.
- Eliminate data redundancy using **Third Normal Form (3NF)**.
- Enforce referential integrity through primary and foreign keys.
- Resolve all many-to-many relationships using bridge tables.
- Create a scalable transactional database for daily business operations.

---

## Normalization Strategy

The operational database follows **Third Normal Form (3NF)**.

### Benefits

- Reduce data redundancy.
- Improve data consistency.
- Prevent update, insert, and delete anomalies.
- Simplify maintenance.
- Ensure referential integrity.

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

## Logical Data Model (OLTP)

<p align="center">
  <img src="images/Normalized_OLTP_Schema.png" alt="Normalized OLTP Schema" width="1000">
</p>

> **Note:** Rename your image to `Normalized_OLTP_Schema.png` and place it inside `docs/images/`.

---

## Key Design Decisions

- Third Normal Form (3NF) applied across the operational database.
- Bridge tables resolve many-to-many relationships.
- Primary and foreign keys enforce referential integrity.
- Operational schema optimized for transactional workloads (OLTP).

---

## Next Step

After completing the normalized operational database, the project transitions to designing the **Data Warehouse** using the **Medallion Architecture (Bronze → Silver → Gold)** and a dimensional **Star Schema** optimized for analytics.
