/*
* Resolution for SQL Codewars: ASCII Patterns Using SQL: part 3 (heart shape ❤️) .sql
* URL: https://www.codewars.com/kata/6500add867abf10c71d761b3


* Description:
    This SQL task is a small token of my gratitude to those who have generously lent their time and expertise
to help me create katas. Separately I want to express my gratitude to dfhwze who approved almost all my katas.
Voile, Unnamed, Twilight_Sun, monadius and others for consistent solving of beta katas and providing valuable feeback.
Your support has not only enriched my work but also inspiring me to pay the gift of knowledge forward!

    Description
    Your task is to implement a PostgreSQL PL/pgSQL function called draw_heart that will generate an ASCII art
    representation of a heart shape.
    The function should return this representation as rows of text in a PostgreSQL table.

    ? Your function should match the following signature:

        create or replace function draw_heart(size integer)
        returns table(heart_shape text) as $$
        -- Your implementation goes here
        $$ language plpgsql;

    ? Input:
       * size (integer): An integer parameter indicating the size of the heart shape. The minimum size is 4.

    ? Output
    The function will return a table with a single column named heart_shape.
    Each row in the table represents a row in the heart shape, filled with asterisks ("*") and spaces.
    For example, for size 5, the pattern should be:

     ** **
    *******
     *****
      ***
       *
    Look tests for more examples.

    GLHF!
*/



create or replace function draw_heart(size integer)
returns table(heart_shape text) as $$
DECLARE
    row_n INTEGER;
    rep_spaces INTEGER;
    rep_stars INTEGER;
BEGIN
    IF size < 4 THEN
        RAISE EXCEPTION 'Size must be 4 or greater';
    END IF;

    rep_spaces := 0;
    rep_stars := size - 2;

    FOR row_n IN 1..size LOOP
        IF row_n = 1 THEN
            heart_shape := repeat(' ',1) || repeat('*',rep_stars-1) || ' ' || repeat('*',rep_stars-1);
        ELSIF row_n <= size THEN
            heart_shape := repeat(' ',rep_spaces) || repeat('*',rep_stars) || '*' || repeat('*',rep_stars);
            rep_spaces = rep_spaces + 1;
            rep_stars = rep_stars -1;
        END IF;

        RETURN NEXT;
    END LOOP;
END;
$$ language plpgsql;
