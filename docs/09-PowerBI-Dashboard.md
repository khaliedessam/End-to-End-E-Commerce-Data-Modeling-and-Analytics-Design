# 📊 Power BI Executive Sales Dashboard

## Overview

The final deliverable of this project is an interactive **Power BI Executive Sales Dashboard** built on top of the **Gold Layer** of the SQL Server Data Warehouse.

The dashboard uses the dimensional model created in the Sales Data Mart, including the central **factSales** table and its related dimension tables.

The Power BI dashboard completes the end-to-end data engineering workflow by transforming the Gold Layer data model into an interactive business intelligence solution. It enables stakeholders to monitor sales performance, identify trends, compare customer and product performance, and support data-driven decision-making.

---


The dashboard uses the following Gold Layer tables:

| Table | Purpose |
|------|---------|
| `gold.factSales` | Sales transaction measures and foreign keys |
| `gold.dimCustomer` | Customer information |
| `gold.dimCustomerAddress` | Customer address and city information |
| `gold.dimProduct` | Product and category information |
| `gold.dimDate` | Date attributes for time-based analysis |
| `gold.dimPaymentMethod` | Payment method information |
| `gold.dimShippingCompany` | Shipping company information |

---

## KPI Logic

| KPI | Calculation Scope | Description |
|----|-------------------|-------------|
| **Total Sales** | Paid transactions only | Total revenue generated from successfully paid orders. |
| **Average Order Value** | Paid transactions only | Average revenue per paid order. |
| **Total Quantity** | Paid transactions only | Total quantity sold for paid transactions. |
| **Total Orders** | All payment statuses | Counts all orders including Paid, Refunded, Pending, and Cancelled. |
| **Total Customers** | All relevant customer records | Counts the customers represented in the sales data. |


This design provides a more accurate business view because revenue and quantity should reflect completed paid transactions, while order volume should represent the full operational activity of the business.

---

## Dashboard Features

- Executive KPI cards
- Monthly sales trend analysis
- Sales by product category
- Top 10 cities by sales
- Top 5 best-selling products
- Shipping company sales share
- Top 5 customers by sales
- Year filter
- Category filter

---

## Business Questions Answered

- What is the total paid revenue?
- What is the average order value for paid transactions?
- How many total orders were placed across all payment statuses?
- Which product categories generate the highest sales?
- Which cities contribute the most revenue?
- Which products are the best sellers?
- Which customers generate the highest sales?
- Which shipping companies contribute most to sales activity?

---
## 📥 Dashboard File

The Power BI dashboard file is included in the repository.

👉 **[Open PowerBI Folder](../PowerBI/)**

> Open the downloaded `.pbix` file using **Microsoft Power BI Desktop**.
