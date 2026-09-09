INSTALL httpfs;
LOAD httpfs;

COPY (
    SELECT 
        *
    FROM 
        "https://raw.githubusercontent.com/datasets/s-and-p-500/refs/heads/main/data/data.csv"
) TO 'datasets/s&p.csv' WITH (FORMAT csv, HEADER true);
