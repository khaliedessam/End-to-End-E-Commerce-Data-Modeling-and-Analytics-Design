/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/


--Determine Range Of Revenue Based on Customer
WITH Customer_Revenue AS (
select Customer_Key,
       sum(NetAmount) as Total_Revenue
from gold.fact_sales
group by Customer_Key
  )

select 
       Min(Total_Revenue) as Min_Revenue,
       Max(Total_Revenue) as Max_Revenue,
       Avg(Total_Revenue) as Avg_Revenue
from Customer_Revenue

--1. Customer Segmentation by Total_Spending (Revenue)
                 --VIP     = highest spending customers
                 --Regular = medium spending customers
                 --New     = low spending customers

WITH Customer_Segment AS (
select c.Customer_Key,
       c.CustomerName,
       sum(NetAmount) as Total_Spending
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
group by c.Customer_Key,c.CustomerName )

select
       Customer_Key,
       CustomerName,
       Total_Spending,
       CASE WHEN Total_Spending >= 1250000 THEN 'Vip'
            WHEN Total_Spending >= 760000 THEN 'Regular'
            ELSE 'New'
       END AS Customer_Segment
from Customer_Segment
order by Total_Spending desc

--Total Number Of Customers Based On Customer_Segment

WITH Customer_Segment AS (
select c.Customer_Key,
       c.CustomerName,
       sum(NetAmount) as Total_Spending
from gold.fact_sales f
left join gold.dim_customer c
on f.Customer_Key = c.Customer_Key
group by c.Customer_Key,c.CustomerName ),

 Total_Customer AS (
select
       Customer_Key,
       CustomerName,
       Total_Spending,
       CASE WHEN Total_Spending >= 1250000 THEN 'Vip'
            WHEN Total_Spending >= 760000 THEN 'Regular'
            ELSE 'New'
       END AS Customer_Segment
from Customer_Segment )

select 
       Customer_Segment,
       count(Customer_Segment) as Total_Customers
from Total_Customer
     group by Customer_Segment
     order by Total_Customers desc 


/*---------------------------------------------------------------
Product Segmentation - ABC Analysis

Purpose:
Segment products based on their contribution to total revenue.

Logic:
A Products = Products contributing to first 80% of revenue
B Products = Products contributing to next 15% of revenue
C Products = Products contributing to last 5% of revenue

----------------------------------------------------------------*/

WITH Product_Revenue AS (
select
        p.ProductID,
        p.ProductName,
        sum(f.NetAmount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
group by p.ProductID,p.ProductName ),

 Revenue_Percentage_Cumulative AS (

select
           ProductID,
           ProductName,
           Total_Revenue,
           sum(Total_Revenue) over () as Overall_Revenue,
           Total_Revenue*100 / sum(Total_Revenue) over () as Revenue_Percentage
from Product_Revenue ),

Product_Segment AS (

select
           ProductID,
           ProductName,
           Total_Revenue,
           Overall_Revenue,
           Revenue_Percentage,
           sum(Revenue_Percentage) over (order by Total_Revenue desc) as Cumulative_Percentage
from Revenue_Percentage_Cumulative )

select
         ProductID,
         ProductName,
         Total_Revenue,
         Overall_Revenue,
         Revenue_Percentage,
         Cumulative_Percentage,
         CASE WHEN Cumulative_Percentage <= 80 THEN 'A - High Revenue Products'
              WHEN Cumulative_Percentage <= 95 THEN 'B - Medium Revenue Products'
              ELSE 'C - Low Revenue Products'
         END AS Product_Segment
from Product_Segment
order by Total_Revenue desc

--------------------------------------------------------


--RFM Customer Analysis (Recenecy,Frequency and Monetary)

select
         f.Customer_Key,
         max(d.FullDate) as Last_Order_Date,
         DATEDIFF(month,max(d.FullDate),GETDATE()) as Recency,
         count(distinct f.OrderID) as Frequency,
         sum(f.NetAmount) as Monetary
from gold.fact_sales f
left join gold.dim_date d
on f.DateKey = d.DateKey
group by f.Customer_Key
order by Monetary desc


--3. Department Segmentation by Revenue In Millions 

WITH Department_Segment AS (
select
        p.DepartmentID,
        p.DepartmentName,
        sum(f.NetAmount)/1000000 as Revenue
from gold.fact_sales f
left join gold.dim_product p
on f.Product_Key = p.Product_Key
group by p.DepartmentID,p.DepartmentName )

select
          DepartmentID,
          DepartmentName,
          Revenue,
          CASE WHEN Revenue >= 800 THEN 'High Reveune'
               WHEN Revenue >= 750 THEN 'Mid Reveune'
               ELSE 'Low Revenue'
          END AS 'Department_Segment'
from Department_Segment
group by DepartmentID,DepartmentName,Revenue
order by Revenue desc

---------------------------------------------------

