## Question 8: Explain a Join Query

DuckDB provides the `EXPLAIN` statement to help you understand how a query will be executed by showing its query plan. This is useful for analyzing and optimizing SQL queries.

**Task:**  
Write a DuckDB SQL statement that uses `EXPLAIN` to show the query plan for an inner join between the `PLAYERS` and `QUESTS` tables, joining on the `PLAYER_ID` column.

- Use the `EXPLAIN` statement to wrap a `SELECT` query that joins these two tables.
- You may use the `FROM ... INNER JOIN ... ON ...` syntax.

**References:**
- [DuckDB EXPLAIN documentation](https://duckdb.org/docs/sql/statements/explain.html)
- [DuckDB JOIN documentation](https://duckdb.org/docs/sql/query_syntax/join.html)

**Example:**
```sql
EXPLAIN (
    FROM PLAYERS P
    INNER JOIN QUESTS Q
    ...
)
```