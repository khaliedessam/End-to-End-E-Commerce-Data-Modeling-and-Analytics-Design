# ShopEase E-Commerce Business Case

## Overview

ShopEase is an online e-commerce platform that sells electronics, fashion, accessories, and home products. This business case describes the core domain, entities, relationships, and constraints needed to design a complete data model for ShopEase.

The goal of this document is to:

- describe the business requirements
- extract entities and attributes
- identify relationships and cardinalities
- outline an Entity-Relationship Diagram (ERD)
- define a relational schema
- apply normalization up to Third Normal Form (3NF)

## Business Requirements

### Customers

- Customers register on the platform using email and phone number.
- Each customer can have multiple delivery addresses, including home and work addresses.
- Customers place orders consisting of one or more products.
- Customers can write reviews for purchased products.

### Products and Departments

- ShopEase operates multiple departments such as Electronics, Fashion, and Home Appliances.
- Each department contains many products.
- Each product belongs to exactly one department.
- A product has the following key attributes:
  - Product code
  - Name
  - Description
  - Unit price
  - Stock quantity
  - Brand
  - Manufacturing date

### Suppliers

- Products are supplied by multiple suppliers.
- A supplier can supply many products.
- A product may be supplied by multiple suppliers depending on availability and price agreements.

### Orders

- Customers place orders through the website.
- Each order is created by a single customer.
- Each order contains one or more products.
- Order-specific information includes:
  - Order date
  - Shipping address
  - Payment method
  - Order status (Pending, Shipped, Delivered, Cancelled)
  - Total amount

### Order Details

- Because orders can contain multiple products, the system tracks order details for each product in an order.
- Order details capture:
  - Quantity of each product
  - Price at purchase time
  - Discount applied

### Payments

- ShopEase supports different payment methods such as credit card, wallet, and cash on delivery.
- Each order has one payment transaction.
- Payment information includes:
  - Payment date
  - Paid amount
  - Payment status
  - Transaction reference number

### Shipping

- Orders are delivered by shipping companies such as DHL or Aramex.
- A shipping company can deliver many orders.
- Each order is delivered by one shipping company.

### Reviews

- Customers can post reviews for products.
- A customer can review many products.
- A product can receive many reviews.

### Promotions

- Some products may have promotions or discounts during specific periods.
- A promotion can apply to many products.
- A product can participate in multiple promotions over time.

### Employees

- Employees manage ShopEase operations.
- Each employee belongs to one department.
- An employee record includes:
  - Employee name
  - Job title
  - Hire date
  - Salary

### Warehouses 
- Each warehouse stores many products.
- One product can exist in multiple warehouses with different quantities.

## Extracted Entities and Attributes

### Core Entities

- Customer
- Address
- Department
- Product
- Supplier
- Order
- OrderDetail
- PaymentMethod
- PaymentTransaction
- ShippingCompany
- Promotion
- Employee
- Warehouse
- Review (Bridge: Customer M:M Product)
- ProductSupplier (Bridge: Product M:M Supplier)
- ProductPromotion (Bridge: Product M:M Promotion)
- Inventory (Bridge: Product M:M Warehouse)


### Key Attributes by Entity

**Customer**
- CustomerID
- Email
- PhoneNumber
- CustomerName

**Address**
- AddressID
- CustomerID
- AddressType
- Address1
- Address2
- City

**Department**
- DepartmentID
- DepartmentName

**Product**
- ProductID
- DepartmentID
- ProductCode
- ProductName
- Description
- UnitPrice
- StockQuantity
- Brand
- ManufacturingDate

**Supplier**
- SupplierID
- Name
- City
- PhoneNumber


**Order**
- OrderID
- CustomerID
- ShippingAddressID
- ShippingCompanyID
- OrderDate
- OrderStatus
- TotalAmount

**OrderDetail**
- OrderDetailID
- OrderID
- ProductID
- Quantity
- PriceAtPurchase
- Discount

**PaymentTransaction**
- TransactionID
- OrderID
- PaymentMethodID
- PaymentDate
- PaidAmount
- PaymentStatus
- TransactionReference

**PaymentMethod**
- PaymentMethodID
- MethodName

**ShippingCompany**
- ShippingCompanyID
- CompanyName

**Review**
- ReviewID
- CustomerID
- ProductID
- Rating
- Comment
- ReviewDate

**Promotion**
- PromotionID
- PromotionCode
- PromotionName
- DiscountValue
- StartDate
- EndDate

**Employee**
- EmployeeID
- DepartmentID
- EmployeeName
- JobTitle
- HireDate
- Salary
- Phone


**Warehouse**
- WarehouseID
- WarehouseName
- City
- Country

### Bridge Table Attributes

