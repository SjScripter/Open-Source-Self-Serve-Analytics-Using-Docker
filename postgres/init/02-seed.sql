-- Insert Customers
INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice@example.com'),
('Bob', 'Johnson', 'bob@example.com'),
('Charlie', 'Brown', 'charlie@example.com'),
('Diana', 'Prince', 'diana@example.com'),
('Evan', 'Wright', 'evan@example.com');

-- Insert Products
INSERT INTO products (name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 1299.99, 50),
('Wireless Mouse', 'Electronics', 29.99, 200),
('Coffee Mug', 'Home', 14.50, 100),
('Desk Chair', 'Furniture', 199.00, 30),
('Mechanical Keyboard', 'Electronics', 89.99, 75);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-10-01 10:00:00', 'Completed'),
(2, '2023-10-03 14:30:00', 'Completed'),
(1, '2023-10-05 09:15:00', 'Shipped'),
(3, '2023-10-08 16:45:00', 'Processing'),
(4, '2023-10-10 11:20:00', 'Completed');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1299.99),
(1, 2, 2, 29.99),
(2, 4, 1, 199.00),
(3, 3, 4, 14.50),
(4, 5, 1, 89.99),
(5, 1, 1, 1299.99),
(5, 3, 1, 14.50);
