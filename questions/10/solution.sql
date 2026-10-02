-- Question 10: Larry and Barry — Solution
--
-- Goal: Find the earliest date Larry's cumulative solo-day earnings reach $400.
-- Rules:
--   1. Exclude any day where both Larry AND Barry worked (goes to joint account).
--   2. Sum only Larry's sales on his solo days, in date order.
--   3. Return the first date the running total >= 400.

-- ── Primary approach: 3-CTE chain ────────────────────────────────────────────

WITH shared_days AS (
    -- Step 1: identify dates where both employees appear
    SELECT date
    FROM sales
    GROUP BY date
    HAVING COUNT(DISTINCT employee) > 1
),
larry_solo AS (
    -- Step 2: keep only Larry's rows on days Barry wasn't there
    SELECT date, sales
    FROM sales
    WHERE employee = 'Larry'
      AND date NOT IN (SELECT date FROM shared_days)
),
running AS (
    -- Step 3: compute the cumulative running total over time
    SELECT
        date,
        sales,
        SUM(sales) OVER (ORDER BY date) AS running_total
    FROM larry_solo
)
-- Step 4: return the earliest date the running total hits $400
SELECT MIN(date) AS toy_date
FROM running
WHERE running_total >= 400;

-- Expected result: 2024-01-21  (running total = $413.00)


-- ── Alternative: QUALIFY (DuckDB-specific, single SELECT) ────────────────────
-- QUALIFY filters rows after window functions are evaluated — no outer query needed.
--
-- SELECT MIN(date) AS toy_date
-- FROM (
--     SELECT
--         date,
--         SUM(sales) OVER (ORDER BY date) AS running_total
--     FROM sales
--     WHERE employee = 'Larry'
--       AND date NOT IN (
--           SELECT date FROM sales
--           GROUP BY date HAVING COUNT(DISTINCT employee) > 1
--       )
-- )
-- WHERE running_total >= 400;







-- HANDWRITEN Solution ( I used AI to write previous solutions, this one is handwritten )

-- SELECT
--     date AS toy_date,
-- --     ANY_VALUE(employee) AS employee,
-- --     ANY_VALUE(sales) AS sales,
-- --     SUM(ANY_VALUE(sales)) OVER (
-- --         PARTITION BY ANY_VALUE(employee)
-- --         ORDER BY date
-- --     ) AS running_total
-- FROM SALES 
-- GROUP BY date
-- HAVING ANY_VALUE(employee) == 'Larry' AND COUNT(sales) == 1
-- QUALIFY SUM(ANY_VALUE(sales)) OVER (
--         ORDER BY date
--     ) >= 400
-- ORDER BY date
-- LIMIT 1;