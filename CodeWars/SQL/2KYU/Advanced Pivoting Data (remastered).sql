/*
* Resolution for SQL Codewars: Advanced Pivoting Data (remastered).sql
* URL: https://www.codewars.com/kata/64c57002edf1bc9f208283bc

* Description:
    Your task is to calculate the amount of sales for each category of products for each department.
    But for a better look we want to pivot the table in a way that the columns become the departments name (with id)
    and each row contain the amount for each category.
    Departments in columns should be ordered by their id in ascending order
    and the resulting table should be ordered by category id as well.

    As we are making a report for an accountant who likes to double check everything so they asked us to include
    totals by rows and by columns. For the sake of simplicity in this report we have no conditions about dates
    so we include all sales through the history of our company.

    Our database has tables: products, categories, departments, sales.

    ? Table products has structure:
        id (integer): Primary key
        name (text): The name of the product (not used in the report)
        category_id (integer): The ID of category

    ? Table categories:
        id (integer): Primary key
        name (text): The name of the category.

    ? Table departments:
        id (integer): Primary key
        name (text): The name of the department.

    ? Table sales:
        id (integer): Primary key (not used in the report)
        date (timestamp): Transaction date (not used in the report)
        product_id (integer): The ID of the product
        department_id (integer): The ID of the department
        qty (decimal): qty of goods (not used in the report)
        amount (money): amount of money (amount = price * qty)

    * Your query should return:

        Cat. ID (integer): Category ID. NULL for the last line
        Category (text): Category name. NULL for the last line
        [department_name] ([department_id]) (money): amount of sales for a category within department. Total amount of sales within department for the last line
        Totals (money): Total amount of sales for a category. Total amount sales for the last line
    The result could look like:

     Cat. ID | Category  |East department (1)|West department (2)| Totals
    ---------+-----------+-------------------+-------------------+-----------
     1       | Food      | $1,234.15         | $85,214.50        | $86,448.65
     2       | Drinks    | $0.00             | $46,985.11        | $46,985.11
     3       | Non-food  | $499.99           | $512.00           | $1,011.99
     NULL    | NULL      | $1,734.14         | $132,711.61       | $134,445.75

    Notes:
    columns names don't follow SQL standards as the result should look like a report for a user
    departments or categories names could contain anything as they were stored in DB from the user input
    table 'sales' is not empty, so there is always at least one department
    your solution will be tested several times with different count of departments
    only departments/categories with at least one sale should be in the table
*/


create extension if not exists tablefunc;
DO
$$
DECLARE
    sql_stmt1 varchar;
    sql_stmt2 varchar;
    sql_cross_1 varchar;
    sql_cross_2 varchar;
    dml_list  varchar;
    sum_list varchar;
    add_list varchar;
    nvl_list varchar;
BEGIN

    sql_stmt1 = $st1$select STRING_AGG(strval, ', ' order by id) as cols
                 from (
                      SELECT
                          '"' || replace(dp.name,'"','""') || ' (' || dp.id || ')' || '"' || ' money' as strval
                          , dp.id
                      FROM departments dp
                          JOIN sales sl ON dp.id = sl.department_id
                      GROUP BY
                           dp.name, dp.id
                 ) tmp$st1$;

    EXECUTE sql_stmt1 into dml_list;


        sql_stmt1 = $st1$ select STRING_AGG(strval, ', ' order by id) as cols
                 from (
                      SELECT
                          'sum(COALESCE("' || replace(dp.name,'"','""') || ' (' || dp.id || ')' || '",''$0.00'') )' as strval
                          , dp.id
                      FROM departments dp
                          JOIN sales sl ON dp.id = sl.department_id
                      GROUP BY
                           dp.name, dp.id
                 ) tmp $st1$;

    EXECUTE sql_stmt1 into sum_list;

    sql_stmt1 = $st1$ select STRING_AGG(strval, '+ ' order by id) as cols
                 from (
                      SELECT
                          '(COALESCE("' || replace(dp.name,'"','""') || ' (' || dp.id || ')' || '",''$0.00''))' as strval
                          , dp.id
                      FROM departments dp
                          JOIN sales sl ON dp.id = sl.department_id
                      GROUP BY
                           dp.name, dp.id
                 ) tmp $st1$;

    EXECUTE sql_stmt1 into add_list;


    sql_stmt1 = $st1$ select STRING_AGG('COALESCE(' || strval || ', ''$0.00'') as ' || strval , ', ' order by id) as cols
                 from (
                      SELECT
                          '"' || replace(dp.name,'"','""') || ' (' || dp.id || ')' || '"' as strval
                          , dp.id
                      FROM departments dp
                          JOIN sales sl ON dp.id = sl.department_id
                      GROUP BY
                           dp.name, dp.id
                 ) tmp $st1$;

    EXECUTE sql_stmt1 into nvl_list;


    sql_cross_1 = $sc1$ 'SELECT
                          ct.id       as "Cat. ID"
                        , ct.name as "Category"
                        , dp.name
                        , COALESCE(SUM(sl.amount),''$0.00'') as amount
                    FROM     categories ct
                        JOIN products pr ON ct.id = pr.category_id
                        JOIN sales sl ON pr.id = sl.product_id
                        JOIN departments dp ON sl.department_id = dp.id
                    GROUP BY
                        ct.id, ct.name, 3
                    order by 1, 2, 3; '$sc1$;

    sql_cross_2 = '''SELECT dp.name  FROM departments dp JOIN sales sl ON dp.id = sl.department_id GROUP BY dp.name, dp.id order by dp.id;''';


    /*sql_stmt2 = 'drop table if exists report_tmp;
                CREATE TABLE report_tmp AS

                            ' || sql_cross_1  || '
                        ;';
    */
    sql_stmt2 = 'drop table if exists report_tmp;
                CREATE TABLE report_tmp AS
                    SELECT *
                    FROM crosstab(
                            ' || sql_cross_1  || '
                        ,   ' || sql_cross_2  || '
                )
                 AS final_result("Cat. ID" int, "Category" varchar, ' || dml_list || ');';
    EXECUTE sql_stmt2;

    sql_stmt2 = 'drop table if exists x1; create table x1 as
                  select "Cat. ID", "Category", ' || nvl_list || ', ' || add_list || ' as "Totals" from report_tmp
                  union all
                  select null, null, ' || sum_list || ', sum(' || add_list || ') as "Totals" from report_tmp
                  ';

    EXECUTE sql_stmt2;
END
$$;

SELECT *
FROM x1
