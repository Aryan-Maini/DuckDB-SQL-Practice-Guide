## Work with data on the web
DuckDB has some extensions that let you do more.
the `httpfs` package help you read data (.csv, .s3 etc ) on the web

~~~sql
INSTALL httpfs;
LOAD httpfs;
FROM 'https://raw.githubusercontent.com/datasets/s-and-p-500/refs/heads/main/data/data.csv';
-- reads a csv on github
-- this is a small dataset on S&P
~~~

# Your task
- use `httpfs`
- Read data from this [URL](https://raw.githubusercontent.com/datasets/s-and-p-500/refs/heads/main/data/data.csv) 
- Write to datasets/s&p.csv