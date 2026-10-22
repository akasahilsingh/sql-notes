-- Common table expression
-- CTE is similar to sub queris but more redable form

-- CTE structure
-- WITH variable_name AS (
--     SQL query...
--     )

-- So last subqueries do with CTE

WITH category_stats AS (
    SELECT 
    p.category_id,
    SUM(oi.quantity * oi.unit_price) AS category_sales
    FROM order_items AS oi
    LEFT JOIN products AS p 
    ON p.product_id = oi.product_id 
    GROUP BY p.category_id
) 
SELECT category_name, category_sales FROM category_stats
LEFT JOIN categories AS c ON c.category_id = category_stats.category_id;


-- Same as above but give me hughest category sale solve with CTE

WITH category_stats AS (
    SELECT 
    p.category_id,
    SUM(oi.quantity * oi.unit_price) AS category_sales
    FROM order_items AS oi
    LEFT JOIN products AS p 
    ON p.product_id = oi.product_id 
    GROUP BY p.category_id
),
highest_sales_cat AS (
    SELECT * FROM category_stats ORDER BY category_sales DESC LIMIT 1
)
SELECT c.category_name, highest_sales_cat.category_sales FROM highest_sales_cat 
LEFT JOIN categories AS c
ON highest_sales_cat.category_id = c.category_id;


-- Reusabiility

-- Give me total spend of a cutomer
-- also give me average spend of all customer
-- also give me flag TRUE or FALSE basis of if the customer have above average spending

WITH total_spend AS (
    SELECT customer_id, order_id FROM orders GROUP BY customer_id, order_id;
)