**Review** (Customer M:M Product)
- ReviewID
- CustomerID
- ProductID
- Rating
- Comment
- ReviewDate

**ProductSupplier** (Product M:M Supplier)
- ProductSupplierID
- ProductID
- SupplierID
- SupplierPrice
- SupplyStatus

**ProductPromotion** (Product M:M Promotion)
- ProductPromotionID
- ProductID
- PromotionID

**Inventory** (Product M:M Warehouse)
- InventoryID
- ProductID
- WarehouseID
- Quantity
- LastUpdated



## Relationships and Cardinality

- Customer 1:M Address
- Department 1:M Product
- Supplier M:M Product (via ProductSupplier)
- Customer 1:M Order
- Order 1:M OrderDetail
- Product 1:M OrderDetail
- Order 1:1 PaymentTransaction
- ShippingCompany 1:M Order
- Customer M:M Product (via Review)
- Promotion M:M Product (via ProductPromotion)
- Department 1:M Employee
- Product M:M Warehouse (via Inventory)

### Relationship Notes

- A product belongs to one department, but a department has many products.
- OrderDetail is an associative entity connecting orders and products with quantity, price, and discount.
- Review is a bridge table implementing the many-to-many relationship between customers and products, capturing customer feedback.
- ProductSupplier is a bridge table implementing the many-to-many relationship between products and suppliers, storing supplier pricing and availability.
- ProductPromotion is a bridge table implementing the many-to-many relationship between products and promotions, capturing time-based discounts.
- Inventory is a bridge table implementing the many-to-many relationship between products and warehouses, tracking stock levels across locations.

## ERD Outline

The ERD for ShopEase includes the entities above and the relationships between them. This document is intended as the primary business case for the repository, with the ERD itself available visually as a diagram in project documentation or modelling tools.

Key ERD elements:

- Customer -> Address
- Customer -> Order -> OrderDetail -> Product
- Order -> Payment
- Order -> ShippingCompany
- Product <-> Supplier (via ProductSupplier)
- Product <-> Customer (via Review)
- Product <-> Promotion (via ProductPromotion)
- Product <-> Warehouse (via Inventory)
- Department -> Product
- Department -> Employee

## Relational Schema

The relational schema is designed to support data consistency and analytic reporting.

### Tables and Primary Keys

- Customers(CustomerID)
- Addresses(AddressID)
- Departments(DepartmentID)
- Products(ProductID)
- Suppliers(SupplierID)
- Orders(OrderID)
- OrderDetails(OrderDetailID)
- PaymentMethods(PaymentMethodID)
- PaymentTransactions(TransactionID)
- ShippingCompanies(ShippingCompanyID)
- Promotions(PromotionID)
- Employees(EmployeeID)
- Warehouses(WarehouseID)

### Bridge Tables

- Reviews(ReviewID) - Customer M:M Product
- ProductSuppliers(ProductSupplierID) - Product M:M Supplier
- ProductPromotions(ProductPromotionID) - Product M:M Promotion
- Inventory(InventoryID) - Product M:M Warehouse

### Bridge Table Details

**Reviews**
- ReviewID (PK)
- CustomerID (FK)
- ProductID (FK)
- Rating
- Comment
- ReviewDate

**ProductSuppliers**
- ProductSupplierID (PK)
- ProductID (FK)
- SupplierID (FK)
- SupplierPrice
- SupplyStatus

**ProductPromotions**
- ProductPromotionID (PK)
- ProductID (FK)
- PromotionID (FK)

**Inventory**
- InventoryID (PK)
- ProductID (FK)
- WarehouseID (FK)
- Quantity
- LastUpdated

## Normalization Summary

### First Normal Form (1NF)

- All entities store atomic values.
- Repeating groups are removed by creating bridge and associative tables: `Address`, `OrderDetail`, `Reviews`, `ProductSuppliers`, `ProductPromotions`, and `Inventory`.

### Second Normal Form (2NF)

- Each non-key attribute depends on the whole primary key.
- Associative tables such as `OrderDetails` and `ProductSuppliers` use composite or surrogate keys to avoid partial dependency.

### Third Normal Form (3NF)

- Non-key attributes are not transitively dependent on the primary key.
- `Customer` contact details, `ShippingCompany` details, and `Promotion` criteria are separated into distinct relations.
- Many-to-many relationships are implemented through associative tables, ensuring each fact is stored once.

## How to Use This Document

This business case should be the first reference for anyone exploring the ShopEase project. It captures the key domain concepts, the expected data relationships, and the design principles needed to convert the business needs into a robust data model.

Use this file to:

- understand the business domain
- validate entity and relationship extraction
- verify cardinality assumptions
- compare against the ERD and schema implementation
- confirm normalization decisions

---

