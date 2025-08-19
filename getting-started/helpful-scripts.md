### This course has provided a script to check your answer, which use duckdb CLI in the background.

~~~bash
#to activate execute permission of a script
chmod +x check.sh
# running a script
./check.sh 4 datasets/date.duckdb
# check.sh will find the answer.sql and solution.sql file in the folder named 1 and run it using duckdb CLI, then compare the output
# Please provide the duckdb file to this script
~~~