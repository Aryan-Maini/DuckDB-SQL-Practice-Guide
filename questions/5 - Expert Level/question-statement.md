### **Aggregate and Match Player Objectives**

#### **Difficulty:** Expert | **Type:** Pure SQL


### References

- [DuckDB UNPIVOT documentation](https://duckdb.org/docs/sql/statements/unpivot)
- [DuckDB LISTAGG documentation](https://duckdb.org/docs/sql/functions/aggregate#listagg)
##### Note UNPIVOT and LISTAGG are not required, but could be helpful with certain advanced approaches

----- 

**Task:**
For each player, determine which quest objectives they have completed by comparing their total stats to the requirements in the `QUESTS` table.  
A player completes an objective if their total for that objective (e.g., kills or heals) is greater than the required metric in the quest.

Return, for each player who has completed at least one objective:
- `PLAYER_ID`
- A comma-separated list of completed objectives as `COMPLETED_OBJECTIVES`
- A comma-separated list of the corresponding quest rewards as `QUEST_REWARDS`

**Example Output:**
```
┌───────────┬──────────────────────┬───────────────┐
│ PLAYER_ID │ COMPLETED_OBJECTIVES │ QUEST_REWARDS │
│   int32   │       varchar        │    varchar    │
├───────────┼──────────────────────┼───────────────┤
│       101 │ KILL                 │ COINS         │
│       102 │ HEAL                 │ BOX           │
│       104 │ HEAL                 │ BOX           │
│       105 │ KILL                 │ COINS         │
└───────────┴──────────────────────┴───────────────┘
```

**Tables:**
- `STATS`: Contains player stats per game (columns: `PLAYER_ID`, `KILLS`, `HEALS`, ...)
- `QUESTS`: Contains quest objectives and required metrics for each player (columns: `PLAYER_ID`, `OBJECTIVE`, `METRIC`, `QUEST_REWARD`)
- `PLAYERS`: Contains player info (columns: `PLAYER_ID`, `PLAYER_NAME`, ...)

-----

### How to Run Your Solution

```
You will need to use the provided database file for this question.

To run your query, use the following command:

~~~bash
duckdb datasets/gaming.duckdb -f /workspaces/PracticeSQL/questions/5/solution.sql
~~~
```