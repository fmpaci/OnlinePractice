/*
    There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms,
    so there may be some people who cannot board.

    Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit.
    The test cases are generated such that the first person does not exceed the weight limit.
*/
with running_sum as (
  select *
    , sum(weight) over(order by turn rows between unbounded preceding and current row) rs
  from Queue
)
select person_name
from queue
where turn = (select max(turn) from running_sum where rs <= 1000)
