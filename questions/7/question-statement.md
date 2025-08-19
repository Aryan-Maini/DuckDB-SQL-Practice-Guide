## Question 7: Create a Macro to Check for Weekends

DuckDB supports user-defined macros, which allow you to encapsulate reusable logic in SQL. In this exercise, you will create a macro that determines whether a given date falls on a weekend.

**Task:**  
Write a DuckDB SQL macro named `IS_WEEKEND` that takes a single argument (a date) and returns `TRUE` if the date is a Saturday or Sunday, and `FALSE` otherwise.

- Use the `EXTRACT(DAYOFWEEK FROM ...)` function, which returns 0 for Sunday, 1 for Monday, ..., 6 for Saturday.
- Your macro should return `TRUE` for both Saturday and Sunday.

**Example Usage:**
```sql
SELECT IS_WEEKEND('2024-08-17') AS is_weekend; -- Should return TRUE (Saturday)
SELECT IS_WEEKEND('2024-08-19') AS is_weekend; -- Should return FALSE (Monday)
```

### Bonus
#### create this macro in the `dates.duckdb` file, then solve question 2 using this function