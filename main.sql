-- INSERT INTO department (department_name)
-- VALUES ('IT'), ('Finance'), ('Admin'), ('HR');

-- SELECT * FROM department;



CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email varchar(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK (salary > 0),
    is_active BOOLEAN DEFAULT TRUE NOT NULL,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) DEFAULT 'active' NOT NULL CHECK (employee_status IN ('active', 'on leave', 'terminated')),
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES  department(department_id),
    manager_id INT REFERENCES employees(employee_id)

);

INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, manager_id, hire_date) VALUES
    ('Priya',  'Nair',      'priya.nair@techbazaar.com',      1, 'Sales Representative', 62000.00, 1,    '2020-06-15'),
    ('Fake',   'Robert',    'robert.chen@techbazaar.com',     1, 'Rep',                  50000.00, 1,    '2024-01-01'),
    ('Marcus', 'Webb',      'marcus.webb@techbazaar.com',     1, 'Sales Representative', 58000.00, 1,    '2021-09-01'),
    ('Elena',  'Garcia',    'elena.garcia@techbazaar.com',    1, 'Senior Sales Rep',     68000.00, 1,    '2019-11-20'),
    ('James',  'Okafor',    'james.okafor@techbazaar.com',    2, 'Support Lead',         72000.00, NULL, '2018-05-10'),
    ('Lily',   'Zhang',     'lily.zhang@techbazaar.com',      2, 'Support Agent',        48000.00, 5,    '2022-02-14'),
    ('Diego',  'Fernandez', 'diego.fernandez@techbazaar.com', 2, 'Support Agent',        46000.00, 5,    '2023-01-09'),
    ('Sara',   'Osei',      'sara.osei@techbazaar.com',       5, 'Warehouse Lead',       55000.00, NULL, '2020-08-23');

SELECT * FROM employees;

ALTER TABLE employees 
ADD COLUMN notes TEXT DEFAULT 'N/A';

ALTER TABLE employees
RENAME notes TO hr_notes;

ALTER TABLE employees 
DROP COLUMN notes;


SELECT * FROM categories;
SELECT * FROM products;

INSERT INTO products
(category_id, product_name, price, stock_quantity)
VALUES (1, 'mouse', 200, 20),
 (1, 'keyboard', 100, 120);

UPDATE products SET price = 123
WHERE product_id = 33;

UPDATE products SET price = price + 100;

DELETE FROM products WHERE product_id = 32;

-- Querying Data ---

-- Give me products which are not active
SELECT * FROM products
WHERE NOT is_active;

-- Give me product having price>120 and price < 200
SELECT * FROM products 
WHERE price > 120 AND price < 200;

SELECT * FROM products
WHERE price BETWEEN 120 AND 200;


SELECT * FROM categories;

-- Give me products from electronics and books category
SELECT * FROM products
WHERE category_id = 1 OR category_id = 3 OR category_id=4;

SELECT * FROM products
WHERE category_id IN (1, 3, 4);


INSERT INTO products 
(category_id, product_name, price, stock_quantity)
VALUES (1, 'Wireless keyboard', 200, 20 );
--! Give me products having product name starting with "WIreless"

SELECT * FROM products
WHERE product_name LIKE 'Wireless%';

-- Give me customers who do not have phone numbers

SELECT * FROM customers
WHERE phone IS NULL;

SELECT first_name,
       last_name,
       COALESCE(phone, 'Phone Number Not Available') AS phone,
       COALESCE(city, 'City not available') AS city
FROM customers;

--Sortin
-- Give me products from cheapest to expensive

SELECT * FROM products
ORDER BY price ASC;

-- Give me products from cheap to exp price for each category

SELECT * FROM products
ORDER BY category_id DESC, price ASC;

-- Give me top 5 most expensice products

SELECT * FROM products
ORDER BY  price DESC LIMIT 5;

--Pagination

SELECT COUNT(*) FROM products;

SELECT * FROM products
ORDER BY product_id
LIMIT 5 
OFFSET 0;


