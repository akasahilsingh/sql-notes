-- Give me total nuber of products in each category

SELECT * FROM products;

SELECT category_id, COUNT(*) AS category_count FROM products GROUP BY category_id; 

-- Give me total number of active and inactive products in each category
SELECT category_id, is_active, COUNT(*) FROM products GROUP BY category_id, is_active;

-- Give me total number of products in each category including name in the result

SELECT p.category_id, c.category_name, COUNT(*) 
FROM products AS p 
LEFT JOIN categories AS c 
ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_id;

-- Give me total number of products in each category filter it by count > 5

SELECT category_id, COUNT(*)
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;

-- Find departments having more than one employee, where their combined salary of whole department exceeds 2 lakh rupees

SELECT SUM(e.salary) AS total_salary,d.department_id, d.department_name, COUNT(e.employee_id) AS total_employees
FROM department AS d 
LEFT JOIN employees AS e 
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 1 AND SUM(e.salary) > 200000;

-- Find departments having more than one employee having manager, where their combined salary of whole department exceeds 2 lakh rupees

-- same as above but use where IS NOT NULL before group by

SELECT department_id, SUM(salary) FROM employees
WHERE manager_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) > 1 AND SUM(salary) > 200000;