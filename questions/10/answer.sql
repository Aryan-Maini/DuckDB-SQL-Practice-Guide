-- Question 10: Larry and Barry
-- Write your SQL query below:

SELECT
    date AS toy_date,
    -- ANY_VALUE(employee) AS employee,
    -- ANY_VALUE(sales) AS sales,
    -- SUM(ANY_VALUE(sales)) OVER (
    --     PARTITION BY ANY_VALUE(employee)
    --     ORDER BY date
    -- ) AS running_total
FROM SALES 
GROUP BY date
HAVING ANY_VALUE(employee) == 'Larry' AND COUNT(sales) == 1
QUALIFY SUM(ANY_VALUE(sales)) OVER (
        ORDER BY date
    ) >= 400
ORDER BY date
LIMIT 1;
