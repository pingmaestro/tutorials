/************ JOINS ************/

#INNER JOIN - Example 1

SELECT *
FROM customers c
INNER JOIN customer_orders co
    ON c.customer_id = co.customer_id
ORDER BY c.customer_id
;

#INNER JOIN - Example 2

SELECT p.product_name, SUM(order_total) AS total
FROM products p
JOIN customer_orders co
    ON p.product_id = co.product_id
GROUP BY product_name
ORDER BY 2 DESC
;

#INNER JOIN - Example 3

SELECT *
FROM suppliers s
INNER JOIN ordered_items oi
    ON s.supplier_id = oi.shipper_id
;

# Joining Multiple Tables

SELECT p.product_id, co.product_id, co.customer_id, c.customer_id
FROM products p
JOIN customer_orders co
    ON p.product_id = co.product_id
JOIN customers c
    ON co.customer_id = c.customer_id
;

# Joining on Multiple Conditions

SELECT *
FROM customer_orders co
JOIN customer_orders_review cor
    ON co.order_id = cor.order_id
    AND co.customer_id = cor.customer_id
    AND co.order_date = cor.order_date
;

# Outer Joins
-- MySQL does not contain the FULL OUTER JOIN function
 
-- We take everything from the LEFT table (customer) and then if there is overlap in the other table (order) it will be displayed

SELECT c.customer_id, first_name, co.order_id
FROM customers c
LEFT OUTER JOIN customer_orders co
    ON c.customer_id = co.customer_id
ORDER BY c.customer_id, co.order_id
;

-- We take everything from the RIGHT table (order) and then if there is overlap in the other table (customer) it will be displayed

SELECT c.customer_id, first_name, co.order_id
FROM customers c
RIGHT OUTER JOIN customer_orders co
    ON c.customer_id = co.customer_id
ORDER BY c.customer_id, co.order_id
;

# Self Joins (rather a technique than a function)
-- You could use it to display an employee table and a supervisor table side by side.

SELECT c.customer_id, c.first_name, c.last_name, ss.customer_id, ss.first_name, ss.last_name
FROM customers c
JOIN customers ss
    ON c.customer_id +1 = ss.customer_id
;

/*Use case: my Boss wants a report that shows each employee and their bosses name so he can try to memorize it before our quarterly social event. Provide an output that includes the employee name matched with the name of their boss. If they don't have a boss still include them in the output. Order output on employee name alphabetically.*/

SELECT  
  b1.employee_name, 
  b2.employee_name AS boss_name
FROM boss b1
LEFT JOIN boss b2
  ON b1.boss_id = b2.employee_id
ORDER BY b1.employee_name ASC
;

# Cross Joins or Cartesian Join
-- Imagine we have 2 tables but no id, no primary key and no foreign key to join them. A cross join could be used.

SELECT c.customer_id, c.first_name, co.customer_id, order_id
FROM customers c
CROSS JOIN customer_orders co
ORDER BY c.customer_id
;

# Natural Joins - IT EXISTS BUT BETTER NOT USE IT IN REAL LIFE SCENARIO
-- In this case we ask the query to "assume" the ON command. In this textbook example it will work and join on product_id but in reality a NATURAL JOIN could join on multiple key and drastically transform the data and the output.

SELECT *
FROM products p
NATURAL JOIN customer_orders co
ORDER BY p.product_id
;

# USING in JOIN - Shortcut to the ON command, it means "there is a customer_id in both table and that's what we joining on".
-- Personal preference if someone like the 'cleaner' look

SELECT c.customer_id, first_name, co.order_id
FROM customers c
LEFT OUTER JOIN customer_orders co
    USING (customer_id)
ORDER BY c.customer_id, co.order_id
;

# UNION (UNION DISTINCT by default)
-- UNION is DISTINCT by default e.g. it does not show the duplicates. The other way to do a UNION is by using UNION ALL.

SELECT first_name, last_name, 'Old' as Label
FROM customers
WHERE YEAR(birth_date) < 1950
UNION DISTINCT
SELECT first_name, last_name, 'Good Tipper'
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
WHERE tip > 3
UNION DISTINCT
SELECT first_name, last_name, 'Big Spender'
FROM customers 
WHERE total_money_spent > 1000
ORDER BY first_name, last_name
;

-- UNION ALL
SELECT first_name, last_name, 'Old' as Label
FROM customers
WHERE YEAR(birth_date) < 1950
UNION ALL
SELECT first_name, last_name, 'Good Tipper'
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
WHERE tip > 3
;

# JOIN Use Cases

SELECT DISTINCT(p.product_name), 
oi.unit_price, 
p.sale_price,
p.units_in_stock, 
p.sale_price - oi.unit_price AS profit,
(p.sale_price - oi.unit_price) * p.units_in_stock AS potential_profit
FROM ordered_items oi
JOIN products p
    USING (product_id)
ORDER BY potential_profit DESC
;

SELECT oi.order_id, sds.name, oi.status, oi.shipped_date, s.name
FROM ordered_items oi
JOIN supplier_delivery_status sds
      ON oi.status = sds.order_status_id
JOIN suppliers s
    ON oi.shipper_id = s.supplier_id
WHERE sds.name <> 'Delivered'
AND YEAR(shipped_date) < YEAR(NOW()) - 2
;