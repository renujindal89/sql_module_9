-- FINAL---
USE MODULE9WINDOW;
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

-- Himachal
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Himachal', 'solan', 'solan store', 900.00, '2025-10-01'),
('Himachal', 'mandi', 'mandi store', 850.00, '2025-10-01'),
('Himachal', 'dharamshala', 'dharamshalaStore', 900.00, '2025-10-01'),
('Himachal', 'mandi', 'mandi Store', 800.00, '2025-10-02'),
('Himachal', 'dharamshala', 'dharamshala Store', 900.00, '2025-10-02');

-- Jammu
INSERT INTO sales (state_name, city_name, store_name, sales, sale_date) VALUES
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-01'),
('Jammu', 'Jawalaji', 'Jawalaji Store ', 900.00, '2025-10-01'),
('Jammu', 'Rohtang', 'Rohtang Store ', 900.00, '2025-10-01'),
('Jammu', 'Shimla', 'Shimla Store ', 2000.00, '2025-10-02'),
('Jammu', 'Shimla', 'Shimla Store ', 2000.00, '2025-10-03'),
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-04'),
('Jammu', 'Shimla', 'Shimla Store ', 1000.00, '2025-10-05'),
('Jammu', 'Jawalaji', 'Jawalaji Store', 500.00, '2025-10-02');


SELECT * FROM SALES;

-- COUNT---

-- i wan to count no of stores present in per state 
select state_name,sum(sales) from sales group by state_name; 

select *,avg(sales)  over (partition by state_name) as state_wise_sum from sales; 



select count(*) from sales;


 

-- SUM---
-- total sales by city
-- USING GROUPBY

 
-- USING WINDOW FUNCTION
select state_name,sales as sale_per_store,
sum(sales) over (partition by state_name) as state_wise_total
from sales order by STATE_name;

-- USING GROUP BY 

SELECT STATE_name,SUM(SALES) as state_wise_sale FROM sales group by state_name ;

-- you can also calculate citywise store wise in single sheet
select state_name,city_name,store_name,sales as sale_per_store,
sum(sales) over (partition by state_name) as state_wise_total,
avg(sales) over (partition by state_name) as state_wise_average,

sum(sales) over (partition by city_name) as city_wise_total,
sum(sales) over (partition by store_name) as store_wise_total
from sales order by city_name;


-- jump to 














-- RANK,DENSE RANK
-- GROUP BY
-- Shows which state generates the most revenue.

SELECT 
    state_name, 
    SUM(sales) AS total_sales
FROM 
    sales
GROUP BY 
    state_name
ORDER BY 
    total_sales DESC;
    
    
   
    SELECT state_name,sales,
rank() over ( order by sales desc) as rank_no,
     dense_rank() over (order by sales desc) as denserank_no,
     row_number() over ( partition by state_name order  by sales ) as row_no
    from  sales ;
    
    
    SELECT CITY_NAME,sales,
    rank() over (partition by city_name  order by sales desc) as rank_
    from  sales order by state_name ASC, 
    sales DESC;
    
    -- Shows which city  generates the most revenue.
    -- Useful for ranking stores within each city
    
    SELECT city_name,sales,
    row_number() over (partition by city_name  order by sales desc) as row_no,
    rank() over (partition by city_name  order by sales desc) as rank_no,
    dense_rank() over (partition by city_name  order by sales desc) as dense_no
    from  sales order by state_name ASC, 
    sales DESC;
    
    
    -- FILTERING
    
    select store_name,sales from (SELECT * , 
    row_number() over (partition by city_name  order by sales desc) as row_no,
    rank() over (partition by city_name  order by sales desc) as rank_no,
    dense_rank() over (partition by city_name  order by sales desc) as dense_no
    from  sales order by state_name ASC, 
    sales DESC) where dense_no=1;
    
    
    
    
    

    
    

