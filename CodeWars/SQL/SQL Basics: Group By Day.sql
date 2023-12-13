/*
* Resolution for SQL Codewars SQL Basics: Group By Day.sql
* URL: https://www.codewars.com/kata/5811597e9d278beb04000038

* Description:
    There is an events table used to track different key activities taken on a website.
    For this task you need to:
        ? find the entries whose name equals "trained"
        ? group them by the day the activity happened (the date part of the created_at timestamp) and their description's
            the 2 aforementioned fields should be returned together with the number of grouped entries in a column called count
        ? the result should also be sorted by day

? "events" table schema
    id (bigint)
    name (text)
    created_at (timestamp)
    description (text)
    expected result schema
    day (date)
    description (text)
    count (numeric)
?expected result schema
    day (date)
    description (text)
    count (numeric)
*/


SELECT
    date(created_at) as day
    , description
    , count(*) as count
FROM events
where name = 'trained'
group by day, description
order by day asc;
