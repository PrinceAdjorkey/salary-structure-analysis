create database SALARY;

CREATE TABLE salary_structure(
age int  not null,
gender varchar(20) not null,
department varchar (50) not null,
salary int not null,
workexperience int not null
);

--  ----------------DESCRIBE AND SELECT ALL ---------------------------------------salary_structure
DESCRIBE salary_structure;
select * from salary_structure;


-- --------------------------------------------------------------------------------
-- - 	What is the average salary across all roles or departments?---------------
select avg(salary) as avg_salary
from salary_structure;

-- -----------------------------------------------------------------------------------
-- -.	How does salary vary by job title, department, or grade level?------------------
select department,
avg(salary) as avg_salary
from salary_structure
group by department
order by avg_salary desc;

-- ----------------------------------------------------------------------------------------

-- -3.	What is the distribution of salaries across the dataset (minimum, maximum, median)?

SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
     AVG(salary) AS median_salary
    from salary_structure;
    
    -- ------------------------------------------------------------------------------------------
    -- --	Are there salary disparities based on gender or location (if applicable)?----------
    select gender,
    sum(salary) as total_salaries
    from salary_structure
    group by gender;
    
    -- --------------------------------------------------------------------------------------------
    --   5.	Which departments have the highest and lowest average salaries?
    select department,
avg(salary) as avg_salary
from salary_structure
group by department
order by avg_salary desc;

-- -------------------------------------------------------------------------------
-- -6.	Is there a correlation between years of experience and salary (if that data is available)?
select workexperience,
sum(salary) as total_salary
from salary_structure
group by workexperience;



-- --How does overtime or bonuses contribute to total compensation?-------------

-- - Let’s assume:

-- -Overtime Pay = 5% of base salary

-- -Bonus = Based on work experience:

-- -If WORK EXPERIENCE ≥ 5 years → Bonus = 10% of salary

-- Else → Bonus = 5% of salary

 
SELECT 
    AGE,
    GENDER,
    DEPARTMENT,
    SALARY,
    workexperience,
    
    -- Overtime Pay: 5% of base salary
    SALARY * 0.05 AS OVERTIME_PAY,
    
    -- Bonus: 10% if experience >= 5, else 5%
    CASE 
        WHEN workexperience >= 5 THEN SALARY * 0.10
        ELSE SALARY * 0.05
    END AS BONUS,
    
    -- Total Compensation = SALARY + OVERTIME + BONUS
    SALARY + 
    (SALARY * 0.05) + 
    CASE 
        WHEN workexperience >= 5 THEN SALARY * 0.10
        ELSE SALARY * 0.05
    END AS TOTAL_COMPENSATION

FROM SALARY_STRUCTURE;

-- ------------------------------------------------------------------------------------------

-- ---	What percentage of employees fall within each salary band or grade?
-- -Assume salary bands are:

-- -Low: Salary < 40,000

-- --Medium: 40,000 ≤ Salary < 60,000

-- -High: Salary ≥ 60,000

SELECT 
    Salary_Band,
    COUNT(*) AS Employee_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM (
    SELECT *,
        CASE 
            WHEN SALARY < 40000 THEN 'Low'
            WHEN SALARY >= 40000 AND SALARY < 60000 THEN 'Medium'
            ELSE 'High'
        END AS Salary_Band
    FROM SALARY_STRUCTURE
) AS BandTable
GROUP BY Salary_Band;
-- -------------------------------------------------------------------------------------------------

