-- calculate the longest period (in days) that the company gone without hiring or firing anyone

with periodtable as
(
select a.period_days-(lag(period_days) over (order by a.period_days))  period
from (select distinct hiredate as period_days
    from employee
    where hiredate is not null
    union
    select distinct Terminationdate
    from employee
    where Terminationdate is not null) a
)
select max(period) 
from periodtable
;