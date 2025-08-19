### **Correcting Bad Data**

#### **Difficulty:** Medium | **Type:** Pure SQL + Data Manipulation

**Problem:**
Building on what you learned in the previous question, you now need to not only cast the `DATE` column in the `dates` table but also handle the rows that failed to cast.

**Your Objective:**
Write a two-part SQL query to complete this task:

1.  **Cast the Data:** Use the `TRY_CAST()` function to convert the `DATE` column to the `DATE` data type. This will allow valid dates to be converted while leaving invalid ones as `NULL`.
2.  **Fill the Gaps:** Next, update the `NULL` values with a today's date. You can achieve this using a function like `today()`.

This challenge requires you to write two separate `UPDATE` statements to modify the data in place.

-----

  * **Hint:** If you need help with the `TRY_CAST()` function, you can refer to the [documentation on casting](https://duckdb.org/docs/stable/sql/expressions/cast). For the `today()` function, you'll find details in the [documentation on date functions](https://duckdb.org/docs/stable/sql/functions/date).
  * **Remember:** You'll need to use the provided database file for this question.

```bash
duckdb datasets/db.duckdb -f questions/5/solution.sql
```

  * `duckdb datasets/db.duckdb`: This part starts the DuckDB CLI and tells it to open or connect to the `db.duckdb` file located in the `datasets` directory.
  * `-f questions/5/solution.sql`: The `-f` flag specifies that DuckDB should execute all the SQL statements within the `solution.sql` file. This file is assumed to be located in the `questions/5/` directory.