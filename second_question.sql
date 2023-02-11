-- write a query to return all employees 
-- who have never had a reciew sorted by Hiredate

select distinct employee.*
from 
    employee
    left join 
    annual_reviews
    on employee.id = annual_reviews.empid
where
annual_reviews.reviewdate > current_date()  
or 
annual_reviews.reviewdate is null
or annual_reviews.reviewdate > employee.Terminationdate
order by employee.hiredate;