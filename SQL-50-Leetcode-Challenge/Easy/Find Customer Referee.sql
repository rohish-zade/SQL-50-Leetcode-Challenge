-- https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50

--In SQL Server:
select name 
from customer
where referee_id is null or referee_id <> 2

-- using COALESCE: 
-- here COALESCE is used to replace NULL values with zero 
--before checking whether it is equal to 2 or not.
SELECT name
FROM customer
WHERE COALESCE(referee_id,0) <> 2;
