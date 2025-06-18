-- Create the database
CREATE DATABASE Ecommerce_Management_System;
GO

USE Ecommerce_Management_System;
GO

-- Create tables with proper relationships and constraints
CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY IDENTITY(101, 1),
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    City VARCHAR(50),
    Zip_Code VARCHAR(50),
    Street VARCHAR(50),
    Registration_date DATE NOT NULL,
    Role VARCHAR(50) NOT NULL CHECK (Role IN ('Customer', 'Admin'))
);

CREATE TABLE Category (
    Category_id INT PRIMARY KEY IDENTITY(201, 1),
    Category_name VARCHAR(50) NOT NULL,
    Category_description VARCHAR(50)
);

CREATE TABLE Products (
    Product_id INT PRIMARY KEY IDENTITY(301, 1),
    Product_name VARCHAR(50) NOT NULL,
    Description VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0),
    Cost_price DECIMAL(10, 2) NOT NULL CHECK (Cost_price > 0),
    Stock_quantity INT NOT NULL DEFAULT 0 CHECK (Stock_quantity >= 0),
    Category_id INT NOT NULL FOREIGN KEY REFERENCES Category(Category_id)
);

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY IDENTITY(401, 1),
    Customer_id INT NOT NULL FOREIGN KEY REFERENCES Customers(Customer_id),
    Order_date DATE NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    Total_amount DECIMAL(10, 2) NOT NULL CHECK (Total_amount >= 0)
);

CREATE TABLE Order_items (
    Order_item_id INT PRIMARY KEY IDENTITY(501, 1),
    Order_id INT NOT NULL FOREIGN KEY REFERENCES Orders(Order_id),
    Product_id INT NOT NULL FOREIGN KEY REFERENCES Products(Product_id),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price_at_time DECIMAL(10, 2) NOT NULL CHECK (Price_at_time > 0)
);

CREATE TABLE Payment (
    Payment_id INT PRIMARY KEY IDENTITY(601, 1),
    Order_id INT NOT NULL FOREIGN KEY REFERENCES Orders(Order_id),
    Payment_method VARCHAR(50) NOT NULL CHECK (Payment_method IN ('Cash on Delivery', 'Credit Card', 'PayPal')),
    Payment_status VARCHAR(50) NOT NULL CHECK (Payment_status IN ('Paid', 'Failed', 'Refunded')),
    Payment_date DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0)
);

CREATE TABLE Reviews (
    Review_id INT PRIMARY KEY IDENTITY(701, 1),
    Customer_id INT NOT NULL FOREIGN KEY REFERENCES Customers(Customer_id),
    Product_id INT NOT NULL FOREIGN KEY REFERENCES Products(Product_id),
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(100),
    Review_date DATE NOT NULL
);

CREATE TABLE Wishlist (
    Wishlist_id INT PRIMARY KEY IDENTITY(801, 1),
    Customer_id INT NOT NULL FOREIGN KEY REFERENCES Customers(Customer_id),
    Product_id INT NOT NULL FOREIGN KEY REFERENCES Products(Product_id),
    Date_added DATE NOT NULL
);

-- Insert data with proper relationships
-- Customers (8 customers)
INSERT INTO Customers (First_Name, Last_Name, Email, Password, Phone, City, Zip_Code, Street, Registration_date, Role)
VALUES 
('Ali', 'Hamza', 'alihamza1@gmail.com', '@1234abcd', '030-56873835', 'Islamabad', '1254', '16', '2024-02-02', 'Customer'),
('Muhammad', 'Omer', 'omer123@gmail.com', '@456efg', '034-56782589', 'Jhelum', '4356', '12', '2024-02-02', 'Customer'),
('Burhan', 'Ali', 'Burhan123@gmail.com', '@789hijk', '032-06528954', 'Karachi', '4323', '23', '2024-02-02', 'Customer'),
('Sara', 'Malik', 'Sara456@gmail.com', '@890lmno', '033-75668892', 'Lahore', '5567', '54', '2024-02-02', 'Customer'),
('Zara', 'Fatima', 'zara546@gmail.com', '@1112pqrs', '033-55991102', 'Multan', '1234', '43', '2024-02-02', 'Admin'),
('Ishaq', 'Ali', 'Ishaq486@gmail.com', '@1314tuvw', '032-88365499', 'Gujrat', '7865', '33', '2024-02-02', 'Admin'),
('Ali', 'Hamza', 'Ali109@gmail.com', '@1516xyz', '031-89532789', 'Kashmir', '5375', '23', '2024-02-02', 'Customer'),
('Saif', 'Malik', 'Saif987@gmail.com', '@1718abcd', '032-87846789', 'Lahore', '5435', '55', '2024-02-02', 'Customer');

