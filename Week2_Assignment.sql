-- create a project on ecommerce
-- create table 
-- customer, orders, Products, Suppliers
-- Practice the different joins 
-- Answer different business question with different joins 
-- Analyze and present the data using SQL Queries

CREATE DATABASE ecommerce;
USE ecommerce;
-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200),
    City VARCHAR(50)
);
-- Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(15),
    Country VARCHAR(50)
);
-- Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- Order Details Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- POPULATING TABLES
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, City) VALUES
(1, 'Jim', 'Halpert', 'jim.halpert@example.com', '123-456-7890', '123 Main St', 'New York'),
(2, 'Pam', 'Smith', 'pam.smith@example.com', '234-567-8901', '456 Oak Ave', 'Miami'),
(3, 'Michael', 'Gonzalez', 'michael.g@example.com', '345-678-9012', '789 Pine Rd', 'Los Angeles'),
(4, 'Angela', 'Martin', 'angela.m@example.com', '456-789-0123', '789 Pine Rd', 'Miami');

INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Phone, Country) VALUES
(1, 'TechSupplier Co.', 'Alice Johnson', '123-555-7890', 'USA'),
(2, 'GizmoWorks', 'Bob Lee', '234-555-8901', 'China'),
(3, 'GlobalMart', 'Charlie Brown', '345-555-9012', 'Germany');

INSERT INTO Products (ProductID, ProductName, SupplierID, Price) VALUES
(1, 'Smartphone', 1, 699.99),
(2, 'Laptop', 1, 1299.99),
(3, 'Tablet', NULL, NULL),
(4, 'Headphones', 3, 149.99),
(5, 'Smartwatch', 3, 199.99);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2024-09-01', 1699.97),
(2, 2, '2024-09-03', 549.98),
(3, 3, '2024-09-05', 149.99);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 699.99),
(2, 1, 2, 1, 1299.99),
(3, 2, 4, 2, 149.99),
(4, 3, 5, NULL, NULL);

-- JOINS
# Inner Join: Get all orders and their details
SELECT O.OrderID, C.FirstName, C.LastName, P.ProductName, Od.Quantity, Od.Price
FROM Orders AS O
JOIN Customers AS C ON O.CustomerID = C.CustomerID
JOIN OrderDetails AS Od ON O.OrderID = Od.OrderID
JOIN Products AS P ON Od.ProductID = P.ProductID;

# LEFT JOIN: orders and their corresponding order details
SELECT Od.OrderDetailID, P.ProductName, Od.Quantity
FROM OrderDetails AS Od
LEFT JOIN Products AS P ON Od.ProductID = P.ProductID;

# RIGHT JOIN: All products and their corresponding orders
SELECT P.ProductName, Od.OrderID, Od.Quantity
FROM Products AS P
RIGHT JOIN OrderDetails AS Od ON P.ProductID = Od.ProductID;

-- Revenue by customer
SELECT C.CustomerID, C.FirstName, SUM(O.TotalAmount)
FROM customers AS C
	JOIN orders AS O
		ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID;

-- Sales per product
SELECT P.ProductName, SUM(Od.Quantity) AS TotalSold
FROM Products AS P
JOIN OrderDetails AS Od ON P.ProductID = Od.ProductID
GROUP BY P.ProductName;









