### Once you have setup duckdb and verified it's installed

~~~bash
duckdb --help
~~~

## Run a SQL File

1. Copy the relative path of the file you wish to execute 
(using the GUI or CTRL + Shift + C in VSCode)

2. in the CLI enter
~~~bash
# simple structure of running a file
duckdb -f <filename>

# for example, run this in the terminal 
duckdb -f getting-started/hello-world.sql

#### Using a Database file
~~~bash
duckdb datasets/db.duckdb -f /workspaces/PracticeSQL/questions/4/solution.sql
~~~ 

### This course has provided a script to check your answer, which uses duckdb CLI in the background.

~~~bash
# running a script
./check.sh 4 datasets/date.duckdb
# check.sh will find the answer.sql and solution.sql file in the folder named 1 and run it using duckdb CLI, then compare the output
# Please provide the duckdb file to this script
~~~

#### If you got this you can head to [reading a file](../duckdb-help/reading-a-file.md)