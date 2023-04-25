/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 10/10/2022
-- Tópico: 10
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

CREATE TABLE my_employee
       (id NUMBER(4) NOT NULL,
        last_name VARCHAR(25),
        first_name VARCHAR(25),
        userid VARCHAR(8),
        salary NUMBER(9,2));
        
/*Exercício nº 2*/

DESC my_employee;

/*Exercício nº 3*/

[3. Create an INSERT statement to add the first row of data to the MY_EMPLOYEE table from
the following sample data. Do not list the columns in the INSERT clause. Do not enter all
rows yet.]

INSERT INTO my_employee
VALUES      (1, 'Patel', 'Ralph', 'rpatel', 895);

/*Exercício nº 4, 5*/

[4. Populate the MY_EMPLOYEE table with the second row of the sample data from the
preceding list. This time, list the columns explicitly in the INSERT clause.
5. Confirm your addition to the table.]

INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES      (2, 'Dancs', 'Betty', 'bdancs', 860);

COMMIT;

/*Exercício nº 6, 7*/

[6. Write an INSERT statement in a dynamic reusable script file to load the remaining rows into
the MY_EMPLOYEE table. The script should prompt for all the columns (ID, LAST_NAME,
FIRST_NAME, USERID, and SALARY). Save this script to a lab_10_06.sql file.
7. Populate the table with the next two rows of the sample data listed in step 3 by running the
INSERT statement in the script that you created.]

INSERT INTO my_employee
VALUES      (&id, '&last_name', '&first_name', '&userid', &salary);

/*Exercício nº 8, 9*/

[Make the data additions permanent.]

SELECT * 
FROM my_employee;


COMMIT;

/*Exercício nº 10*/

[10. Change the last name of employee 3 to Drexler.]

UPDATE my_employee 
SET last_name = 'Drexler'
WHERE id = 3;

/*Exercício nº 11, 12*/

[11. Change the salary to $1,000 for all employees who have a salary less than $900.
12. Verify your changes to the table.]

UPDATE my_employee 
SET salary = 1000
WHERE salary < 900;


SELECT * FROM my_employee;
 
/*Exercício nº 13, 14, 15*/

[13. Delete Betty Dancs from the MY_EMPLOYEE table.
14. Confirm your changes to the table.
15. Commit all pending changes.]

DELETE FROM my_employee WHERE id = 5;


SELECT * FROM my_employee;


COMMIT;

/*Exercício nº 16, 17*/

[16. Populate the table with the last row of the sample data listed in step 3 by using the
statements in the script that you created in step 6. Run the statements in the script.
Note: Perform the steps (17-23) in one session only.
17. Confirm your addition to the table.]

CREATE TABLE my_employee2
       (id NUMBER(4) NOT NULL,
        last_name VARCHAR(25),
        first_name VARCHAR(25),
        userid VARCHAR(8),
        salary NUMBER(9,2));
        
INSERT INTO my_employee2 
VALUES      (&id, '&last_name', '&first_name', '&userid', &salary);

SELECT * FROM my_employee2;

/*Exercício nº 18*/

[18. Mark an intermediate point in the processing of the transaction.]

SAVEPOINT A;

/*Exercício nº 19, 20*/

[19. Delete all the rows from the MY_EMPLOYEE table.
20. Confirm that the table is empty.]

DELETE FROM my_employee2;

SELECT * FROM my_employee2;


/*Exercício nº 21, 22*/

[21. Discard the most recent DELETE operation without discarding the earlier INSERT operation.
22. Confirm that the new row is still intact.]

ROLLBACK TO SAVEPOINT A; 

SELECT * FROM my_employee2;


/*Exercício nº 23*/

[23. Make the data addition permanent.]

COMMIT;

/*Exercício nº 24, 25, 26*/

[24. Modify the lab_10_06.sql script such that the USERID is generated automatically by
concatenating the first letter of the first name and the first seven characters of the last
name. The generated USERID must be in lowercase. Therefore, the script should not
prompt for the USERID. Save this script to a file named lab_10_24.sql.
25. Run the lab_10_24.sql script to insert the following record:
26. Confirm that the new row was added with the correct USERID.]

CREATE TABLE my_employee3
       (id NUMBER(4) NOT NULL,
        last_name VARCHAR(25),
        first_name VARCHAR(25),
        userid VARCHAR(8),
        salary NUMBER(9,2));

INSERT INTO my_employee3
VALUES      (&id, '&last_name', '&first_name', LOWER(CONCAT(SUBSTR('&first_name', 1, 1), SUBSTR('&last_name', 1,7))), &salary);

COMMIT; 

