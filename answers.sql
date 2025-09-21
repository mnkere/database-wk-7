


/*Question 1: Achieving 1NF*/
-- Create the original table (for context)
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(50),
    Products VARCHAR(255)
);

-- SQL query to transform to 1NF
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) numbers
    ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n - 1
ORDER BY OrderID, Product;




/*Question 2: Achieving 2NF*/
-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails
ORDER BY OrderID;

-- Step 2: Create OrderItems table (keeps only full dependencies)
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails
ORDER BY OrderID, Product;

-- Verify the new structure
SELECT * FROM Orders;
SELECT * FROM OrderItems;