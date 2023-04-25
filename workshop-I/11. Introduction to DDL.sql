/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 11/10/2022
-- Tópico: 11
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

[1. Create the DEPT table based on the following table instance chart. Save the statement in a
script called lab_11_01.sql, and then execute the statement in the script to create the
table. Confirm that the table is created.]

CREATE TABLE dept 
       (id   NUMBER(7)
             CONSTRAINT dep_id_pk PRIMARY KEY,
       name  VARCHAR(25));

/*Exercício nº 2*/

[2. Create the EMP table based on the following table instance chart. Save the statement in a
script called lab_11_02.sql, and then execute the statement in the script to create the
table. Confirm that the table is created.]

CREATE TABLE emp 
        (id            NUMBER(7),
         last_name      VARCHAR2(25),
         first_name     VARCHAR2(25),
         dept_id        NUMBER(7),
         CONSTRAINT emp_dep_id_fk FOREIGN KEY (dept_id)
                    REFERENCES dept(id));

       
/*Exercício nº 3*/

[3. Modify the EMP table. Add a COMMISSION column of the NUMBER data type, with precision 2
and scale 2. Confirm your modification.]

ALTER TABLE emp
ADD   (commission        NUMBER(2,2));


/*Exercício nº 4*/

[4. Modify the EMP table to allow for longer employee last names. Confirm your modification.]

ALTER TABLE emp 
MODIFY      (last_name   VARCHAR2(50));

/*Exercício nº 5*/

[5. Drop the FIRST_NAME column from the EMP table. Confirm your modification by checking
the description of the table.]

ALTER TABLE emp
DROP (first_name);

/*Exercício nº 6*/

[6. In the EMP table, mark the DEPT_ID column as UNUSED. Confirm your modification by
checking the description of the table.]

ALTER TABLE emp
SET UNUSED (dept_id);

/*Exercício nº 7*/

[7. Drop all the UNUSED columns from the EMP table.]

DROP UNUSED COLUMNS;

/*Exercício nº 8*/

[8. Create the EMPLOYEES2 table based on the structure of the EMPLOYEES table. Include only
the EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, and DEPARTMENT_ID columns.
Name the columns in your new table ID, FIRST_NAME, LAST_NAME, SALARY, and
DEPT_ID, respectively.]

 /*imagino que o exercício queira que eu crie usando uma subquery, mas como
   estou modificando ela, criei uma nova*/

CREATE TABLE employees2
        (id             NUMBER(6),
         first_name     VARCHAR2(20),
         last_name      VARCHAR2(25) NOT NULL,
         salary         NUMBER(8,2),
         dept_id        NUMBER(4));

/*Exercício nº 9*/

[9. Alter the status of the EMPLOYEES2 table to read-only.]

ALTER TABLE employees2 READ ONLY;

/*Exercício nº 10*/

[10. Try to add a column JOB_ID in the EMPLOYEES2 table.]

ALTER TABLE employees2
ADD         (job_id    VARCHAR2(9));

/*Exercício nº 11*/

[11. Revert the EMPLOYEES2 table to the read/write status. Now try to add the same column
again.]

ALTER TABLE employees2 READ WRITE;

ALTER TABLE employees2
ADD         (job_id    VARCHAR2(9));

/*Exercício nº 12*/

[12. Drop the EMP, DEPT, and EMPLOYEES2 table.]

DROP TABLE emp;
DROP TABLE dept;
DROP TABLE employees2;
