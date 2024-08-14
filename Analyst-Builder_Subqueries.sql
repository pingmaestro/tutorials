/******** SUBQUERIES OR NESTED QUERIES ********/

# SUBQUERY BASICS
-- We could also use a JOIN but a subquery can be use for more efficiency with large databases
-- Can also be used for better readability

SELECT *
FROM customers
WHERE customer_id IN 
    (SELECT customer_id
    FROM customer_orders
    WHERE tip > 1)
;

SELECT *
FROM customers
WHERE total_money_spent > (SELECT AVG(total_money_spent)
    FROM customers)
;

# Everyone at Analyst Builder is supposed to receive a bonus at the end of the year. Unfortunately some people didn't receive their bonus as was promised. Write a query to determine the employees who did not receive their bonus so we can notify accounting. Return their id and name in the output. Order the id from lowest to highest.

SELECT employee_id, name 
FROM employee 
WHERE employee_id NOT IN
  (
  SELECT emp_id
  FROM bonus
  )
ORDER BY employee_id
;

# ALL & ANY Statements

SELECT MAX(quantity * unit_price) as total_order_price
FROM ordered_items
WHERE shipper_id = 1
;

SELECT shipper_id, order_id, quantity, unit_price, (quantity * unit_price) AS total_order_price
FROM ordered_items
WHERE (quantity * unit_price) >  
        (
        SELECT MAX(quantity * unit_price) AS total_order_price
        FROM ordered_items
        WHERE shipper_id = 1
        )
;

SELECT shipper_id, order_id, quantity, unit_price, (quantity * unit_price) AS total_order_price
FROM ordered_items
WHERE (quantity * unit_price) > ALL (SELECT (quantity * unit_price) AS total_order_price
        FROM ordered_items
        WHERE shipper_id = 1)
;

SELECT shipper_id, order_id, quantity, unit_price, (quantity * unit_price) AS total_order_price
FROM ordered_items
WHERE (quantity * unit_price) >= ANY (SELECT (quantity * unit_price) AS total_order_price
        FROM ordered_items
        WHERE shipper_id = 1)
;

# Write an SQL query to identify the customer who had the largest number of orders. Return the Customer_ID and number of orders, but if 2 customers had the same amount of orders, return them both.

SELECT * 
FROM orders 
WHERE number_of_orders >= 
    (
    SELECT MAX(number_of_orders)
    FROM orders
    )
;

# EXISTS OPERATOR
-- Behave similar to IN operator, check to see if a value exists in a subquery. Exists checks if there are values in the subquery and will stop the process, like a true or false.

-- Let's take a look at the IN again, 
SELECT *
FROM customers
WHERE customer_id IN
    (SELECT (customer_id)
    FROM customer_orders)
;

SELECT *
FROM customers c
WHERE EXISTS
    (SELECT (customer_id)
    FROM customer_orders
    WHERE customer_id = c.customer_id)
;

# SUBQUERIES IN SELECT AND FROM STATEMENTS
-- In SELECT

SELECT product_id, quantity, AVG(quantity)
FROM ordered_items
GROUP BY product_id, quantity
ORDER BY product_id
;

SELECT product_id, quantity,
    (SELECT AVG(quantity)
        FROM ordered_items) AS avg_quantity
FROM ordered_items
ORDER BY product_id
;

SELECT product_id, 
quantity,
(SELECT SUM(quantity)
        FROM ordered_items), 
    (quantity/(SELECT SUM(quantity)
        FROM ordered_items) *100) AS sum_quantity
FROM ordered_items
;

-- FROM Statement

SELECT product_id, avg_quantity
FROM (SELECT product_id, quantity,
    (SELECT AVG(quantity)
        FROM ordered_items) AS avg_quantity
FROM ordered_items) AS avg_quant
;

-- Social Media Addiction can be a crippling disease affecting millions every year. We need to identify people who may fall into that category. Write a query to find the people who spent a higher than average amount of time on social media. Provide just their first names alphabetically so we can reach out to them individually.

SELECT first_name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM user_time
    WHERE media_time_minutes > (
        SELECT AVG(media_time_minutes)
        FROM user_time
    )
)
ORDER BY first_name
;