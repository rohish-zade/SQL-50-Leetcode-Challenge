## Top 10 SQL interview Questions and Answers

### 1. How to find duplicates in a given table
To find duplicates in a given table, you can use the SQL GROUP BY clause combined with the HAVING clause.

**Example:** If we want to check for duplicates in the emp_id column:
  ```sql
  select emp_id, count(*) from emp_dup
  group by emp_id
  having count(*) > 1
  ```


### 2. How to delete duplicates
If you need to remove duplicates, you can use `ROW_NUMBER()` or `DISTINCT:`

  ```sql
  with cte as (
    select *, row_number() over(partition by emp_id order by emp_id) as rn
    from emp_dup
  )
  delete from cte where rn>1
  ```


### 3. Difference between union and union all
The difference between `UNION` and `UNION ALL` in SQL lies in how they handle duplicate rows.

**UNION:**
- Combines the result sets of two or more `SELECT` queries and removes duplicate rows from the final output.
- Slower than `UNION ALL` because it requires an additional step to eliminate duplicates (sorting and comparing rows).
- Use when you want only unique rows in the combined result set. 

**UNION ALL:**
- Combines the result sets of two or more SELECT queries without removing duplicates.
- Faster than `UNION` since it does not perform the duplicate elimination step.
- Use when you need all rows, including duplicates, in the combined result set.


### 4. Difference between row_number(), rank(), and dense_rank()

- **row_number():** Assigns a unique number to each row in a partition based on the specified order.
- **rank():** Assigns ranks to rows with ties, leaving gaps in ranks.
- **dense_rank():** Assigns ranks without gaps in case of ties.