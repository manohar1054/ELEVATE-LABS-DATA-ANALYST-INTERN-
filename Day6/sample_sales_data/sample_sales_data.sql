---ELEVATE LABS DATA ANALYST INTERN ON 15TH APRIL 2025---

create database sales_data_sample
use sales_data_sample
select * from sales_data_sample
----------Query for Monthly Revenue--------
SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    SUM(SALES) AS TotalRevenue
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY
    Month;
	-------Query for Monthly Order Volume---------
	SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY
    Month
	-----Combine Revenue and Orders (Optional)---
	SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    SUM(SALES) AS TotalRevenue,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY
    Month;
	------ Top 5 Months with Highest Revenue-----
SELECT TOP 5
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    SUM(SALES) AS TotalRevenue
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY
    TotalRevenue DESC;
	------Top 5 Products by Total Sales----
	SELECT TOP 5
    PRODUCTCODE,
    SUM(SALES) AS TotalSales
FROM
    sales_data_sample
GROUP BY
    PRODUCTCODE
ORDER BY
    TotalSales DESC;


	------Monthly Order Count by Product-----
	SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    PRODUCTCODE,
    COUNT(DISTINCT ORDERNUMBER) AS OrderCount
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM'),
    PRODUCTCODE
ORDER BY
    Month, OrderCount DESC;
	------Top 5 Customers by Total Revenue------
	SELECT TOP 5
    CUSTOMERNAME,
    SUM(SALES) AS TotalRevenue
FROM
    sales_data_sample
GROUP BY
    CUSTOMERNAME
ORDER BY
    TotalRevenue DESC;

	-----------Average Sales per Order by Month--------
	SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    AVG(SALES) AS AvgOrderValue
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY
    Month;
	------ Revenue Trend per Product Over Time----
	SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    PRODUCTCODE,
    SUM(SALES) AS TotalSales
FROM
    sales_data_sample
GROUP BY
    FORMAT(ORDERDATE, 'yyyy-MM'), PRODUCTCODE
ORDER BY
    Month, PRODUCTCODE;

	-----Total Quantity Ordered per Product (Sales Volume)-----
	SELECT
    PRODUCTCODE,
    SUM(QUANTITYORDERED) AS TotalQuantity
FROM
    sales_data_sample
GROUP BY
    PRODUCTCODE
ORDER BY
    TotalQuantity DESC;
	-----Month-over-Month Revenue Growth----
	WITH MonthlyRevenue AS (
    SELECT
        FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
        SUM(SALES) AS TotalRevenue
    FROM
        sales_data_sample
    GROUP BY
        FORMAT(ORDERDATE, 'yyyy-MM')
)
SELECT
    Month,
    TotalRevenue,
    LAG(TotalRevenue) OVER (ORDER BY Month) AS PreviousMonthRevenue,
    ROUND(
        (TotalRevenue - LAG(TotalRevenue) OVER (ORDER BY Month)) * 100.0 /
        NULLIF(LAG(TotalRevenue) OVER (ORDER BY Month), 0), 2
    ) AS MoM_Growth_Percent
FROM MonthlyRevenue;
----Customer Lifetime Value (CLTV) - Total Spent Per Customer---
SELECT
    CUSTOMERNAME,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders,
    SUM(SALES) AS TotalSpent,
    AVG(SALES) AS AvgSpentPerOrder
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY TotalSpent DESC;
------ First and Last Order Date per Customer------
SELECT
    CUSTOMERNAME,
    MIN(ORDERDATE) AS FirstOrderDate,
    MAX(ORDERDATE) AS LastOrderDate,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY FirstOrderDate;
------ Average Revenue per Product per Month-----
SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    PRODUCTCODE,
    AVG(SALES) AS AvgMonthlyRevenue
