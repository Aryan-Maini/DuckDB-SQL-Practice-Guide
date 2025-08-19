### **Handle Invalid Date Casting**

#### **Difficulty:** Easy

**Task:**
Cast the `DATE` column in the `dates` table to the `DATE` data type. Be aware that the column contains at least one value that is not a valid date.

Your query must run successfully without throwing an error due to the invalid data.

  * **Hint:** See the [DuckDB documentation for casting](https://duckdb.org/docs/stable/sql/expressions/cast).

-----

### How to Run Your Solution

```
You will need to use the provided database file for this question.

To run your query, use the following command:

~~~bash
duckdb datasets/db.duckdb -f /workspaces/PracticeSQL/questions/4/solution.sql
~~~
```