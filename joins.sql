--Joins
-- Give me all orders including employee details of the employee who processed that order
-- ONLY include order punched by employee
SELECT * FROM orders 
 JOIN employees
ON orders.employee_id = employees.employee_id;               

-- ! give me all orders and include employee details of employee who processed
-- ! that order and if it is directly coming from customer keep employee
-- ! details empty

SELECT o.status, o.order_id, e.email, e.first_name FROM 
orders AS o 
LEFT JOIN employees AS e 
ON o.employee_id = e.employee_id;

SELECT o.status, o.order_id, e.email, e.first_name FROM 
orders AS o 
RIGHT JOIN employees AS e 
ON o.employee_id = e.employee_id;

SELECT o.status, o.order_id, e.email, e.first_name FROM 
orders AS o 
FULL OUTER JOIN employees AS e 
ON o.employee_id = e.employee_id;

SELECT * FROM department
CROSS JOIN categories;


--- Give me all customers who did not placed any order

SELECT  c.first_name, c.email, o.status, o.order_id FROM 
customers AS c
LEFT JOIN orders AS o
ON o.customer_id = c.customer_id
WHERE o.status IS NULL;

-- Give me orders which have not been paid

SELECT o.order_id, o.status AS order_status, p.status, p.payment_method FROM 
orders AS o
LEFT JOIN payments AS p 
ON o.order_id = p.order_id
WHERE p.status IS NULL;

-- Give information about all orders that are there in the DB include info about order_items, product, customer and category the product belongds to
SELECT c.first_name, c.last_name, o.order_id, o.status, oi.product_id, oi.unit_price, p.product_id, p.price, ca.category_name
FROM orders AS o
LEFT JOIN order_items AS oi
ON o.order_id = oi.order_id 
LEFT JOIN products AS p 
ON  oi.product_id =p.product_id
LEFT JOIN customers AS c 
ON o.customer_id = c.customer_id
LEFT JOIN categories as ca 
ON p.category_id = ca.category_id;

-- Give me info about employees including their manager's info
SELECT e.first_name, e.last_name, e1.first_name AS mgr_first_name, e1.last_name AS mgr_last_name
FROM employees AS e 
LEFT JOIN employees AS e1
ON e.employee_id = e1.manager_id
WHERE e1.first_name IS NOT NULL AND e1.last_name IS NOT NULL;

SELECT * FROM employees;