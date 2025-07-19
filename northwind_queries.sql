-- Query 1: Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Query 2: Top 10 Customers by Revenue
SELECT
    c.id AS customer_id,
    c.company AS company_name,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
GROUP BY c.id, c.company
ORDER BY total_revenue DESC;


-- Query 3: Customer Order Frequency
SELECT 
    c.id AS customer_id,
    c.company AS company_name,
    COUNT(o.id) AS order_count
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.company
ORDER BY order_count DESC;


-- Query 4: Countries with the most customers
SELECT 
    country_region,
    COUNT(*) AS number_of_customers
FROM customers
GROUP BY country_region
ORDER BY number_of_customers DESC;


-- Query 5: Monthly Sales Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS monthly_sales
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY order_month
ORDER BY order_month;


-- Query 6: Yearly Sales Comparison
SELECT 
    YEAR(o.order_date) AS order_year,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_sales
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY order_year
ORDER BY order_year;


-- Query 7: Average Order Value
SELECT 
    ROUND(SUM(od.unit_price * od.quantity) / COUNT(DISTINCT o.id), 2) AS average_order_value
FROM orders o
JOIN order_details od ON o.id = od.order_id;


-- Query 8: Top 10 Best-Selling Products by Quantity
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od ON p.id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;


-- Query 9: Revenue by Product
SELECT 
    p.product_name,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_revenue
FROM products p
JOIN order_details od ON p.id = od.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- Query 10: Revenue by U.S. State
SELECT 
    c.state_province AS state,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_revenue
FROM 
    customers c
JOIN 
    orders o ON c.id = o.customer_id
JOIN 
    order_details od ON o.id = od.order_id
GROUP BY 
    c.state_province
ORDER BY 
    total_revenue DESC;

-- Query 11: Total Orders Handled Per Employee
SELECT
    e.id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(o.id) AS total_orders_handled
FROM employees e
JOIN orders o ON e.id = o.employee_id
GROUP BY e.id, employee_name
ORDER BY total_orders_handled DESC;



-- Query 12: Revenue per Employee
SELECT 
    e.id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ROUND(SUM(od.unit_price * od.quantity), 2) AS total_revenue
FROM employees e
JOIN orders o ON e.id = o.employee_id
JOIN order_details od ON o.id = od.order_id
GROUP BY e.id, employee_name
ORDER BY total_revenue DESC;


-- Query 13: Top Suppliers by Total Product Volume
SELECT 
    s.id AS supplier_id,
    s.company AS supplier_name,
    SUM(od.quantity) AS total_quantity_supplied
FROM suppliers s
JOIN products p ON s.id = p.supplier_ids
JOIN order_details od ON p.id = od.product_id
GROUP BY s.id, s.company
ORDER BY total_quantity_supplied DESC
LIMIT 10;


-- Query 14: Number of Products per Supplier
SELECT 
    s.id AS supplier_id,
    s.company AS supplier_name,
    COUNT(p.id) AS number_of_products
FROM suppliers s
JOIN products p ON s.id = p.supplier_ids
GROUP BY s.id, s.company
ORDER BY number_of_products DESC;


-- Query 15: Number of Orders per Status
SELECT 
    CASE 
        WHEN shipped_date IS NOT NULL THEN 'Shipped'
        ELSE 'Pending'
    END AS order_status,
    COUNT(*) AS number_of_orders
FROM orders
GROUP BY order_status
ORDER BY number_of_orders DESC;


 -- Query 16: Inventory Movements Over Time
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(od.quantity) AS total_units_sold
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY order_month
ORDER BY order_month;



