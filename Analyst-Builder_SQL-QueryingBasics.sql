/* Credit and thanks to @AlexTheAnalyst for the SQL Tutorial*/

# This is the bakery database
# This is a note
-- This is also a note
/* This too */

/* QUERYING BASICS */

SELECT customer_id, first_name
FROM bakery.customers
;

SELECT *
FROM customer_orders
WHERE product_id = 1001
;

/* SELECT STATEMENT */

SELECT last_name,
first_name, 
birth_date,
phone,
city,
state,
total_money_spent,
(total_money_spent + 100) * 10
FROM customers
;

# Order of operators = PEMDAS (Parentheses,  Exponents (including roots, such as square roots), Multiplication, Division, Addition, Subtraction)

SELECT state
FROM customers
;

# DISTINCT to remove duplicates in a column or a range of columns
-- Single column
SELECT DISTINCT state
FROM customers
;

-- Range of columns
SELECT DISTINCT city, state
FROM customers
;

/* WHERE CLAUSE */

-- Filtering on numeric values
SELECT *
FROM customers
WHERE total_money_spent > 3000
;

SELECT *
FROM products
WHERE units_in_stock < 30
;

-- Filtering on string
SELECT *
FROM customers
WHERE city = 'Scranton'
;

-- Filtering on date
SELECT *
FROM customers
WHERE  birth_date > '1985-01-01'
;

/* COMPARAISON OPERATORS  # = < > ! */ 

-- Is equal to =
SELECT *
FROM bakery.customer_orders
WHERE tip = 1
;

-- Is not equal to !=
SELECT *
FROM bakery.customer_orders
WHERE tip != 1
;

-- Is greater than >
SELECT *
FROM bakery.customer_orders
WHERE tip > 5
;

-- Is greater than or equal >=
SELECT *
FROM bakery.customer_orders
WHERE tip >= 5
;

-- Is less than <
SELECT *
FROM bakery.customer_orders
WHERE tip < 5
;

-- Is less than or equal <=
SELECT *
FROM bakery.customer_orders
WHERE tip <= 5
;

/* LOGICAL OPERATORS AND, OR, NOT */

-- AND Both operators have to be true
SELECT *
FROM customers
WHERE state = 'PA' AND total_money_spent > 1000
;

-- OR at least one operator has to be true
SELECT *
FROM customers
WHERE state = 'PA' OR total_money_spent > 1000
;

-- Incoporating multiple conditions
SELECT *
FROM customers
WHERE (state = 'PA' OR city = 'New York') AND total_money_spent > 1000
;

SELECT *
FROM customers
WHERE (state = 'PA'  AND total_money_spent > 1000) OR birth_date > '1998-01-01'
;

-- It is not recommended to write a query with multiple operators without ( ) 
SELECT *
FROM customers
WHERE state = 'PA' OR birth_date > '1998-01-01'  AND total_money_spent > 1000
;

SELECT *
FROM customers
WHERE NOT state = 'PA'
;

SELECT *
FROM customers
WHERE NOT total_money_spent > 1000 AND state = 'TX'
;

/* IN OPERATOR */

SELECT *
FROM customers
WHERE state IN ('PA', 'TX', 'IL')
;

SELECT *
FROM customers
WHERE state NOT IN ('Kevin', 'Kelly', 'Frodo')
;

/* BETWEEN OPERATOR - Starts with the low number then the high */

SELECT *
FROM customers
WHERE total_money_spent BETWEEN 534 AND 1009
;

SELECT *
FROM customers
WHERE total_money_spent >= 534 AND total_money_spent <= 1009
;

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2020-01-01'
;

-- It can also works with letters
SELECT *
FROM customers
WHERE city BETWEEN 'A' AND 'Z'
;

/* LIKE OPERATOR - Looking for a specific pattern in a WHERE clause using wildcards % - */

-- The query is not case sensitive

-- Starts with 'k'
SELECT *
FROM customers
WHERE first_name LIKE 'k%'
;

-- Ends with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n'
;

-- Contains an 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n%'
;

-- There is two character before the letter we're looking for
SELECT *
FROM customers
WHERE first_name LIKE '__n'
;

-- There is one character before and one after the letter we're looking for
SELECT *
FROM customers
WHERE first_name LIKE '_o_'
;

SELECT *
FROM customers
WHERE first_name LIKE '___kin'
;

-- Let's combine all of them

SELECT *
FROM customers
WHERE last_name LIKE '%kin'
;

SELECT *
FROM customers
WHERE phone LIKE '975%'
;

/* ORDER BY - Clause to sort items by ascending or descending order, by default ascending is applied*/

-- Order on one column
SELECT *
FROM customers
ORDER BY first_name DESC
;

-- Order on multiple items by column name (best practice)
SELECT *
FROM customers
ORDER BY state, total_money_spent DESC
;

-- Order on multiple items by positions (alternative practice but could cause errors if columns change positions through time)
SELECT *
FROM customers
ORDER BY 8 DESC, 9 ASC
;

/* LIMIT CLAUSE */

-- Limit the number of results returned
SELECT *
FROM customers
-- WHERE total_money_spent > 10000
ORDER BY total_money_spent DESC 
LIMIT 5
;
-- Limit the number of results returned (2) by starting at a specific position (5) 

SELECT *
FROM customers
-- WHERE total_money_spent > 10000
ORDER BY total_money_spent DESC 
LIMIT 5, 2
;

/* ALIASING the name displayed in the column */

-- AS (in the SELECT Statement)
SELECT product_name AS 'Goodie Name' , units_in_stock
FROM products
;

SELECT units_in_stock * sale_price AS Potential_Revenue
FROM products
;

-- Without AS (in the SELECT Statement)
SELECT product_name , units_in_stock 'uis'
FROM products
;

-- Without AS (in the FROM Statement)
SELECT prod.units_in_stock * prod.sale_price AS Potential_Revenue
FROM products prod
;
