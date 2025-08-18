### Question 3

### **Week Streak Awards**
#### **Difficulty:** Hard | **Type:** Pure SQL

As a data analyst at GitHub, your task is to identify users who qualify for the "Year of Consistency" award. To earn this award, a user must have at least 20 "GitHub Weeks" in a single year.

**Here's the business logic you need to apply:**
* A **"GitHub Week"** is defined as any week where a user contributed for at least 3 days.
* A **"Year of Consistency"** is a year that contains at least 20 "GitHub Weeks."

**Your challenge:** Write a single, clean SQL query that identifies all users who have achieved a "Year of Consistency." Although it's possible to solve this without them, **using Common Table Expressions (CTEs) is highly recommended** for readability and to break down the problem into logical steps.

**The final output should contain two columns:**
* `PERSON_ID` (the user's identifier)
* `WEEK_COUNT` (the total number of "GitHub Weeks" for that user in the year)

---