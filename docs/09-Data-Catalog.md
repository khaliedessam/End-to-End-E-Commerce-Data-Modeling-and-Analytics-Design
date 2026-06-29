# 📚 Data Catalog

## Overview

The **Gold Layer** represents the business-ready data model of the Sales Data Warehouse. It consists of conformed **dimension tables** and a centralized **fact table** designed using a **Star Schema** to support reporting, dashboarding, and analytical workloads.

The catalog describes the purpose, structure, and business meaning of every table in the Gold layer.

---

# ⭐ Gold Layer Data Model

## Dimension Tables

| Table                       | Description                                                                      |
| --------------------------- | -------------------------------------------------------------------------------- |
| **gold.dimCustomer**        | Customer master information used for sales analysis.                             |
| **gold.dimCustomerAddress** | Customer address dimension managed using Slowly Changing Dimension (SCD Type 2). |
| **gold.dimProduct**         | Product master with department and product attributes.                           |
| **gold.dimPaymentMethod**   | Payment method lookup dimension.                                                 |
| **gold.dimShippingCompany** | Shipping company reference dimension.                                            |
| **gold.dimDate**            | Calendar dimension supporting time-based analytics.                              |

---

## Fact Tables

| Table              | Description                                                                          |
| ------------------ | ------------------------------------------------------------------------------------ |
| **gold.factSales** | Stores business measures linked to all analytical dimensions . |


---

# 📘 gold.dimCustomer

### Purpose

Stores customer master information used for customer segmentation and sales analysis.

| Column        | Data Type | Description                                                 |
| ------------- | --------- | ----------------------------------------------------------- |
| customer_key  | INT       | Surrogate key of the customer dimension.                    |
| customer_id   | INT       | Original customer identifier from the operational database. |
| customer_name | NVARCHAR  | Full customer name.                                         |
| email         | NVARCHAR  | Customer email address.                                     |
| phone         | NVARCHAR  | Customer phone number.                                      |

---

# 📘 gold.dimCustomerAddress

### Purpose

Stores customer addresses using **Slowly Changing Dimension (Type 2)** to preserve address history.

| Column        | Data Type | Description                                 |
| ------------- | --------- | ------------------------------------------- |
| address_key   | INT       | Surrogate key.                              |
| address_id    | INT       | Original address identifier.                |
| customer_id   | INT       | Related customer identifier.                |
| address_type  | NVARCHAR  | Billing or Shipping address.                |
| address_line1 | NVARCHAR  | Primary street address.                     |
| address_line2 | NVARCHAR  | Secondary address information.              |
| city          | NVARCHAR  | Customer city.                              |
| start_date    | DATETIME  | Record effective start date.                |
| end_date      | DATETIME  | Record expiration date.                     |
| is_current    | BIT       | Indicates the active version of the record. |

---

# 📘 gold.dimProduct

### Purpose

Contains product information used for product performance analysis.

| Column             | Data Type | Description                  |
| ------------------ | --------- | ---------------------------- |
| product_key        | INT       | Surrogate key.               |
| product_id         | INT       | Original product identifier. |
| department_id      | INT       | Department identifier.       |
| department_name    | NVARCHAR  | Product department.          |
| product_name       | NVARCHAR  | Product name.                |
| product_code       | NVARCHAR  | Product code.                |
| brand              | NVARCHAR  | Product brand.               |
| unit_price         | DECIMAL   | Product selling price.       |
| manufacturing_date | DATE      | Product manufacturing date.  |

---

# 📘 gold.dimPaymentMethod

### Purpose

Provides standardized payment method information.

| Column            | Data Type | Description                         |
| ----------------- | --------- | ----------------------------------- |
| paymentmethod_key | INT       | Surrogate key.                      |
| paymentmethod_id  | INT       | Original payment method identifier. |
| method_name       | NVARCHAR  | Payment method name.                |

---

# 📘 gold.dimShippingCompany

### Purpose

Stores shipping company reference information.

| Column             | Data Type | Description                           |
| ------------------ | --------- | ------------------------------------- |
| shipping_key       | INT       | Surrogate key.                        |
| shippingcompany_id | INT       | Original shipping company identifier. |
| company_name       | NVARCHAR  | Shipping company name.                |

---

# 📘 gold.dimDate

### Purpose

Supports time intelligence and period-based reporting.

| Column         | Data Type | Description               |
| -------------- | --------- | ------------------------- |
| date_key       | INT       | Surrogate key (YYYYMMDD). |
| full_date      | DATE      | Calendar date.            |
| day_number     | INT       | Day of month.             |
| month_number   | INT       | Month number.             |
| year_number    | INT       | Calendar year.            |
| month_name     | NVARCHAR  | Month name.               |
| weekday_name   | NVARCHAR  | Weekday name.             |
| quarter_number | INT       | Quarter number.           |
| is_weekend     | BIT       | Weekend indicator.        |

---

# 📊 gold.factSales



### Grain

The grain of factSales is one row per product inside an order.

### Foreign Keys

* customer_key
* address_key
* product_key
* paymentmethod_key
* shipping_key
* date_key

### Measures

* Quantity
* Price At Purchase
* Discount Applied
* Net Amount

| Column            | Data Type | Description                               |
| ----------------- | --------- | ----------------------------------------- |
| customer_key      | INT       | Customer dimension key.                   |
| address_key       | INT       | Customer address key.                     |
| product_key       | INT       | Product dimension key.                    |
| paymentmethod_key | INT       | Payment method dimension key.             |
| shipping_key      | INT       | Shipping company key.                     |
| date_key          | INT       | Date dimension key.                       |
| order_id          | INT       | Source order identifier.                  |
| order_status      | NVARCHAR  | Current order status.                     |
| quantity          | INT       | Quantity purchased.                       |
| price_at_purchase | DECIMAL   | Unit price at transaction time.           |
| discount_applied  | DECIMAL   | Discount amount applied.                  |
| net_amount        | DECIMAL   | Final transaction amount after discounts. |
| payment_status    | NVARCHAR  | Payment status.                           |

---






