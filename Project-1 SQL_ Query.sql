-- SQL Retail Sales Analysis - P1 
CREATE DATABASE sql_project1;
use sql_project1;
DROP TABLE  IF EXISTS retail_sales;

CREATE TABLE retail_sales (
transactions_id INT PRIMARY KEY,
sale_date DATE,	
sale_time TIME,
customer_id INT,
gender VARCHAR (20),
age INT,
category VARCHAR(20),
Quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);


-- data cleaning -

SELECT * FROM retail_sales
WHERE 
transactions_id IS NULL
 OR
 sale_date IS NULL
 OR
 sale_time IS NULL;
 
 -- data exploration --
 -- how many sales we have ?
 
 SELECT COUNT(*)  total_sales FROM retail_sales;
 
-- how many unique customer we have --
 
SELECT COUNT(DISTINCT customer_id) total_sales FROM retail_sales;

-- how many unique category we have -
SELECT DISTINCT category total_sales FROM retail_sales;

-- data analysis & business problem & answers--
-- Q1 write a query to retrieve all colm for sale on "2022-11-05"

SELECT * 
FROM retail_sales
where sale_date = '2022-05-11';


SELECT * 
from retail_sales
WHERE category ='clothing'
AND 
sale_date = '2022-11-12';


-- Q.3 write  a sql query to calculate total sale for each category --

SELECT 
category,
SUM(total_sale) as net_sale,
COUNT(*) as total_order
 FROM retail_sales 
group by 1;

-- Q4 write the qoery to find thye avg age of customer who buy from beauty category --

SELECT  
ROUND(avg(age),2) as avg_age
from retail_sales
WHERE CATEGORY ='Beauty';

-- Q6 write a sql query where total_sale > 1000 --

SELECT *
 FROM retail_sales
 where total_sale > 1000;
 
-- Q7 write a query where total number of transactions(transaction_id) made by each gender in each category --
SELECT 
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY
category,
gender
ORDER BY 1;

-- Q8 wite a sql query to Calculate the average sale of each month.find out best selling month in each year.--

SELECT *
 FROM (
SELECT
year(sale_date),
month(sale_date),
AVG(total_sale) as avg_total_sale,
RANK() OVER (PARTITION BY year(sale_date) ORDER BY avg(total_sale)  desc) as ranking
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE ranking = 1;

--  write the SQL query for top 5 customers based on highest total sales --
SELECT
customer_id,
SUM(total_sale) as total_sale
FROM retail_sales
GROUP  BY 1
ORDER BY 2 DESC
LIMIT 5;

--  Q9 WRITE THE QUERY FOR CUSTOMER WHO PURCHASED ITEM FROM EACH CATEGORY--

SELECT 
category,
count(DISTINCT customer_id) as Unique_customer
FROM retail_sales
GROUP BY category;

-- write a SQL query to each shift and number of orders --

WITH hourly_sale
AS (
SELECT *,
CASE 
WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN  EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'evening'
END as Shift
FROM retail_sales
) 
SELECT 
shift,
COUNT(*) as total_orders
 FROM hourly_sale
 GROUP  BY shift
 
 -- END OF PROJECT --


