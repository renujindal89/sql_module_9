create database wd;
use wd;
drop table sales;
CREATE TABLE sales (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(100) NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    store_name VARCHAR(100) NOT NULL,
    sales DECIMAL(10,2) NOT NULL
);



ALTER TABLE sales ADD COLUMN sale_date DATE;

INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Haryana', 'Karnal', 'Karnal Store 1', 1500.00, '2025-10-01'),
('Haryana', 'Karnal', 'Karnal Store 2', 1300.00, '2025-10-02'),
('Haryana', 'Panipat', 'Panipat Store 1', 1750.00, '2025-10-03'),
('Haryana', 'Panipat', 'Panipat Store 2', 1600.00, '2025-10-04'),
('Haryana', 'Panipat', 'Panipat Store 3', 1550.00, '2025-10-01'),
('Haryana', 'Sonipat', 'Sonipat Store 1', 980.00, '2025-10-02'),
('Haryana', 'KUK', 'KUK Store', 870.00, '2025-10-03'),
('Haryana', 'Karnal', 'Karnal Store 1', 1500.00, '2025-10-04'),
('Haryana', 'Karnal', 'Karnal Store 2', 1300.00, '2025-10-03'),
('Haryana', 'Panipat', 'Panipat Store 1', 1730.00, '2025-10-05');

-- Punjab
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Punjab', 'Patiala', 'Patiala Store', 1200.00, '2025-10-01'),
('Punjab', 'Jalandhar', 'Jalandhar Store', 1300.00, '2025-10-02'),
('Punjab', 'Bathinda', 'Bathinda Store 1', 1100.00, '2025-10-01'),
('Punjab', 'Patiala', 'Patiala Store', 1200.00, '2025-10-02'),
('Punjab', 'Jalandhar', 'Jalandhar Store', 1300.00, '2025-10-03'),
('Punjab', 'Bathinda', 'Bathinda Store 2', 1100.00, '2025-10-02');

select * from sales;

select city_name,store_name,sales from (select *,row_number() 
over (partition by city_name order by sales asc) as r_w,
rank() over (partition by city_name order by sales asc) as rk,
dense_rank() over (partition by city_name order by sales asc) as d_k
from sales)tb1
where d_k=1; 



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

select * from EmployeeSales;

select *,ifnull(round(((saleamount-previous)/previous)*100),0) as percentage from (select department,saleamount,
lead(saleamount,1,0) over (partition by department order by saledate asc) as next,
lag(saleamount,1,0) over (partition by department order by saledate asc) as previous
from EmployeeSales)tb1;