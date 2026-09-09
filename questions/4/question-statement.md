### **Handle Invalid Date Casting**

#### **Difficulty:** Easy

**Task:**
Cast the `DATE` column in the `dates` table to the `DATE` data type. Be aware that the column contains at least one value that is not a valid date.

Your query must run successfully without throwing an error due to the invalid data.

  * **Hint:** See the [DuckDB documentation for casting](https://duckdb.org/docs/stable/sql/expressions/cast).

-----

### How to Run Your Solution

```bash
duckdb datasets/date.duckdb -f questions/4/answer.sql
```