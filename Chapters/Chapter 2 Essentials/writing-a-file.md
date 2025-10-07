### for the course we are using csv, parquet
#### csv
~~~sql
COPY tbl TO 'output.csv' (HEADER, DELIMITER ',');

COPY (SELECT * FROM tbl) TO 'output.csv' (HEADER, DELIMITER ',');

-- Note that COPY comes outer most
COPY (
    WITH PARTYTIME AS (...)
    SELECT * FROM  PARTYTIME
) TO 'output.csv' (HEADER, DELIMITER ',')
~~~


#### parquet
~~~sql
COPY tbl TO 'output.parquet' (FORMAT parquet);
~~~

[The official documentation](https://duckdb.org/docs/stable/guides/file_formats/overview) will help you go beyond in the topic.