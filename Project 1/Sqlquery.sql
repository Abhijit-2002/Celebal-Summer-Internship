CREATE TABLE Sales (
    ProductCategory VARCHAR(50),
    ProductName VARCHAR(50),
    SaleAmount INT
);

INSERT INTO Sales (ProductCategory, ProductName, SaleAmount) VALUES
('Electronics', 'Laptop', 1000),
('Electronics', 'Phone', 800),
('Electronics', 'Tablet', 500),
('Clothing', 'Shirt', 300),
('Clothing', 'Pants', 400),
('Furniture', 'Sofa', 1200),
('Furniture', 'Bed', 900);


--function

SELECT 
    CASE WHEN ProductCategory IS NULL THEN 'Total' ELSE ProductCategory END AS ProductCategory,
    ProductName,
    SUM(SaleAmount) AS TotalSales
FROM 
    Sales
GROUP BY 
    ProductCategory, ProductName WITH ROLLUP
ORDER BY 
    CASE WHEN ProductCategory IS NULL THEN 1 ELSE 0 END,
    ProductCategory,
    CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END,
    ProductName;

