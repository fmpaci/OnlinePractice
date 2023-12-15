/*
* Resolution for SQL Codewars: Even or Odd.sql
* URL: www.codewars.com/kata/53da3dbb4a5168369a0000fe/

* Description:
    You will be given a table numbers, with one column number.

Return a dataset with two columns: number and is_even, where number contains the original input value,
and is_even containing "Even" or "Odd" depending on number column values.

    ? Numbers table schema
        * number INT
    ? Output table schema
         * number  INT
        * is_even STRING
*/
select number
     , case when mod(number,2) = 0 then 'Even' else 'Odd' end as is_even
from numbers
