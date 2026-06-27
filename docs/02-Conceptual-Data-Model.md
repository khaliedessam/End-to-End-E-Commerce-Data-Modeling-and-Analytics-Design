# Conceptual Data Model (ERD)

## Overview

The conceptual data model represents the first stage of the database design process. It captures the core business entities, their relationships, and the business rules that govern how data flows through the e-commerce system.

At this stage, the focus is on understanding the business rather than the physical implementation. The model identifies the major entities involved in the sales process and illustrates how they interact without considering database-specific details such as data types, indexes, or constraints.

---

## Objectives

The conceptual model was created to:

- Understand the business domain.
- Identify the core business entities.
- Define relationships between entities.
- Capture business rules.
- Discover many-to-many relationships before logical design.
- Provide the foundation for the normalized OLTP database.

---

## Business Entities

The model includes the primary entities required to support the e-commerce business:

- Customer
- Address
- Order
- Order Detail
- Product
- Promotion
- Supplier
- Warehouse
- Department
- Employee
- Shipping Company
- Payment Method
- Payment Transaction

---

## Relationship Analysis

The ERD defines how each business entity interacts with the others. During this phase, several many-to-many (M:N) relationships were identified, including:

| Relationship | Resolution |
|--------------|------------|
| Customer ↔ Product | Review |
| Product ↔ Promotion | ProductPromotion Bridge |
| Product ↔ Supplier | ProductSupplier Bridge |
| Product ↔ Warehouse | Inventory Bridge |

These relationships are resolved later during the logical data modeling phase by introducing bridge (junction) tables.

---

## Design Principles

The conceptual model follows these principles:

- Business-oriented design
- Technology-independent representation
- Clear entity boundaries
- Explicit relationship cardinalities
- Foundation for normalization

---

## Conceptual ERD

> Place the following image inside the repository:

```text
images/conceptual_erd.png
```

![Conceptual ERD](../images/conceptual_erd.png)

---

## Next Step

After validating the conceptual model, the design progresses to the **Logical Data Model**, where:

- Many-to-many relationships are resolved.
- Primary and foreign keys are introduced.
- Bridge tables are created.
- The database is normalized to Third Normal Form (3NF).