-- Categories (5 categories)
INSERT INTO Category (Category_name, Category_description)
VALUES 
('Electronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and accessories'),
('Books', 'Fiction and non-fiction Books'),
('Home and kitchen', 'Household Items'),
('Toys', 'Kid toys and games');

-- Products (18 products)
INSERT INTO Products (Product_name, Description, Price, Cost_price, Stock_quantity, Category_id)
VALUES 
('Smartphone', 'Latest model smartphone with 128GB storage.', 599.99, 450.00, 50, 201),
('Laptop', '15-inch laptop with 8GB RAM and 256GB SSD.', 999.99, 800.00, 30, 201),
('Headphones', 'Wireless noise-cancelling headphones.', 199.99, 150.00, 100, 201),
('Monitor', '24-inch HD monitor with HDMI input.', 149.99, 120.00, 40, 201),
('T-Shirt', 'Cotton unisex T-shirt in various colors.', 19.99, 10.00, 200, 202),
('Jeans', 'Denim jeans with a slim fit design.', 49.99, 30.00, 100, 202),
('Jacket', 'Waterproof windbreaker jacket.', 89.99, 60.00, 60, 202),
('Dress', 'Summer floral dress, sizes XS-XL.', 39.99, 25.00, 70, 202),
('Mystery Novel', 'Bestselling mystery fiction novel.', 14.99, 8.00, 120, 203),
('SQL Programming Book', 'Learn SQL with practical examples.', 39.99, 25.00, 40, 203),
('Fairy Tales', 'Collection of classic fairy tales for children.', 9.99, 5.00, 70, 203),
('Coffee Maker', 'Automatic drip coffee maker, 12-cup capacity.', 79.99, 50.00, 25, 204),
('Blender', 'High-speed blender for smoothies.', 59.99, 40.00, 15, 204),
('Cushion', 'Decorative throw cushion for sofas.', 24.99, 15.00, 50, 204),
('Table Lamp', 'LED table lamp with adjustable brightness.', 22.99, 15.00, 30, 204),
('Teddy Bear', 'Soft plush teddy bear, 12-inch tall.', 29.99, 18.00, 80, 205),
('LEGO Set', 'Creative building block LEGO set (500 pieces).', 69.99, 45.00, 45, 205),
('Puzzle', '1000-piece jigsaw puzzle, 24x18 inches.', 19.99, 12.00, 100, 205);

SELECT * FROM Order_items;
-- First, clear any existing data that might cause conflicts
DELETE FROM Payment;
DELETE FROM Order_items;
DELETE FROM Orders;
-- Reset the identity counter for Orders
DBCC CHECKIDENT ('Orders', RESEED, 400);
-- Now insert Orders - these will get IDs 401-410
INSERT INTO Orders (Customer_id, Order_date, Status, Total_amount)
VALUES
(101, '2023-11-30', 'Pending', 169.96),    -- This will be Order_id 401
(105, '2023-11-18', 'Cancelled', 139.98),   -- Order_id 402
(103, '2023-11-09', 'Pending', 1284.96),    -- Order_id 403
(108, '2023-11-01', 'Delivered', 369.94),   -- Order_id 404
(105, '2023-11-26', 'Shipped', 2029.97),    -- Order_id 405
(108, '2023-11-05', 'Cancelled', 214.92),   -- Order_id 406
(107, '2023-11-19', 'Shipped', 1922.94),    -- Order_id 407
(108, '2023-11-07', 'Cancelled', 1919.94),  -- Order_id 408
(108, '2023-11-06', 'Cancelled', 324.92),   -- Order_id 409
(106, '2023-11-18', 'Shipped', 999.99);     -- Order_id 410

-- Now insert Order_items with correct Order_id references (401-410)
INSERT INTO Order_items (Order_id, Product_id, Quantity, Price_at_time)
VALUES 
-- Order 401 items (Order_id 401)
(401, 308, 2, 39.99),
(401, 309, 1, 9.99),
(401, 310, 1, 79.99),

-- Order 402 items (Order_id 402)
(402, 314, 2, 69.99),

-- Order 403 items (Order_id 403)
(403, 307, 1, 14.99),
(403, 314, 1, 69.99),
(403, 301, 2, 599.99),

-- Order 404 items (Order_id 404)
(404, 317, 2, 39.99),
(404, 310, 3, 79.99),
(404, 305, 1, 49.99),

-- Order 405 items (Order_id 405)
(405, 302, 2, 999.99),
(405, 313, 1, 29.99),

-- Order 406 items (Order_id 406)
(406, 307, 3, 14.99),
(406, 305, 3, 49.99),
(406, 309, 2, 9.99),

-- Order 407 items (Order_id 407)
(407, 301, 3, 599.99),
(407, 305, 2, 49.99),
(407, 318, 1, 22.99),

