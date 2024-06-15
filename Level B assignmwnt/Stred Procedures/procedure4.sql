-- Create a procedure DeleteOrderDetails that takes OrderlD and ProductID and
-- deletes that from Order Details table. Your procedure should validate parameters.
-- It should return an error code (-1) and print a message if the parameters are
-- invalid. Parameters are valid if the given order ID appears in the table and if the
-- given product ID appears in that order.

-- Step 1: Creating Sample Data
CREATE TABLE SalesOrderDetail (
    SalesOrderID INT,
    ProductID INT,
    OrderQty INT,
    UnitPrice DECIMAL(10, 2),
    PRIMARY KEY (SalesOrderID, ProductID)
);
GO
-- Inserting sample data into the SalesOrderDetail table
INSERT INTO SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice) VALUES
(1, 100, 2, 19.99),
(1, 101, 1, 29.99),
(2, 100, 3, 19.99),
(2, 102, 1, 39.99);
GO


---------------------------------------------------


-- Step 2: Creating the DeleteOrderDetails Stored Procedure
IF OBJECT_ID('DeleteOrderDetails', 'P') IS NOT NULL
DROP PROCEDURE DeleteOrderDetails;
GO
-- Creating the DeleteOrderDetails stored procedure
CREATE PROCEDURE DeleteOrderDetails
    @SalesOrderID INT,
    @ProductID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Checking if the SalesOrderID exists in the table
    IF NOT EXISTS (SELECT 1 FROM SalesOrderDetail WHERE SalesOrderID = @SalesOrderID)
    BEGIN
        PRINT 'Error: SalesOrderID does not exist.';
        RETURN -1;
    END

    -- Checking if the ProductID exists for the given SalesOrderID
    IF NOT EXISTS (SELECT 1 FROM SalesOrderDetail WHERE SalesOrderID = @SalesOrderID AND ProductID = @ProductID)
    BEGIN
        PRINT 'Error: ProductID does not exist for the given SalesOrderID.';
        RETURN -1;
    END

    -- Deleting the record if both SalesOrderID and ProductID are valid
    DELETE FROM SalesOrderDetail
    WHERE SalesOrderID = @SalesOrderID AND ProductID = @ProductID;

    PRINT 'Order details deleted successfully.';
    RETURN 0;
END;
GO


---------------------------------------------------


-- Step 3: Testing the Stored Procedure
EXEC DeleteOrderDetails @SalesOrderID = 1, @ProductID = 101;