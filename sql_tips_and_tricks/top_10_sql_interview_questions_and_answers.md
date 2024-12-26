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

### 5. Find the employees who are not present in the department table

**Using `NOT IN`:**
  ```sql
  select * from employee where dept_id not in (select dep_id from dept)
  ```

**Uisng Left Join:**
  ```sql
  select e.*, d.* from employee e
  left join dept d on e.dept_id=d.dep_id
  where d.dep_id is null
  ```
- A LEFT JOIN fetches all records from the employees table and matching records from the department table.
- The WHERE d.dep_id `is null` condition filters rows where no match was found in the department table, meaning these employees do not have a corresponding entry in the department table.


### 6. Second highest salary in each dept
  ```sql
  with CTE as (
  	select *, dense_rank() over(partition by dept_id order by salary desc) dense_rank
  	from employee
  )
  select * from CTE where dense_rank=2
  ```
- `dense_rank()` assigns a unique rank to each salary within a department (`partition by dept_id`), ordered by salary in descending order (`order by salary desc`).
- The outer query filters rows where the rank is 2, indicating the second highest salary.
- with the same you can find any rank salary just need to change the filter condition 

### 7. find all the transactions done by Messi
  ```sql
  select * from transactions where trim(lower(customer_name))='messi'
  ```


### 8. self join, manager salary > employee salary


### 9. How many records will be return by each join(eg. inner join, left join, right join etc)


### 10. Update qeury to swap Gender
- Suppose we have below table and we want to change the gender
- We want to update the genders at once not one by one
  | customer_name     | order_date  | order_amount | gender |
  |-------------------|-------------|--------------|--------|
  | Rohish Zade       | 2024-12-01 | 1500.50      | F      |
  | Chandu Ullam      | 2024-12-02 | 2500.00      | M      |
  | Smit Ramteke      | 2024-12-03 | 1750.75      | F      |
  | Aishu BTS         | 2024-12-04 | 3000.00      | M      |
  | Chetan Badgujar   | 2024-12-05 | 1250.25      | F      |


**solution:**
  ```sql
  update customer set gender= 
  case when gender='M' then 'F'
       when gender='F' then 'M'
  end
  ```