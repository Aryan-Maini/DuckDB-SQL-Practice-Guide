COPY (
    SELECT 
        *,
        CASE 
            WHEN DAYOFWEEK(date) IN (5, 6)
                AND mood >= 4 THEN true 
            ELSE false
        END AS is_party
    FROM read_csv('datasets/partytime.csv', HEADER = TRUE)
) TO 'datasets/partytime_o.csv' WITH (FORMAT CSV, HEADER TRUE)