## self join
- A self join is a regular join, but the table is joined with itself.
- It’s useful when you want to compare rows within the same table or retrieve hierarchical or relationship-based data stored in a single table.

**Examples:**
- Suppose we have below table
    | emp_id | emp_name | dept_id | salary | manager_id | emp_age | dob        |
    |--------|----------|---------|--------|------------|---------|------------|
    | 1      | Rohish   | 100     | 10000  | 4          | 39      | 1985-02-14 |
    | 2      | Mohit    | 100     | 15000  | 5          | 48      | 1976-02-14 |
    | 3      | Vikas    | 100     | 10000  | 4          | 37      | 1987-02-14 |
    | 4      | Rohit    | 100     | 5000   | 2          | 16      | 2008-02-14 |
    | 5      | Mudit    | 200     | 12000  | 6          | 55      | 1969-02-14 |
    | 6      | Agam     | 200     | 12000  | 2          | 14      | 2010-02-14 |
    | 7      | Sanjay   | 200     | 9000   | 2          | 13      | 2011-02-14 |
    | 8      | Ashish   | 200     | 5000   | 2          | 12      | 2012-02-14 |
    | 9      | Mukesh   | 300     | 6000   | 6          | 51      | 1973-02-14 |
    | 10     | Rakesh   | 500     | 7000   | 6          | 50      | 1974-02-14 |



### 1. Find the employees who are also managers

#### using subquery:
  ```sql
  select * from employee where emp_id in (select manager_id from employee)
  ```

#### using self join:
  ```sql
  select distinct e2.emp_id as manager_id, e2.emp_name as manager_name
  from employee e1
  inner join employee e2 on e1.manager_id=e2.emp_id
  ```

### 2. Find Employees with salary more than their managers
  ```sql
  select e1.emp_id, e1.emp_name as emp_name, e1.salary as emp_salary,
  e2.emp_name as manager_name, e2.salary as manager_salary
  from employee e1
  inner join employee e2 on e1.manager_id=e2.emp_id
  where e1.salary > e2.salary
  ```