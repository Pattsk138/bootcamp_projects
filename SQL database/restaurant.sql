 -- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/with
-----------------------------------------------------------------
-----------------------------------------------------------------

-- create 1 dimension table
CREATE TABLE branch (
  branch_id INT NOT NULL PRIMARY KEY,
  manager_id INT UNIQUE,
  manager_name TEXT,
  branch_name TEXT,
  n_table INT
);

INSERT INTO branch VALUES
  (1, 1, "Phaisan Toopragai", "Chula", 25),
  (2, 2, "Panya Tiemmuang", "PNB", 20),
  (3, 3, "Jarasphas Pukpik", "Weisse", 10)
;
-----------------------------------------------------------------  
-- create 2 dimension table
CREATE TABLE customers (
  customer_id INT NOT NULL PRIMARY KEY,
  cust_name TEXT NOT NULL UNIQUE,
  city TEXT,
  gender TEXT,
  age INT
);

INSERT INTO customers VALUES
  (1, "Patipan", "Bangkok", "M", 22),
  (2, "Bongkotmart", "Bangkok", "F", 20),
  (3, "Palm", "Lampang", "M", 20),
  (4, "Nuchanete", "Amnacharoen", "F", 52),
  (5, "Samran ", "Amnacharoen", "F", 76),
  (6, "Chonnasit", "China", "M", 53),
  (7, "JJ", "China", "M", 18),
  (8, "LungPhol", "Chiangmai", "M", 45),
  (9, "Men", "Chiangmai", "M", 30),
  (10, "Kwak", "Bangkok", "F", 5),
  (11, "Prateung", "Bangkok", "M", 84),
  (12, "Nongnut", "Bangkok", "F", 60),
  (13, "Pien", "Amnacharoen", "F", 62),
  (14, "Pop", "India", "M", 55),
  (15, "Jing", "Lampang", "M", 25),
  (16, "Chompoo", "China", "M", 32)
;
----------------------------------------------------------------- 
-- create 3 dimension table
CREATE TABLE menu (
  menu_id INT NOT NULL PRIMARY KEY,
  menu_name TEXT NOT NULL UNIQUE,
  price REAL,
  Categories TEXT
);

INSERT INTO menu VALUES
  (1, "Pizza", 200, "dish"),
  (2, "Masala", 150, "curry"),
  (3, "Somtam", 100, "dish"),
  (4, "Cheesecake", 70, "dessert"),
  (5, "croissant", 88, "bakery"),
  (6, "Bear Milk", 45, "drink"),
  (7, "Kamu boba tea", 50, "drink")
;
-----------------------------------------------------------------  
-- create 4 dimension table
CREATE TABLE payment (
  payment_id INT NOT NULL PRIMARY KEY,
  payment_method TEXT NOT NULL UNIQUE
);

INSERT INTO payment VALUES
  (1, "cash"),
  (2, "credit card"),
  (3, "point")
;
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Create 1 fact table
CREATE TABLE transactions (
    order_id INT NOT NULL PRIMARY KEY,
    order_date TEXT,
    branch_id INT,
    customer_id INT,
    menu_id INT,
    payment_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id),
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

