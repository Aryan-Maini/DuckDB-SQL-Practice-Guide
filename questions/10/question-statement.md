## Question 10: Larry and Barry

#### **Difficulty:** Hard

**Background:**
Larry and Barry run a lemonade stand together. On some days only Larry works, on some days only Barry works, and on some days they both show up.

They have one rule: **on any day where both Larry and Barry work, all earnings from that day go into a shared "joint account"** — locked away for 10 years. Neither of them can spend that money on anything fun.

Only Larry's earnings from his **solo days** (days when Barry didn't work) are available to Larry for spending.

**Your Objective:**
Larry has his eye on a new toy that costs **$400**. He wants to know **the earliest date** on which his cumulative spendable earnings (solo-day sales only) reached or exceeded $400.

**The `sales` table:**
| column | type | description |
|---|---|---|
| `date` | DATE | The date of the sale |
| `sales` | DECIMAL | The amount earned that day |
| `employee` | VARCHAR | Either `'Larry'` or `'Barry'` |

> **Note:** A single date can appear twice in the table (once for Larry, once for Barry) on days they both worked.

**Challenge:**
Can this be written as a single `SELECT` statement — no `CREATE TABLE`, no `UPDATE`?

-----

**Hints:**
- To find days when both worked, think about grouping by `date` and counting distinct employees.
- To compute a running total, look at [window functions](https://duckdb.org/docs/stable/sql/window_functions) — specifically `SUM(...) OVER (ORDER BY date)`.
- To find the *first* date the running total crosses a threshold, consider filtering with `WHERE running_total >= 400` and taking the `MIN(date)`.
- Chaining CTEs (Common Table Expressions) will help break the problem into clear steps.

-----

### How to Run Your Solution

```bash
duckdb datasets/lemonade.db -f questions/10/answer.sql
```
