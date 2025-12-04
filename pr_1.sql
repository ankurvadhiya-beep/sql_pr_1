CREATE DATABASE DataDiger;
USE DataDiger;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);

INSERT INTO Customers (Name, Email, Address) VALUES
('Alice', 'alice@gmail.com', 'Delhi'),
('Bob', 'bob@yahoo.com', 'Mumbai'),
('Charlie', 'charlie@gmail.com', 'Pune'),
('David', 'david@hotmail.com', 'Surat'),
('Ema', 'ema@gmail.com', 'Ahmedabad');

SELECT * FROM Customers;

UPDATE Customers SET Address='Gandhinagar' WHERE CustomerID=3;

DELETE FROM Customers WHERE CustomerID=2;

SELECT * FROM Customers WHERE Name='Alice';


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-01-02', 1500),
(3, '2025-01-05', 2200),
(4, '2025-01-12', 800),
(1, '2025-01-15', 4200),
(5, '2025-01-18', 1200);

SELECT * FROM Orders WHERE CustomerID=1;

UPDATE Orders SET TotalAmount=5000 WHERE OrderID=4;

DELETE FROM Orders WHERE OrderID=3;

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT 
    MAX(TotalAmount) AS HighestOrder,
    MIN(TotalAmount) AS LowestOrder,
    AVG(TotalAmount) AS AverageOrder
FROM Orders;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 45000, 10),
('Mouse', 500, 100),
('Keyboard', 1200, 50),
('Monitor', 7000, 20),
('Headphones', 1500, 25);

SELECT * FROM Products ORDER BY Price DESC;

UPDATE Products SET Price=8000 WHERE ProductID=4;

DELETE FROM Products WHERE Stock=0;

SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;

SELECT MAX(Price) AS MostExpensive, MIN(Price) AS Cheapest FROM Products;


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 2, 2, 1000),
(1, 5, 1, 1500),
(2, 1, 1, 45000),
(4, 3, 2, 2400),
(5, 4, 1, 7000);

SELECT * FROM OrderDetails WHERE OrderID=1;

SELECT SUM(SubTotal) AS TotalRevenue FROM OrderDetails;

SELECT ProductID, SUM(Quantity) AS TotalQty
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalQty DESC
LIMIT 3;

SELECT ProductID, COUNT(*) AS TimesSold
FROM OrderDetails
GROUP BY ProductID;

