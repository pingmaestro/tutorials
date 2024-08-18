# REGULAR EXPRESSION (or REGEX) is similar to a LIKE statement but more specific

-- Recap of how to use a LIKE function
SELECT *
FROM customers
WHERE first_name LIKE '%K%'
;

-- Now let's try with a REGEXP for the exact same output. In this example we have an output of Kevin, Kelly and Anakin
SELECT *
FROM customers
WHERE first_name REGEXP 'K'
;

-- Now let's try REGEXP REPLACE = Anakin becomes bnbkin
SELECT first_name, REGEXP_REPLACE(first_name, 'a', 'b')
FROM customers
WHERE first_name REGEXP 'K'
;

-- With REGEXP LIKE a new column is created in which the output tells us if there's a first_name starting with an A sorted by the named containing a K.
SELECT first_name, REGEXP_LIKE(first_name, 'a')
FROM customers
WHERE first_name REGEXP 'K'
;

-- Let's broaden our research by asking an output of the position of the letter A in the first_name
SELECT first_name, REGEXP_INSTR(first_name, 'a')
FROM customers
;

-- Then if you want to extract a string in the ouput, REGEXP SUBSTR can be useful
SELECT first_name, REGEXP_SUBSTR(first_name, 'char')
FROM customers
;

# REGULAR EXPRESSION METACHARACTERS

# [-,^$*+?}|

/*
    ^: Matches the start of a line.
    $: Matches the end of a line.
    .: Matches any single character except a newline character.
    [...]: Matches any one character enclosed in the square brackets. If the first character is "^", it matches any character not enclosed in the brackets.
    [^...]: Matches any character not enclosed in the brackets.
    p1|p2|p3: Matches any of the patterns p1, p2, or p3.
    *: Matches zero or more occurrences of the preceding character or pattern.
    +: Matches one or more occurrences of the preceding character or pattern.
    ?: Matches zero or one occurrence of the preceding character or pattern.
    {n}: Matches exactly n occurrences of the preceding character or pattern.
    {n,}: Matches n or more occurrences of the preceding character or pattern.
    {n,m}: Matches between n and m (inclusive) occurrences of the preceding character or pattern.
    ( ... ): Groups characters or patterns together.
    \b: Matches a word boundary.
    \B: Matches a non-word boundary.
    \d: Matches any digit.
    \D: Matches any non-digit character.
    \s: Matches any whitespace character.
    \S: Matches any non-whitespace character.
    \w: Matches any word character (equivalent to [a-zA-Z0-9_]).
    \W: Matches any non-word character.
    \n: Matches a newline character.
    \r: Matches a carriage return character.
    \t: Matches a tab character.
    \: Matches a backslash character.
*/

-- Search for a range of a first_name containing A, B or C
SELECT *
FROM customers
WHERE first_name REGEXP '[a-c]'
;

SELECT *
FROM customers
WHERE total_money_spent REGEXP '[0-1]'
;

-- Search for ANY character with a .
SELECT *
FROM customers
WHERE phone REGEXP '.'
;

-- Search for any phone number with a 6 followed by ANY character
SELECT *
FROM customers
WHERE phone REGEXP '6.'
;

-- Search for a very specific pattern
SELECT *
FROM customers
WHERE first_name REGEXP 'k...n'
;

-- Search for a string starting with a K
SELECT *
FROM customers
WHERE first_name REGEXP '^k'
;

-- Search for a string ending with a N
SELECT *
FROM customers
WHERE first_name REGEXP 'n$'
;

-- The combination of .* helps you query for a condition where Obi could be followed by ANY character or not
SELECT *
FROM customers
WHERE first_name REGEXP 'Obi.*'
;

-- .+ At least have 1 or more after the query
SELECT *
FROM customers
WHERE first_name REGEXP 'Obi.+'
;

-- Searching for a K with exactly 0 or 1 characters and then a N
SELECT *
FROM customers
WHERE first_name REGEXP 'K.?n'
;

SELECT *
FROM customers
WHERE first_name REGEXP 'K.{3}n'
;

-- Either or
SELECT *
FROM customers
WHERE first_name REGEXP 'kev|fro'
;


# Regular Expression Examples and Use Cases

SELECT *
FROM z_regular_expression
WHERE email REGEXP '@gmail'
;

-- Let's say we want to extract some informations
SELECT email, REGEXP_SUBSTR(email, '@.+')
FROM z_regular_expression
;

SELECT email, REGEXP_SUBSTR(email, '@[a-z]+')
FROM z_regular_expression
;

SELECT phone
FROM z_regular_expression
WHERE phone REGEXP '[0-9]{3}.[0-9]{3}.[0-9]{4}'
;

SELECT phone
FROM z_regular_expression
WHERE phone REGEXP '[0-9]{3}-[0-9]{3}-[0-9]{4}'
;

SELECT *
FROM z_regular_expression
WHERE phrase REGEXP '.+SQL.+'
;