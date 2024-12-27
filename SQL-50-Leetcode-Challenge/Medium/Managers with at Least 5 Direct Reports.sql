-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50

--Using CTE and joins:
with cte as (
    select managerId, count(*) as count
    from employee
    group by managerId
    having count(*) > 4
)
select e.name from employee e
inner join cte m on e.id=m.managerId;

-- using subqeury
select name from employee where id in 
(select managerId 
from employee 
group by managerId 
having count(*) > 4)
