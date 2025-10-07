## Question 2
Your goal is to identify if it's "party time" based on a few conditions. Write a query that first reads the partytime.csv dataset. Then, add a new column named party_time that returns true if it's either Saturday (5) or Sunday (6) and the mood is 4 or greater. Use the DAYOFWEEK() function to check the day. Finally, write the result of this query to a new file called partytime_o.csv.

### Hint: Refer to the guides on [reading a file](../../duckdb-help/reading-a-file.md) and [writing a file](../../duckdb-help/writing-a-file.md) for help.