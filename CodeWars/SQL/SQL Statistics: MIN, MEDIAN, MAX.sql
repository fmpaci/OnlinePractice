/*
* Resolution for SQL Codewars: SQL Statistics: MIN, MEDIAN, MAX.sql
* URL: https://www.codewars.com/kata/58167fa1f544130dcf000317

* Description:
    For this challenge you need to create a simple SELECT statement. Your task is to calculate the MIN, MEDIAN and MAX scores of the students from the results table.

    ? Tables and relationship below:
        min
        median
        max

*/
SELECT
    MIN(score) min
  , percentile_cont(0.5) wITHIN GROUP (ORDER BY score) as median
  , MAX(score) max
from result