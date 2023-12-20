with request as (
    select requester_id, count(1) q
    from RequestAccepted
    group by 1
),
acepted as (
    select accepter_id, count(1) q
    from RequestAccepted
    group by 1
),
total as (
    select requester_id as p_id, q
    from request
    union all
    select accepter_id as p_id, q
    from acepted
)
select p_id as id, sum(q) as num
from total
group by 1
order by num desc
limit 1


-- Silmpler solution
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC
LIMIT 1;
