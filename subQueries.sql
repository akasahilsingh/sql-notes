-- Give me all the customers having at least on cancelled order
SELECT o.order_id, c.customer_id, o.status, c.first_name, c.last_name 
FROM orders AS o 
LEFT JOIN customers AS c 
ON o.customer_id = c.customer_id
WHERE o.status = 'cancelled';

-- Now with subquery and without joins
SELECT first_name, last_name, email from customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE status = 'cancelled');


-- Give me all the products which are having price > average price across all products
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Give me sales on category level

SELECT 
     SUM(oi.quantity * oi.unit_price) AS sales, c.category_name
    FROM order_items AS oi
    LEFT JOIN products AS p 
    ON oi.product_id = p.product_id
    LEFT JOIN categories AS c 
    ON p.category_id = c.category_id
    GROUP BY  c.category_name;

-- -- Give me sales on category level + give me sales having greater than 500
SELECT 
    p.category_id,
    SUM(oi.quantity * oi.unit_price) AS category_sales
FROM order_items AS oi
LEFT JOIN products AS p 
ON p.product_id = oi.product_id 
GROUP BY p.category_id
HAVING SUM(oi.quantity * oi.unit_price) > 500;

-- Now with subquery 
--inside () is called derived table
SELECT * FROM 
    (
    SELECT 
    p.category_id,
    SUM(oi.quantity * oi.unit_price) AS category_sales
    FROM order_items AS oi
    LEFT JOIN products AS p 
    ON p.product_id = oi.product_id 
    GROUP BY p.category_id
    )
WHERE  category_sales > 500;

-- -- -- Give me sales on category level + give me sales having greater than 500 + return category name

SELECT category_name, category_sales FROM 
    (
    SELECT 
    p.category_id,
    SUM(oi.quantity * oi.unit_price) AS category_sales
    FROM order_items AS oi
    LEFT JOIN products AS p 
    ON p.product_id = oi.product_id 
    GROUP BY p.category_id
    ) AS category_stats
LEFT JOIN categories as c 
ON category_stats.category_id = c.category_id;