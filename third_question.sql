-- calculate the different (in days) between the most and least 
-- tenured employee still working


select max(hiredate)-min(hiredate) as tenured_different
from employee
where
(Terminationdate > current_date()  
or 
Terminationdate is not null);