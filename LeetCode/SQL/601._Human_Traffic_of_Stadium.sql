with consecutives_ids as (
    select *
    from ( select
              *
            , id - row_number() over(partition by 1 order by visit_date asc) val
        from stadium
        where people >= 100
    )
    group by val
)
select
    st.id
    , st.visit_date
    , st.people
from consecutives_ids st
where val > 2





with consecutives_ids as (
    select *,  count(id) over (partition by val) as val_cnt
    from ( select
              *
            , id - row_number() over(partition by 1 order by visit_date asc) val
        from stadium
        where people >= 100
    )

)
select
    st.id
    , st.visit_date
    , st.people
from consecutives_ids st
where val_cnt > 2