FROM sales_data_sample
GROUP BY FORMAT(ORDERDATE, 'yyyy-MM'), PRODUCTCODE
ORDER BY Month, AvgMonthlyRevenue DESC;
------Most Ordered Product per Month-----
WITH MonthlyProductSales AS (
    SELECT
        FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
        PRODUCTCODE,
        SUM(QUANTITYORDERED) AS TotalQty
    FROM sales_data_sample
    GROUP BY FORMAT(ORDERDATE, 'yyyy-MM'), PRODUCTCODE
),
RankedProducts AS (
    SELECT *,
        RANK() OVER (PARTITION BY Month ORDER BY TotalQty DESC) AS rnk
    FROM MonthlyProductSales
)
SELECT Month, PRODUCTCODE, TotalQty
FROM RankedProducts
WHERE rnk = 1;


-----Best-Selling Day of the Week (across all time)-----
SELECT
    DATENAME(WEEKDAY, ORDERDATE) AS DayOfWeek,
    COUNT(DISTINCT ORDERNUMBER) AS OrderCount,
    SUM(SALES) AS TotalRevenue
FROM sales_data_sample
GROUP BY DATENAME(WEEKDAY, ORDERDATE)
ORDER BY TotalRevenue DESC;
--Orders by Quarter----
SELECT
    CONCAT(YEAR(ORDERDATE), '-Q', DATEPART(QUARTER, ORDERDATE)) AS Quarter,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders,
    SUM(SALES) AS TotalRevenue
FROM sales_data_sample
GROUP BY YEAR(ORDERDATE), DATEPART(QUARTER, ORDERDATE)
ORDER BY Quarter;
------Top Customer by Month-----
WITH MonthlyCustomerRevenue AS (
    SELECT
        FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
        CUSTOMERNAME,
        SUM(SALES) AS Revenue
    FROM sales_data_sample
    GROUP BY FORMAT(ORDERDATE, 'yyyy-MM'), CUSTOMERNAME
),
RankedRevenue AS (
    SELECT *,
        RANK() OVER (PARTITION BY Month ORDER BY Revenue DESC) AS rnk
    FROM MonthlyCustomerRevenue
)
SELECT Month, CUSTOMERNAME, Revenue
FROM RankedRevenue
WHERE rnk = 1;

---- Repeat vs. First-Time Customers----
WITH CustomerOrderStats AS (
    SELECT
        CUSTOMERNAME,
        COUNT(DISTINCT ORDERNUMBER) AS OrderCount
    FROM sales_data_sample
    GROUP BY CUSTOMERNAME
)
SELECT
    CASE
        WHEN OrderCount = 1 THEN 'First-Time'
        ELSE 'Repeat'
    END AS CustomerType,
    COUNT(*) AS CustomerCount
FROM CustomerOrderStats
GROUP BY
    CASE
        WHEN OrderCount = 1 THEN 'First-Time'
        ELSE 'Repeat'
    END;
	-----Order Size Buckets-----
	SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    SALES,
    CASE
        WHEN SALES < 500 THEN 'Small'
        WHEN SALES BETWEEN 500 AND 2000 THEN 'Medium'
        ELSE 'Large'
    END AS OrderSize
FROM sales_data_sample;
----Monthly Unique Products Sold----
SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    COUNT(DISTINCT PRODUCTCODE) AS UniqueProductsSold
FROM sales_data_sample
GROUP BY FORMAT(ORDERDATE, 'yyyy-MM')
ORDER BY Month;
------Create a View for Monthly Sales Summary---
CREATE VIEW vw_MonthlySalesSummary AS
SELECT
    FORMAT(ORDERDATE, 'yyyy-MM') AS Month,
    SUM(SALES) AS TotalRevenue,
    COUNT(DISTINCT ORDERNUMBER) AS TotalOrders,
    COUNT(DISTINCT CUSTOMERNAME) AS ActiveCustomers
FROM sales_data_sample
GROUP BY FORMAT(ORDERDATE, 'yyyy-MM');
---------------------------------THANK YOU BY DURGAM MANOHAR-------------------------------------------
-------------------------------------------------------------------------------------------------------
