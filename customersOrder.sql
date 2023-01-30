-- How many orders were placed in January?
SELECT COUNT(*) 
FROM BIT_DB.JanSales
WHERE 
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID';

-- How many of those orders were for an iPhone?
SELECT COUNT(*) 
FROM BIT_DB.JanSales
WHERE 
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID' AND
    Product = 'iPhone';

-- Select the customer account numbers for all the orders that were placed in February.
SELECT 
    customers.acctnum AS 'Account Numbers'
FROM BIT_DB.customers customers
JOIN BIT_DB.FebSales febSales
ON customers.order_id = febSales.orderID
WHERE 
    LENGTH(febSales.orderID) = 6 AND
    febSales.orderID != 'Order ID';

-- Which product was the cheapest one sold in January, and what was the price?
SELECT 
    Product,
    price AS 'Price'
FROM BIT_DB.JanSales
WHERE 
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID'
ORDER BY 2 
LIMIT 1;

-- What is the total revenue for each product sold in January?

SELECT 
    Product,
    SUM(Quantity) * price AS 'Revenue'
FROM BIT_DB.JanSales
WHERE 
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID'
GROUP BY Product;

-- Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, 
-- and what was the total revenue?
SELECT
    Product,
    SUM(Quantity) AS 'Quantity',
    SUM(Quantity) * price AS 'Total Revenue'
FROM BIT_DB.FebSales
WHERE 
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID' AND
    location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY Product;

-- How many customers ordered more than 2 products at a time in February, and what was the average amount spent for those customers?

SELECT
    COUNT(DISTINCT BIT_DB.customers.acctnum) AS 'Number of Customers',
    ROUND(AVG(Quantity) * price, 2) AS 'Average Amount Spent'
FROM BIT_DB.customers customers
LEFT JOIN BIT_DB.FebSales FebSales
ON customers.order_id = FebSales.orderID
WHERE 
    Quantity > 2 AND
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID';

-- List all the products sold in Los Angeles in February, and include how many of 
-- each were sold

SELECT 
    Product, 
    SUM(Quantity) AS 'Quantity'
FROM BIT_DB.FebSales
WHERE 
    location LIKE '%Los Angeles%' AND
    LENGTH(orderID) = 6 AND
    orderID != 'Order ID'
GROUP BY Product;

-- Which locations in New York received at least 3 orders in January, and how many orders did they each receive?
SELECT 
    location AS 'Location',
    COUNT(*) AS 'Number of Orders'
FROM BIT_DB.JanSales
WHERE
    location LIKE '%New York%' 
GROUP BY location
HAVING COUNT(*) >= 3;