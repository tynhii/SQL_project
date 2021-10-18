/* return all the products 
- name
- unit price 
- new price ( unit price * 1.1) */
USE sql_inventory;
SELECT name, unit_price, (unit_price *1.1) AS 'new price'
FROM products;

/* From the order_items table, get the items
- for order #6
- where the total price is greater than 30 */
USE sql_store;
SELECT *
FROM order_items
WHERE order_id = 6 AND (unit_price * quantity) > 30;

/* Return products with
- quantity in stock equal to 49, 38, 72 */
 SELECT *
 FROM products
 WHERE quantity_in_stock IN (49, 38, 72);
 
 -- Return customers born between 1/1/1990 and 1/1/2000 
 SELECT *
 FROM customers
 WHERE birth_date BETWEEN '1990/1/1' AND '2000/1/1'
 
 /* Get the customer whose
 - address contrain TRAIL or AVENUE
 - phone numbers end with 9 */
SELECT * 
FROM customers
WHERE 	address LIKE '%TRAIL%' OR 
		address LIKE '%AVENUE%'
SELECT *
FROM customers
WHERE phone LIKE '%9'

/* Get the customers whose
- first name are ELKA or AMBUR
- last name end with EY or ON
- last name start with MY or contains SE
- last name contain B followed by R or U */

-- first name are ELKA or AMBUR
SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR'
-- last name end with EY or ON
SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$'
-- last name start with MY or contains SE
SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE'
-- last name contain B followed by R or U
SELECT *
FROM customers
WHERE last_name REGEXP 'B[RU]'

-- Get the orders that are not shippedorder_statuses
SELECT *
FROM orders
WHERE shipped_date IS NULL
-- Get the top 3 loyal customers
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3

-- INNER JOIN
SELECT order_id, o.product_id, name, quantity, o.unit_price
FROM order_items o
JOIN products p ON o.product_id = p.product_id

SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	On o.status = os.order_status_id
 USE sql_invoicing
SELECT 
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    m.name
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods m
	ON m.payment_method_id = p.payment_method

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id
    
-- OUTER JOIN
-- Right
SELECT 
	c.customer_id,
    c.first_name,
	o.order_id    
FROM orders o
RIGHT JOIN customers c
	ON o.customer_id = c.customer_id
ORDER BY c.customer_id
--Left
  SELECT 
	c.customer_id,
    c.first_name,
	o.order_id    
FROM orders o
LEFT JOIN customers c
	ON o.customer_id = c.customer_id
ORDER BY c.customer_id;

SELECT 
	p.product_id,
	p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id

SELECT 
	o.order_id,
	o.order_date,
	c.first_name,    
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN  customers c
	ON c.customer_id = o.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY  os.name, o.order_id
-- The USING Clause
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	-- ON oi.order_id = oin.order_id 
	-- AND oi.product_id = oin.product_id
    USING (order_id ,product_id)
    
SELECT 
	p.product_id,
	p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	-- ON p.product_id = oi.product_id
    USING (product_id)

SELECT 
	p.date,
    c.name AS clients,
    p.amount,
    pm.name AS payment_method
FROM clients c
JOIN payments p
	USING (client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method

-- Natural Join
SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c
-- Cross Join
SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY sh.name

SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name

-- UNION
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01'