INSERT INTO transactions VALUES
  (1, "2022-11-18", 1, 1, 2, 1),
  (2, "2022-10-18", 2, 16, 5, 2),
  (3, "2022-09-18", 3, 15, 4, 1),
  (4, "2022-08-18", 3, 14, 3, 1),
  (5, "2022-07-18", 1, 8, 2, 1),
  (6, "2022-06-18", 2, 7, 6, 2),
  (7, "2022-05-18", 1, 6, 1, 1),
  (8, "2022-04-01", 1, 13, 4, 1),
  (9, "2022-04-01", 1, 12, 1, 1),
  (10, "2022-04-01", 1, 11, 2, 1),
  (11, "2022-04-01", 3, 10, 1, 3),
  (12, "2022-11-18", 2, 1, 1, 1),
  (13, "2022-04-01", 2, 2, 3, 1),
  (14, "2022-04-01", 2, 3, 6, 3),
  (15, "2022-04-01", 1, 4, 5, 1),
  (16, "2022-04-01", 1, 5, 1, 1),
  (17, "2022-11-18", 3, 15, 2, 1),
  (18, "2022-11-18", 3, 1, 7, 3),
  (19, "2022-10-18", 2, 16, 5, 2),
  (20, "2022-09-18", 2, 1, 6, 1),
  (21, "2022-08-18", 1, 13, 2, 3),
  (22, "2022-07-18", 2, 7, 3, 1),
  (23, "2022-06-18", 1, 3, 5, 2),
  (24, "2022-05-18", 3, 7, 1, 1),
  (25, "2022-04-01", 3, 1, 1, 3),
  (26, "2022-04-01", 2, 9, 4, 1),
  (27, "2022-04-01", 3, 8, 1, 1),
  (28, "2022-04-01", 3, 5, 3, 1),
  (29, "2022-11-18", 3, 11, 7, 1),
  (30, "2022-03-01", 1, 12, 7, 1),
  (31, "2022-12-01", 3, 13, 2, 3),
  (32, "2022-12-01", 2, 14, 1, 1),
  (33, "2022-12-01", 2, 6, 2, 2),
  (34, "2022-11-18", 3, 4, 5, 2) 
;

-- sqlite command
.mode markdown
.header on
  
-- write SQL 3-5 queries analyze data
-- 1x subquery/with
-- 1. What a month is top 3 most income in 2022 ?
/*SELECT 
  strftime('%m', order_date) AS monthly,
  sum(price) AS sum_of_month
FROM (
    SELECT 
    order_date,
    t.menu_id,
    m.menu_id,
    m.price
    FROM transactions AS t, menu AS m
    WHERE t.menu_id = m.menu_id
)
GROUP BY monthly
ORDER BY sum_of_month DESC
LIMIT 3;*/
-----------------------------------------------------------------
-- 2. What a month is top 3 lowest income in 2022 ?
/*WITH sub AS (
  SELECT 
    order_date,
    t.menu_id,
    m.menu_id,
    m.price
    FROM transactions AS t, menu AS m
    WHERE t.menu_id = m.menu_id
)

SELECT 
  strftime('%m', order_date) AS monthly,
  sum(price) AS sum_of_month
FROM sub
GROUP BY monthly
ORDER BY sum_of_month
LIMIT 3;*/
-----------------------------------------------------------------
-- 3. Who a manager is a number #1 make income for restaurant in 2022 ?
/*WITH sub AS (
  SELECT
    *
FROM transactions AS t, branch AS b, menu AS m
WHERE t.branch_id = b.branch_id 
  AND t.menu_id = m.menu_id
)

SELECT
  manager_name,
  sum(price)
FROM sub
GROUP BY manager_name
ORDER BY sum(price) DESC
LIMIT 1;*/
-----------------------------------------------------------------
-- 4. Where a location of customers is a top spender in 2022 ?
/*WITH sub AS(
  SELECT 
  *
  FROM transactions AS t, customers AS c, menu AS m
  WHERE t.customer_id = c.customer_id
    AND t.menu_id = m.menu_id
)
  
SELECT
  location,
  sum(price) AS sumOfPrice
FROM sub
GROUP BY location
ORDER BY sumOfPrice DESC
LIMIT 1;*/
-----------------------------------------------------------------
-- 5. What a top orders(menu) in April 2022 ?
/*WITH sub AS(
  SELECT
    *
  FROM transactions AS t, menu AS m
  WHERE t.menu_id = m.menu_id
)
  
SELECT
  strftime('%m', order_date) AS monthly,
  menu_name,
  COUNT(menu_name) AS n_menu
FROM sub
WHERE monthly = '04'
GROUP BY menu_name
ORDER BY n_menu DESC;*/
--------------------------------------------------------
-- 6. what is the best seller menu of all time
select menu_name,count(*) as n_menu
from transactions, menu 
where transactions.menu_id = menu.menu_id
group by menu_name
order by n_menu desc;
