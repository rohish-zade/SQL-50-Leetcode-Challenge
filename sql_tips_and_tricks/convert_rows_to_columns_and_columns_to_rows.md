## SQL Convert Rows to Columns and Columns to Rows without using Pivot Functions

This is often referred to as a "manual pivot." For this, you can use     statements with aggregation:

### Converting Rows to Columns

**Input:**
  ```sql
  select * from emp_compensation;
  ```
  | emp_id | salary_component_type | val   |
  |--------|------------------------|-------|
  | 1      | salary                | 10000 |
  | 1      | bonus                 | 5000  |
  | 1      | hike_percent          | 10    |
  | 2      | salary                | 15000 |
  | 2      | bonus                 | 7000  |
  | 2      | hike_percent          | 8     |
  | 3      | salary                | 12000 |
  | 3      | bonus                 | 6000  |
  | 3      | hike_percent          | 7     |


**output:**

  | emp_id | salary | bonus | hike_percent |
  |--------|--------|-------|--------------|
  | 1      | 10000  | 5000  | 10           |
  | 2      | 15000  | 7000  | 8            |
  | 3      | 12000  | 6000  | 7            |


**SQL Query:**
  ```sql
  select emp_id,
  sum(case when salary_component_type='salary' then val end) as salary,
  sum(case when salary_component_type='bonus' then val end) as bonus,
  sum(case when salary_component_type='hike_percent' then val end) as hike_percent
  from emp_compensation
  group by emp_id;
  ```

### Converting Columns to Rows
This is the reverse process, often called "unpivoting," and can be done using a `UNION ALL` approach.

  ```sql
  select emp_id, 'salary' as salary_component_type, salary as val from emp_compensation_pivot
  union all
  select emp_id, 'bonus' as salary_component_type, bonus as val from emp_compensation_pivot
  union all
  select emp_id, 'hike_percent' as salary_component_type, hike_percent as val from   emp_compensation_pivot
  ```


**Tips and Tricks:**
- You can create a table from sql query result
- Example: Creating emp_compensation_pivot from sql query result using `into`
  ```sql
  select emp_id,
  sum(case when salary_component_type='salary' then val end) as salary,
  sum(case when salary_component_type='bonus' then val end) as bonus,
  sum(case when salary_component_type='hike_percent' then val end) as hike_percent
  into emp_compensation_pivot
  from emp_compensation
  group by emp_id;
  ```