-- Order 408 items (Order_id 408)
(408, 317, 3, 39.99),
(408, 301, 3, 599.99),

-- Order 409 items (Order_id 409)
(409, 307, 3, 14.99),
(409, 317, 3, 39.99),
(409, 310, 2, 79.99),

-- Order 410 items (Order_id 410)
(410, 302, 1, 999.99);

-- Now insert Payments that reference the Orders
INSERT INTO Payment (Order_id, Payment_method, Payment_status, Payment_date, Amount)
VALUES 
(401, 'Cash on Delivery', 'Paid', '2023-11-30', 169.96),
(402, 'Cash on Delivery', 'Failed', '2023-11-18', 139.98),
(403, 'Cash on Delivery', 'Failed', '2023-11-09', 1284.96),
(404, 'Credit Card', 'Refunded', '2023-11-01', 369.94),
(405, 'Cash on Delivery', 'Paid', '2023-11-26', 2029.97),
(406, 'Credit Card', 'Paid', '2023-11-05', 214.92),
(407, 'PayPal', 'Paid', '2023-11-19', 1922.94),
(408, 'Credit Card', 'Refunded', '2023-11-07', 1919.94),
(409, 'Credit Card', 'Paid', '2023-11-06', 324.92),
(410, 'Cash on Delivery', 'Refunded', '2023-11-18', 999.99);

-- Reviews (10 reviews)
INSERT INTO Reviews (Product_id, Customer_id, Rating, Comment, Review_date)
VALUES 
(311, 101, 3, 'Five stars, perfect!', '2023-12-07'),
(316, 101, 4, 'Excellent quality and fast shipping.', '2023-12-01'),
(317, 108, 2, 'Good value for the price.', '2023-12-05'),
(304, 104, 5, 'Good value for the price.', '2023-12-15'),
(311, 103, 5, 'Good value for the price.', '2023-12-27'),
(304, 101, 1, 'Terrible customer service.', '2023-12-06'),
(307, 101, 3, 'Five stars, perfect!', '2023-12-13'),
(301, 108, 1, 'Good value for the price.', '2023-12-24'),
(305, 105, 2, 'Great product, highly recommend!', '2023-12-29'),
(316, 102, 5, 'Five stars, perfect!', '2023-12-12');

-- Wishlist (6 wishlist items)
INSERT INTO Wishlist (Customer_id, Product_id, Date_added)
VALUES 
(107, 315, '2023-11-22'),  -- Customer 107 wants LEGO Set
(108, 310, '2023-11-30'),  -- Customer 108 wants Coffee Maker
(108, 311, '2023-11-15'),  -- Customer 108 wants Blender
(101, 317, '2023-11-26'),  -- Customer 101 wants Dress
(107, 309, '2023-11-14'),  -- Customer 107 wants Fairy Tales
(106, 303, '2023-11-15');  -- Customer 106 wants Headphones

-- Display products table
SELECT * FROM Products;

-- ================================================
-- ADMIN PANEL – DASHBOARD SUMMARY
-- ================================================

-- Total delivered sales
SELECT SUM(Total_amount) AS Total_Sales
FROM Orders
WHERE Status = 'Delivered';

-- Count of all orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- Products with low stock (less than 5)
SELECT * FROM Products
WHERE Stock_quantity < 5;

-- ================================================
--  ADMIN PANEL – MANAGE PRODUCTS
-- ================================================

-- Add a new product
INSERT INTO Products (Product_name, Description, Price, Cost_price, Stock_quantity, Category_id)
VALUES ('Wireless Mouse', 'Ergonomic wireless mouse', 25.99, 15.00, 80, 201);

-- Update a product
UPDATE Products
SET Price = 29.99, Stock_quantity = 90
WHERE Product_id = 301;

-- Delete a product
DELETE FROM Products
WHERE Product_id = 301;

-- ================================================
--  ADMIN PANEL – MANAGE CATEGORIES
-- ================================================

-- Add new category
INSERT INTO Category (Category_name, Category_description)
VALUES ('Gaming Accessories', 'Keyboards, mice, headsets');

-- Edit existing category
UPDATE Category
SET Category_name = 'Gaming Gear'
WHERE Category_id = 201;

-- Delete a category
DELETE FROM Category
WHERE Category_id = 201;

-- ================================================
-- ADMIN PANEL – VIEW ALL ORDERS
-- ================================================

SELECT * FROM Orders
ORDER BY Order_date DESC;

-- ================================================
-- ADMIN PANEL – UPDATE ORDER STATUS
-- ================================================

UPDATE Orders
SET Status = 'Shipped'
WHERE Order_id = 401;

-- ================================================
--  ADMIN PANEL – MANAGE USERS
-- ================================================

-- View all users
SELECT Customer_id, First_Name, Last_Name, Email, Role
FROM Customers;

