### for the course we are using csv, parquet
#### csv
~~~duckdb
COPY tbl TO 'output.csv' (HEADER, DELIMITER ',');
~~~

#### parquet
~~~duckdb
COPY tbl TO 'output.parquet' (FORMAT parquet);
~~~

[The official documentation](https://duckdb.org/docs/stable/guides/file_formats/overview) will help you go beyond in the topic.