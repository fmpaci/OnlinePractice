/*
* Resolution for SQL Codewars: Easy SQL: LowerCase.sql
* URL: https://www.codewars.com/kata/594800ba6fb152624300006d/train/sql

* Description:
    Given a demographics table in the following format:

** demographics table schema **

    id
    name
    birthday
    race
? you need to return the same table where all letters are lowercase in the race column.


*/
SELECT
    id
    ,name
    ,birthday
    ,LOWER(race) as race
FROM demographics
