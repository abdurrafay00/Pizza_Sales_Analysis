-- A. KPI-> Key Performance Indicator 

-- 1 Total Revenue 
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2 Average Order value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value FROM pizza_sales;

-- 3 Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

-- 4 Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- 5 Averge Pizzas Per Order
SELECT ROUND(SUM(quantity)  / COUNT(DISTINCT order_id),2) AS Avg_Pizzas_per_order  FROM pizza_sales;  

-- B. Charts Requirement

-- 1 Daily Trend for Total Orders  
-- Change Date Format
SET SQL_SAFE_UPDATES = 0;
UPDATE pizza_sales
SET order_date = DATE_FORMAT(STR_TO_DATE(order_date, "%d-%m-%Y"),"%Y-%m-%d");  

-- Change DateType
ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE; 

-- Daily Trend
SELECT DAYNAME(order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- 2 Hourly Trend for Orders
SELECT HOUR(order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY HOUR(order_time);

-- 3 Percentage of Sales by Pizza Category
SELECT pizza_category AS Pizza_Category	, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) as Percentage_of_Sales 
FROM pizza_sales
GROUP BY pizza_category;

-- 4 Percentage of Sales by Pizza Size
SELECT pizza_size AS Pizza_Size, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) as Percentage_of_Sales 
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 5 Total Pizzas Sold by Pizza Category
SELECT pizza_category AS Pizza_Category, SUM(quantity) AS Total_Quantity_Sold FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- 6 Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name AS Pizza_Name, SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- 7 Bottom 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name AS Pizza_Name, SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold
LIMIT 5;