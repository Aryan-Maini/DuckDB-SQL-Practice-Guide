### This course has provided some shortcut Scripts, which use duckdb CLI in the background
#### Altough these exist, we recommend using the [DuckDB CLI Commands ](use-the-cli.md) yourself for practice.


~~~bash
#to activate execute permission of a script
chmod +x run.sh
# Other Scripts
chmod +x check.sh
# running a script
./run.sh 1
# run.sh will find the answer.sql file in the folder named 1 and run it using duckdb CLI
./run.sh 4 datasets/db.duckdb
# Optionally you can provide the duckdb file to this script
~~~