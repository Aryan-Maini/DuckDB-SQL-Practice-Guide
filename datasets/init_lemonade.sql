-- init_lemonade.sql
-- Seeds datasets/lemonade.db with the `sales` table for Question 10.
--
-- Scenarios covered:
--   - Days where only Larry works
--   - Days where only Barry works
--   - Days where both Larry and Barry work (should be excluded from Larry's total)

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    date     DATE,
    sales    DECIMAL(8, 2),
    employee VARCHAR
);

INSERT INTO sales VALUES
    -- Larry only
    ('2024-01-02', 45.00,  'Larry'),
    ('2024-01-04', 62.50,  'Larry'),
    ('2024-01-07', 38.75,  'Larry'),
    ('2024-01-09', 91.00,  'Larry'),
    ('2024-01-14', 55.25,  'Larry'),
    ('2024-01-16', 47.00,  'Larry'),
    ('2024-01-21', 73.50,  'Larry'),
    ('2024-01-23', 29.00,  'Larry'),

    -- Barry only
    ('2024-01-03', 80.00,  'Barry'),
    ('2024-01-06', 34.50,  'Barry'),
    ('2024-01-10', 67.25,  'Barry'),
    ('2024-01-13', 52.00,  'Barry'),
    ('2024-01-17', 41.75,  'Barry'),
    ('2024-01-20', 88.00,  'Barry'),
    ('2024-01-24', 60.50,  'Barry'),

    -- Both Larry AND Barry work on the same day (exclude these from Larry's total)
    ('2024-01-05', 110.00, 'Larry'),
    ('2024-01-05', 95.00,  'Barry'),

    ('2024-01-11', 78.50,  'Larry'),
    ('2024-01-11', 83.25,  'Barry'),

    ('2024-01-18', 140.00, 'Larry'),
    ('2024-01-18', 120.75, 'Barry'),

    ('2024-01-25', 99.00,  'Larry'),
    ('2024-01-25', 105.50, 'Barry');
