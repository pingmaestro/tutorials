# WINDOW FUNCTIONS

-- Over Clause + Partition BY

SELECT *
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
;

-- I work in a store and I want to check the purchases of my customers. I want to create a new column of their MAX spending adjacent to compare the order_total of the purchases. On on my good friend, Kevin, bought several items at my store but if I use a GROUP BY it does not display the desired output because every purchase is grouped on itself.
SELECT c.customer_id, first_name, order_total, MAX(order_total)
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
GROUP BY c.customer_id, first_name, order_total
;

-- Over and Partition BY can be use to circumvent the problem
SELECT c.customer_id, 
first_name, 
order_total, 
AVG(order_total) OVER(PARTITION BY customer_id) AS avg_order_total,
MIN(order_total) OVER(PARTITION BY customer_id) AS min_order_total,
MAX(order_total) OVER(PARTITION BY customer_id) AS max_order_total
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
;

-- Row Number
SELECT c.customer_id, 
first_name, 
order_total,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_total DESC) as row_num
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
WHERE row_num < 3
;

SELECT *
FROM (
SELECT c.customer_id, 
first_name, 
order_total,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_total DESC) as row_num
FROM customers c
JOIN customer_orders co
    ON c.customer_id = co.customer_id
) AS row_table
WHERE row_num <= 2
;

-- We want to take a look at each customers purchases and give them their own row number. Break the rows out by the customer and give each row a number based off the amount spent starting from the highest to the lowest.

SELECT customer_id, amount,
  ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS rn
FROM purchases
;

# RANK and DENSE RANK
-- For RANK: if we have duplication, the next unique value will skip where it needs to be e.g. 1, 2, 3, 3, 3, 6
-- For DENSE RANK : if we have a duplication, the next unique value will follow suit e.g. 1, 2, 2, 2, 3

SELECT *,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees
;

SELECT *
FROM 
(SELECT *,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_row
FROM employees) AS ranked
WHERE rank_row <= 2
;

-- For DENSE_RANK
SELECT *,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_
FROM employees
;

# LAG AND LEAD

SELECT *,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id),
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id)
FROM employees
;

SELECT *, lag_col - salary AS pay_discrepancy
FROM
(SELECT *,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lag_col
FROM employees) AS lag_table
;

SELECT *, IF(salary > lag_col, 'More money than the previous person', 'Less Money than the previous person')
FROM
(SELECT *,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lag_col
FROM employees) AS lag_table
;
