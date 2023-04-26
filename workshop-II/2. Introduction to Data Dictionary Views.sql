/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 14/10/2022
-- Tópico: 2
-- Instrutor: Gustavo
****************************************************************************
*/

/*I. Query the USER TABLES data dictionary view to see information about the tables that you*/

SELECT table_name
FROM   tabs;

/*2. Query the ALL_TABLES data dictionary view to see information about all the tables that you
access. Exclude the tables that you own.*/

SELECT table_name,
       owner
FROM   all_tables
WHERE  LOWER(owner) <> 'vlsantoss';

/*3. Fora specified table, create a script that reports the column names, data types, and data
types' lengths, as well as whether nulls are allowed. Prompt the user to enter the table
name. Give appropriate aliases to the DATA PRECISION and DATA SCALE columns.
Save this script in a file named lab 02_03. sql.*/

SELECT column_name,
       data_type,
       data_length,
       data_precision AS "PRECISION",
       data_scale     AS "SCALE",
       nullable
FROM   user_tab_columns
WHERE  LOWER(table_name) = '&tabela';

/*4. Create a script that reports the column name, constraint name, constraint type, search
condition, and status for a specified table. You must join the USER CONSTRAINTS and
USER CONS COLUMNS tables to obtain all this information. Prompt the user to enter the
table name. Save the script in a file named lab 02 04 . sql.*/

SELECT column_name,
       constraint_name,
       constraint_type,
       search_condition,
       status
FROM   user_constraints e
JOIN   user_cons_columns
USING  (constraint_name)
WHERE LOWER(e.table_name) = LOWER('&tabela') ;

/*5. Add a comment to the DEPARTMENTS table. Then query the ÜSER_TAB COMMENTS view to
verify that the comment is present-*/

COMMENT ON TABLE departments IS 'Company department information including name, code, and location.';

SELECT *
FROM   user_tab_comments
WHERE  table_name = 'DEPARTMENTS';

/*6. Run the lab 02_06_tab. sql script as a prerequisite for exercises 6 through 9.
Atematively, open the script file to copy the code and paste it into your SQL Worksheet.
Then execute the script. This script:
• Drops the existing DEPT2 and EMP2 tables
• Creates the DEPT2 and tables*/

CREATE TABLE dept2(id NUMBER(7) CONSTRAINT dep_id_pk PRIMARY KEY,
                   NAME VARCHAR(25));

CREATE TABLE emp2(id NUMBER(7),
                  last_name VARCHAR(25),
                  first_name VARCHAR(25),
                  dept_id NUMBER(7),
                  CONSTRAINT emp2_dep_id_fk FOREIGN KEY(dept_id) REFERENCES
                  dept2(id));

/*7. Confirm that both the DEPT2 and EMP2 tables are stored in the data dictionary.*/

SELECT *
FROM   cat
WHERE  LOWER(table_name) IN ('dept2', 'emp2');

/*8. Confirm that the constraints were added, by querying the USER CONSTRAINTS view. Note
the types and names of the constraints.*/

SELECT constraint_name,
       constraint_type
FROM user_constraints
WHERE LOWER(table_name) IN ('dept2', 'emp2');

/*9. Display the object names and types from the USER OBJECTS data dictionary view for the
EMP2 and DEPT2 tables.*/

SELECT object_name,
       object_type
FROM user_objects
WHERE LOWER(object_name) IN ('dept2', 'emp2'); 

SELECT *
FROM   user_tab_columns
WHERE  LOWER(table_name) = 'employees';

select * from user_constraints;
