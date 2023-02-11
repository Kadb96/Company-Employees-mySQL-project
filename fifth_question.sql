-- write a query that returns each employee info and maximum number of employees
-- during their tenure and the first date that the number was acquired
select final_group_table.*
from
(
    select group_table.id, min(group_table.firstdate) as min_firstdate
    from
    (
        select *
        from 
            employee
            join
            (
                select firstdate, count (firstdate) as max_emp
                from 
                (
                    select distinct *
                    from
                    (
                        select a.id, a.hiredate, b.hiredate firstdate
                        from 
                            employee a
                            join
                            employee b
                        where 
                            a.hiredate <= b.hiredate
                            and 
                            (a.Terminationdate > b.hiredate
                            or
                            a.Terminationdate is null)
                        order by b.hiredate
                    ) as distinct_table
                ) as count_table
                group by firstdate
            ) as max_table
        where 
            employee.hiredate <= max_table.firstdate
            and
            (employee.Terminationdate > max_table.firstdate
            or employee.Terminationdate is null)
        order by employee.id, max_table.firstdate
    ) as group_table
    join
    (
        select employee.id, max(max_emp) as max_max_emp
        from 
            employee
            join
            (
                select firstdate, count (firstdate) as max_emp
                from 
                (
                    select distinct *
                    from
                    (
                        select a.id, a.hiredate, b.hiredate firstdate
                        from 
                            employee a
                            join
                            employee b
                        where 
                            a.hiredate <= b.hiredate
                            and 
                            (a.Terminationdate > b.hiredate
                            or
                            a.Terminationdate is null)
                        order by b.hiredate
                    ) as distinct_table
                ) as count_table
                group by firstdate
            ) as max_table
        where 
            employee.hiredate <= max_table.firstdate
            and
            (employee.Terminationdate > max_table.firstdate
            or employee.Terminationdate is null)
        group by employee.id
    ) as group_max_table
    on 
        group_table.id = group_max_table.id
        and
        group_table.max_emp = group_max_table.max_max_emp
    group by group_table.id
) as final_mindate_group_table
join
(
    select group_table.* from
    (
        select *
        from 
            employee
            join
            (
                select firstdate, count (firstdate) as max_emp
                from 
                (
                    select distinct *
                    from
                    (
                        select a.id, a.hiredate, b.hiredate firstdate
                        from 
                            employee a
                            join
                            employee b
                        where 
                            a.hiredate <= b.hiredate
                            and 
                            (a.Terminationdate > b.hiredate
                            or
                            a.Terminationdate is null)
                        order by b.hiredate
                    ) as distinct_table
                ) as count_table
                group by firstdate
            ) as max_table
        where 
            employee.hiredate <= max_table.firstdate
            and
            (employee.Terminationdate > max_table.firstdate
            or employee.Terminationdate is null)
        order by employee.id, max_table.firstdate
    ) as group_table
    join
    (
        select employee.id, max(max_emp) as max_max_emp
        from 
            employee
            join
            (
                select firstdate, count (firstdate) as max_emp
                from 
                (
                    select distinct *
                    from
                    (
                        select a.id, a.hiredate, b.hiredate firstdate
                        from 
                            employee a
                            join
                            employee b
                        where 
                            a.hiredate <= b.hiredate
                            and 
                            (a.Terminationdate > b.hiredate
                            or
                            a.Terminationdate is null)
                        order by b.hiredate
                    ) as distinct_table
                ) as count_table
                group by firstdate
            ) as max_table
        where 
            employee.hiredate <= max_table.firstdate
            and
            (employee.Terminationdate > max_table.firstdate
            or employee.Terminationdate is null)
        group by employee.id
    ) as group_max_table
    on 
        group_table.id = group_max_table.id
        and
        group_table.max_emp = group_max_table.max_max_emp
) as final_group_table
on 
    final_group_table.id = final_mindate_group_table.id
    and
    final_group_table.firstdate = final_mindate_group_table.min_firstdate
