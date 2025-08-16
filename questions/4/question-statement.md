# Cast Dates
Cast the DATE column in the dates table
to DATE data type
#### Note that there is a value in date column that cannot be casted to date

### refer to [documentation for casting](https://duckdb.org/docs/stable/sql/expressions/cast)

Note that since we are querying a file with duckdb extension you should include datasets/db.duckdb (The database file) in your bash command

~~~bash
duckdb datasets/db.duckdb -f /workspaces/PracticeSQL/questions/4/solution.sql
~~~

Additionally this bash command may decrease verbosity
~~~bash
./run.sh 4
# Note ./run.sh is a custom script made for this course which runs the more verbose actual command
~~~