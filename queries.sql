-- Task 3: SQL for Data Analysis
-- Database: ecommerce

-- ================================
-- 1. Create Database
-- ================================
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- ================================
-- 2. Create orders Table
-- ================================
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    order_date DATE
);

-- ================================
-- 3. Insert Sample Data
-- ================================
INSERT INTO orders VALUES
(1, 101, 'Laptop', 50000, '2024-01-10'),
(2, 102, 'Mobile', 20000, '2024-01-11'),
(3, 101, 'Mouse', 500, '2024-01-12'),
(4, 103, 'Keyboard', 1500, '2024-01-13'),
(5, 102, 'Monitor', 12000, '2024-01-14');

-- ================================
-- 4. SELECT + WHERE
-- ================================
SELECT * FROM orders
WHERE amount > 10000;

-- ================================
-- 5. ORDER BY
-- ================================
SELECT * FROM orders
ORDER BY amount DESC;

-- ================================
-- 6. GROUP BY + Aggregate
-- ================================
SELECT user_id, SUM(amount) AS total_spent
FROM orders
GROUP BY user_id;

-- ================================
-- 7. Average Revenue Per User
-- ================================
SELECT AVG(user_total) AS avg_revenue_per_user
FROM (
    SELECT user_id, SUM(amount) AS user_total
    FROM orders
    GROUP BY user_id
) AS temp;

-- ================================
-- 8. Create users Table
-- ================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO users VALUES
(101, 'Rahul'),
(102, 'Priya'),
(103, 'Amit');

-- ================================
-- 9. INNER JOIN
-- ================================
SELECT u.name, o.product, o.amount
FROM users u
INNER JOIN orders o
ON u.user_id = o.user_id;

-- ================================
-- 10. Subquery Example
-- ================================
SELECT *
FROM orders
WHERE amount > (
    SELECT AVG(amount) FROM orders
);

-- ================================
-- 11. Create View
-- ================================
CREATE VIEW user_spending AS
SELECT user_id, SUM(amount) AS total_spent
FROM orders
GROUP BY user_id;

SELECT * FROM user_spending;

-- ================================
-- 12. Create Index (Optimization)
-- ================================
CREATE INDEX idx_user
ON orders(user_id);
