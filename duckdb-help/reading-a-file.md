### Reading a csv

~~~duckdb
SELECT * FROM read_csv('datasets/helloworld.csv');
~~~

#### parquet
~~~duckdb
SELECT * FROM read_parquet('input.parquet');
~~~

[The official documentation](https://duckdb.org/docs/stable/guides/file_formats/overview) will help you go beyond in the topic.