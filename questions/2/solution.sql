COPY (
SELECT *, DAYOFWEEK(Date) as DOW,
    CASE WHEN DOW IN (5, 6) THEN TRUE ELSE FALSE END as IsWeekend,
    CASE WHEN ISWeekend AND MOOD >= 4 THEN TRUE ELSE FALSE END as PartyTime
    FROM read_csv('datasets/partytime.csv')
) TO 'datasets/partytime_o.csv' WITH (FORMAT CSV, HEADER TRUE);