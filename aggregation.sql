-- Give me total count customers on our platform

SELECT COUNT(*) AS cust_count FROM customers;

SELECT COUNT(*) AS cust_count, COUNT(phone) AS cust_with_phone FROM customers;

SELECT COUNT(DISTINCT(country)) FROM customers;

-- Give me total revenue across all orders till now

SELECT order_item_id, quantity, unit_price, unit_price*quantity AS total_price FROM order_items;

SELECT SUM(unit_price*quantity) FROM order_items;

-- Give average price of product acorss all products

SELECT ROUND(AVG(price), 2) FROM products;

-- Give me min price and max price across all products

SELECT price from products ORDER BY price DESC; 

SELECT MIN(price) AS min_price, MAX(price) AS max_price FROM products;