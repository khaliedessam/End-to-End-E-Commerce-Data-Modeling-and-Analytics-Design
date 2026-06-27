# ⭐ Dimensional Model (Sales Data Mart)

## Overview

After implementing the Data Warehouse architecture, the next step is designing the analytical model using **Dimensional Modeling**.

This project focuses on the **Sales** business process by implementing a **Sales Data Mart**. The model follows a **Star Schema**, organizing business data into a central fact table surrounded by descriptive dimension tables.

---

## Sales Data Mart

<p align="center">
  <img src="images/Star Schema Model.png" alt="Sales Data Mart" width="1000">
</p>

---

## Design Objectives

- Build an analytics-ready data model.
- Organize data into Fact and Dimension tables.
- Improve query performance.
- Simplify business analysis.
- Support historical tracking using SCD Type 2.

## Fact Table

### factSales

The **factSales** table stores quantitative sales transactions and references all dimension tables through surrogate keys. It includes measures such as Quantity, Price at Purchase, Discount Applied, Net Amount, Order Status, and Payment Status.

## Dimension Tables

| Dimension | Description |
|-----------|-------------|
| dimCustomer | Customer information |
| dimCustomerAddress | Customer address history (SCD Type 2) |
| dimProduct | Product details |
| dimPaymentMethod | Payment methods |
| dimShippingCompany | Shipping providers |
| dimDate | Calendar and time attributes |

## Design Features

- Star Schema
- Surrogate Keys
- Slowly Changing Dimension (Type 2)
- Analytics-optimized structure

## Why a Sales Data Mart?

Although the operational database supports multiple business processes, this project focuses on the **Sales** domain. This approach demonstrates dimensional modeling while providing a scalable foundation for future data marts such as Inventory, Finance, and HR.

## Next Step

The next phase implements the ETL pipeline to populate the Sales Data Mart from the Bronze, Silver, and Gold layers.
