with first_loging as (
  select player_id, has_log_next_day
  from (
    select
          player_id
          ,case when
                      datediff(lead(event_date) over(partition by player_id order by event_date )
                                  , event_date
                                  ) = 1
              then 1 else 0 end has_log_next_day
          , row_number() over(partition by player_id order by event_date) rn
        from activity
      ) as xs  where rn = 1
)
select  round(sum(has_log_next_day)/ count(player_id),2) as fraction
from first_loging
