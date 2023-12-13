/*
* Resolution for SQL Codewars: SQL Basics: Simple JOIN and RANK .sql
* URL: https://www.codewars.com/kata/58094559c47d323ebd000035

* Description:
    For this challenge you need to create a simple SELECT statement that will return all columns from the people table,
    and join to the sales table so that you can return the COUNT of all sales and RANK each person by their sale_count.

    ? people table schema
        id
        name
    ?sales table schema
        id
        people_id
        sale
        price
    You should return all people fields as well as the sale count as "sale_count" and the rank as "sale_rank".

*/
with sales_tmp as (
    select
          pp.id
        , pp.name
        , count(*) as sale_count
    from people as pp
        join sales as sl on pp.id = sl.people_id
    group by pp.id, pp.name
)
select id, name, sale_count
    , rank() over(order by sale_count desc) as sale_rank
from sales_tmp
