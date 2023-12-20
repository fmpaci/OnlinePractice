
# Write your MySQL query statement below
with salary_rank as (
    select
        d.name as department
        , e.name as employee
        , e.salary
        , dense_rank() over(partition by d.id order by e.salary desc) rank_value
    from department d
        join employee e on e.departmentId = d.id
)
select
    Department
    , Employee
    , Salary
from salary_rank
where rank_value <= 3
order by department, salary desc
