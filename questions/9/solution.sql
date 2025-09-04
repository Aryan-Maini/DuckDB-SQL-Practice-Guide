-- INSTALL httpfs;
-- LOAD httpfs;
COPY (FROM 'https://raw.githubusercontent.com/datasets/s-and-p-500/refs/heads/main/data/data.csv')
TO '/datasets/sp500.csv' WITH (FORMAT csv, HEADER true);
