-- write a query to return all employees still working for the company with  last names starting with "Smith"
-- sorted by their last name and then first name!
select *
from employee
where
(Terminationdate > current_date()  
or 
Terminationdate is not null)
and
lastname like 'Smith%'
order by lastname, firstname;