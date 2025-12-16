create database lead_fn;
use lead_fn;
CREATE TABLE EmployeeSales (
    EmployeeID INT,
    Name VARCHAR(50),
    Region VARCHAR(50),
    Department VARCHAR(50),
    
    ProductCategory VARCHAR(50),     -- e.g., 'Electronics'
    ProductSubCategory VARCHAR(50),  -- e.g., 'Smartphones'
    ProductID INT,                   -- e.g., 1001 for a specific product

    SaleAmount DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO EmployeeSales (EmployeeID, Name, Region, Department, ProductCategory, ProductSubCategory, ProductID, SaleAmount, SaleDate)
VALUES
-- Employee 101
(101, 'Alice', 'North', 'Electronics', 'Phones', 'Smartphones', 1001, 500.00, '2025-09-01'),
(101, 'Alice', 'North', 'Electronics', 'Phones', 'Smartphones', 1002, 750.00, '2025-09-10'),
(101, 'Alice', 'North', 'Electronics', 'Phones', 'Smartphones', 1003, 650.00, '2025-09-15'),

-- Employee 102
(102, 'Bob', 'South', 'Home Appliances', 'Kitchen', 'Microwaves', 2001, 300.00, '2025-09-03'),
(102, 'Bob', 'South', 'Home Appliances', 'Kitchen', 'Microwaves', 2002, 400.00, '2025-09-08'),
(102, 'Bob', 'South', 'Home Appliances', 'Kitchen', 'Microwaves', 2003, 450.00, '2025-09-20'),

-- Employee 103
(103, 'Charlie', 'West', 'Furniture', 'Office', 'Chairs', 3001, 200.00, '2025-09-05'),
(103, 'Charlie', 'West', 'Furniture', 'Office', 'Chairs', 3002, 220.00, '2025-09-18');

select name,department,saleamount,saledate from EmployeeSales;

Get previous sale amount for each employee:

SELECT 
    EmployeeID,
    SaleAmount,
    LAG(SaleAmount,1,0) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS PreviousSale,
    saleamount-LAG(SaleAmount,1,0) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS difference
FROM EmployeeSales;

Get next sale amount for each employee:
select name,left(name,3) from employeesales;

SELECT 
    EmployeeID,
    SaleAmount,
    LEAD(SaleAmount) OVER (PARTITION by EmployeeID ORDER BY SaleDate) AS NextSale
FROM EmployeeSales;

SELECT 
    EmployeeID,
    SaleAmount,
    LEAD(SaleAmount,1,0) OVER (PARTITION by EmployeeID ORDER BY SaleDate) AS NextSale
FROM EmployeeSales;

-- how they are helpful
Track change in sales, prices, or values over time.


"How much did a product's price change from the last sale?"
SaleAmount - LAG(SaleAmount) OVER (ORDER BY SaleDate)

You can use LEAD and LAG in SQL to calculate percentage change between rows — 
typically to analyze trends like sales growth, price fluctuations, or metric comparisons over time.
((CurrentValue - PreviousValue) / PreviousValue) * 100




SELECT 
    EmployeeID,
    Name,
    SaleDate,
    SaleAmount,
    
    LAG(SaleAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS PrevSaleAmount,

    ROUND(
        (SaleAmount - LAG(SaleAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate))
        / (LAG(SaleAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) )* 100, 2)
     AS PercentageChange
FROM EmployeeSales;