-- Delete a user
DELETE FROM Customers
WHERE Customer_id = 105;

-- ================================================
--  ADMIN PANEL – MANAGE REVIEWS
-- ================================================

-- View all reviews with customer and product names
SELECT R.*, C.First_Name, P.Product_name
FROM Reviews R
JOIN Customers C ON R.Customer_id = C.Customer_id
JOIN Products P ON R.Product_id = P.Product_id;

-- Delete a review
DELETE FROM Reviews
WHERE Review_id = 701;

-- ================================================
-- ADMIN PANEL – VIEW PAYMENTS
-- ================================================

SELECT * FROM Payment
ORDER BY Payment_date DESC;

-- ================================================
--  ADMIN PANEL – SALES REPORTS
-- ================================================

-- Monthly sales summary
SELECT FORMAT(Order_date, 'yyyy-MM') AS Month, SUM(Total_amount) AS Total_Sales
FROM Orders
WHERE Status = 'Delivered'
GROUP BY FORMAT(Order_date, 'yyyy-MM');

-- Weekly sales summary
SELECT DATEPART(WEEK, Order_date) AS Week, SUM(Total_amount) AS Weekly_Sales
FROM Orders
WHERE Status = 'Delivered'
GROUP BY DATEPART(WEEK, Order_date);

-- ================================================
--  ADMIN PANEL – QUICK STATS
-- ================================================

-- Total number of users
SELECT COUNT(*) AS Total_Users
FROM Customers;

-- New users today
SELECT COUNT(*) AS New_Today
FROM Customers
WHERE Registration_date = CAST(GETDATE() AS DATE);

-- Total products count
SELECT COUNT(*) AS Total_Products
FROM Products;

-- ================================================
--  CUSTOMER PANEL – LOGIN & REGISTER
-- ================================================

-- Login verification
SELECT * FROM Customers
WHERE Email = 'john@example.com' AND Password = 'pass1234';

-- Register new user
INSERT INTO Customers (First_Name, Last_Name, Email, Password, Phone, City, Zip_Code, Street, Registration_date, Role)
VALUES ('John', 'Doe', 'john@example.com', 'pass1234', '032-12345678', 'Karachi', '40000', 'House 12', GETDATE(), 'Customer');

-- ================================================
--  CUSTOMER PANEL – BROWSE PRODUCTS
-- ================================================

-- Browse all products
SELECT * FROM Products;

-- Browse by category (e.g., Electronics)
SELECT * FROM Products
WHERE Category_id = 201;

-- ================================================
--  CUSTOMER PANEL – PLACE ORDER
-- ================================================

-- Place a new order
INSERT INTO Orders (Customer_id, Order_date, Status, Total_amount)
VALUES (101, GETDATE(), 'Pending', 49.98);

-- Get the new order ID
DECLARE @OrderId INT = SCOPE_IDENTITY();

-- Add order items
INSERT INTO Order_items (Order_id, Product_id, Quantity, Price_at_time)
VALUES (@OrderId, 301, 2, 24.99);

-- ================================================
-- CUSTOMER PANEL – VIEW ORDERS
-- ================================================

SELECT * FROM Orders
WHERE Customer_id = 101
ORDER BY Order_date DESC;

-- ================================================
--  CUSTOMER PANEL – WISHLIST
-- ================================================

-- View wishlist
SELECT W.*, P.Product_name
FROM Wishlist W
JOIN Products P ON W.Product_id = P.Product_id
WHERE W.Customer_id = 101;

-- Add to wishlist
INSERT INTO Wishlist (Customer_id, Product_id, Date_added)
VALUES (101, 310, GETDATE());

-- Remove from wishlist
DELETE FROM Wishlist
WHERE Wishlist_id = 801;

-- ================================================
-- CUSTOMER PANEL – LEAVE A REVIEW
-- ================================================

INSERT INTO Reviews (Product_id, Customer_id, Rating, Comment, Review_date)
VALUES (301, 101, 4, 'Nice and affordable', GETDATE());

-- ================================================
-- CUSTOMER PANEL – TRACK DELIVERY STATUS
-- ================================================

SELECT Order_id, Order_date, Status
FROM Orders
WHERE Customer_id = 101
ORDER BY Order_date DESC;

-- ================================================
-- CUSTOMER PANEL – EDIT PROFILE
-- ================================================

UPDATE Customers
SET Phone = '033-45678901', City = 'Lahore'
WHERE Customer_id = 101;

-- ================================================
-- CUSTOMER PANEL – PRODUCT FILTER (BY PRICE & CATEGORY)
-- ================================================

SELECT * FROM Products
WHERE Price BETWEEN 20 AND 100
AND Category_id = 201;

-- ================================================
--  CUSTOMER PANEL – DARK MODE TOGGLE
-- (Handled at UI level, not applicable to SQL)
