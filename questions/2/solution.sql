COPY (
SELECT *, DAYOFWEEK(Date) as DOW,
    CASE WHEN DOW IN (5, 6) THEN TRUE ELSE FALSE END as IsWeekend,
    CASE WHEN ISWeekend AND MOOD >= 4 THEN TRUE ELSE FALSE END as PartyTime
    FROM read_csv('datasets/partytime.csv')
) TO 'datasets/partytime_o.csv' WITH (FORMAT CSV, HEADER TRUE);

-- Can also use the IS_WEEKEND macro created in the dates.duckdb file
-- This macro was created in question 7
-- SELECT IS_WEEKEND(Date) AS IsWeekend,
--       MOOD,
--       CASE WHEN IS_WEEKEND(Date) AND MOOD >= 4 THEN TRUE ELSE FALSE END AS PartyTime
-- FROM read_csv('datasets/partytime.csv');