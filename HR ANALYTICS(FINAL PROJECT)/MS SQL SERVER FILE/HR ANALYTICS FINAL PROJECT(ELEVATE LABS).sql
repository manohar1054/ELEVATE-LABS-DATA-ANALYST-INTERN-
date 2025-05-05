CREATE DATABASE EmployeeAttrition
USE EmployeeAttrition

---KPIS 
----🧮 1. Overall Attrition Rate
SELECT 
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate_Percent
FROM EmployeeAttrition;
--- 2. Attrition by Department
SELECT 
    Department,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;
---3. Attrition by Salary Band
SELECT 
    SalaryBand,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM (
    SELECT *,
        CASE 
            WHEN Monthly_Income < 3000 THEN 'Low'
            WHEN Monthly_Income BETWEEN 3000 AND 6000 THEN 'Medium'
            WHEN Monthly_Income BETWEEN 6001 AND 9000 THEN 'High'
            ELSE 'Very High'
        END AS SalaryBand
    FROM EmployeeAttrition
) AS Sub
GROUP BY SalaryBand
ORDER BY Attrition_Rate DESC;
----- 4. Attrition by Years Since Last Promotion
SELECT 
    Years_Since_Last_Promotion,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Years_Since_Last_Promotion
ORDER BY Attrition_Rate DESC;
---5. Attrition by Job Role
SELECT 
    Job_Role,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Role
ORDER BY Attrition_Rate DESC;
---- 6. Attrition by Marital Status
SELECT 
    Marital_Status,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Marital_Status
ORDER BY Attrition_Rate DESC;
---- 7. Attrition by Age Group
SELECT 
    AgeGroup,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM (
    SELECT *,
        CASE 
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age BETWEEN 30 AND 40 THEN '30-40'
            WHEN Age BETWEEN 41 AND 50 THEN '41-50'
            ELSE 'Above 50'
        END AS AgeGroup
    FROM EmployeeAttrition
) AS Sub
GROUP BY AgeGroup
ORDER BY Attrition_Rate DESC;
----8. Attrition by Performance Rating
SELECT 
    Performance_Rating,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Performance_Rating
ORDER BY Attrition_Rate DESC;
---- 9. Attrition by Job Satisfaction
SELECT 
    Job_Satisfaction,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Satisfaction
ORDER BY Attrition_Rate DESC;
---10. Attrition by Distance From Home
SELECT 
    Distance_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM (
    SELECT *,
        CASE 
            WHEN Distance_From_Home <= 5 THEN 'Near'
            WHEN Distance_From_Home <= 15 THEN 'Moderate'
            ELSE 'Far'
        END AS Distance_Group
    FROM EmployeeAttrition
) AS Sub
GROUP BY Distance_Group
ORDER BY Attrition_Rate DESC;

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    SalaryBand,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM (
    SELECT *,
        CASE 
            WHEN Monthly_Income < 3000 THEN 'Low'
            WHEN Monthly_Income BETWEEN 3000 AND 6000 THEN 'Medium'
            WHEN Monthly_Income BETWEEN 6001 AND 9000 THEN 'High'
            ELSE 'Very High'
        END AS SalaryBand
    FROM EmployeeAttrition
) AS Sub
GROUP BY SalaryBand;
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-----1. Department-wise Attrition
SELECT Department,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Department;

---2. Salary Band-wise Attrition
SELECT 
    CASE 
        WHEN Monthly_Income < 3000 THEN 'Low'
        WHEN Monthly_Income BETWEEN 3000 AND 6000 THEN 'Medium'
        WHEN Monthly_Income BETWEEN 6001 AND 9000 THEN 'High'
        ELSE 'Very High'
    END AS Salary_Band,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY 
    CASE 
        WHEN Monthly_Income < 3000 THEN 'Low'
        WHEN Monthly_Income BETWEEN 3000 AND 6000 THEN 'Medium'
        WHEN Monthly_Income BETWEEN 6001 AND 9000 THEN 'High'
        ELSE 'Very High'
    END;

	---3. Years Since Last Promotion vs. Attrition
	SELECT Years_Since_Last_Promotion,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Years_Since_Last_Promotion
ORDER BY Years_Since_Last_Promotion;
---4. Gender-wise Attrition
SELECT Gender,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Gender;
----5. Age Group vs. Attrition
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+' 
    END AS Age_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
    ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '50+' 
    END;

	----6. Overtime vs. Attrition
	SELECT Overtime,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Overtime;
------7. Work-Life Balance vs. Attrition
SELECT Work_Life_Balance,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Work_Life_Balance;
------8. Job Satisfaction vs. Attrition
SELECT Job_Satisfaction,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Satisfaction;
-----9. Job Role vs. Attrition
SELECT Job_Role,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Role;
---10. Job Level vs. Attrition
SELECT Job_Level,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Level;
---11. Marital Status vs. Attrition
SELECT Marital_Status,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Marital_Status;
---12. Job Involvement vs. Attrition
SELECT Job_Involvement,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Job_Involvement;
---13. Relationship with Manager vs. Attrition
SELECT Relationship_with_Manager,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Relationship_with_Manager;
---14. Years at Company vs. Attrition
SELECT Years_at_Company,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Years_at_Company;
---15. Training Hours vs. Attrition
SELECT Training_Hours_Last_Year,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Training_Hours_Last_Year;
---16. Distance from Home vs. Attrition
SELECT Distance_From_Home,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Distance_From_Home;
----17. Number of Companies Worked vs. Attrition
SELECT Number_of_Companies_Worked,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Number_of_Companies_Worked;
---18. Performance Rating vs. Attrition
SELECT Performance_Rating,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Performance_Rating;
----19. Project Count vs. Attrition
SELECT Project_Count,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Project_Count;
----20. Average Hours Worked per Week vs. Attrition
SELECT Average_Hours_Worked_Per_Week,
       COUNT(*) AS Total,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attritions,
       ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Attrition_Rate
FROM EmployeeAttrition
GROUP BY Average_Hours_Worked_Per_Week;
----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------THANK YOU BY DURGAM MANOHAR-------------------------------------------------------------

















