/********** GROUP BY & AGGREGATE FUNCTIONS SUM, COUNT, MAX, MIN **********/

-- GROUP BY Basics
SELECT customer_id, SUM(tip) AS total_tips
FROM customer_orders
GROUP BY customer_id
;

SELECT product_id, AVG(order_total) AS average_order
FROM customer_orders
GROUP BY product_id
ORDER BY AVG(order_total) DESC
;

-- Aggregate functions
SELECT customer_id, MAX(tip) AS biggest_tips
FROM customer_orders
GROUP BY customer_id
ORDER BY biggest_tips DESC
;

SELECT customer_id, MIN(tip) AS smallest_tips
FROM customer_orders
GROUP BY customer_id
ORDER BY smallest_tips
;

-- This aggregate function does not count the time the customer gave 0 tip
-- We have to be really careful when using these aggregate functions because a customer giving 0,0,0,100 tips will output AVG = 25 but COUNT = 1
SELECT customer_id, COUNT(tip) AS count_of_tips
FROM customer_orders
GROUP BY customer_id
ORDER BY count_of_tips
;

SELECT first_name, last_name, COUNT(phone)
FROM customers
GROUP BY first_name, last_name
;

SELECT product_id, tip, COUNT(tip), COUNT(DISTINCT tip)
FROM customer_orders
GROUP BY product_id, tip
ORDER BY product_id
;

-- HAVING VS WHERE
-- Since the execution order goes FROM -> WHERE -> ... -> SELECT the following query is trying to select a column that has not been created yet.
SELECT customer_id, SUM(tip) AS total_tips
FROM customer_orders
WHERE total_tips > 5
GROUP BY customer_id
;

-- The HAVING clause was created to circumvent the problem
SELECT customer_id, SUM(tip) AS total_tips
FROM customer_orders
GROUP BY customer_id
HAVING total_tips > 5
;

SELECT customer_id, SUM(order_total) AS total
FROM customer_orders
GROUP BY customer_id
HAVING SUM(order_total) > 40
ORDER BY 2
;

-- ROLLUP
SELECT customer_id, SUM(tip) AS total_tips
FROM customer_orders
GROUP BY customer_id WITH ROLLUP
;

SELECT customer_id, COUNT(tip) AS count_tips
FROM customer_orders
GROUP BY customer_id WITH ROLLUP
;