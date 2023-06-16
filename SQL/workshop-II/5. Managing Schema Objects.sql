/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 18/10/2022
-- Tópico: 5
-- Instrutor: Gustavo
****************************************************************************
*/

/*1. Create the DEPT2 table based on the following table instance chart. Enter the syntax in the
SQL Worksheet. Then, execute the statement to create the table. Confirm that the table is
created.*/

CREATE TABLE dept2
       (id   NUMBER(7),
        name VARCHAR2(25));
        
DESC dept2;

/*2. Populate the DEPT2 table with data from the DEPARTMENTS table. Include only the columns
that you need. Confirm that the rows are inserted.*/

INSERT INTO dept2 (id, name)
SELECT department_id,
       department_name
FROM   departments;

/*3. Create the EMP2 table based on the following table instance chart. Enter the syntax in the
SQL Worksheet. Then execute the statement to create the table. Confirm that the table is
created.*/

CREATE TABLE emp2(id NUMBER(7),
                  last_name VARCHAR2(25),
                  first_name VARCHAR2(25),
                  dept_id NUMBER(7));

DESC emp2;

/*4. Add a table-level PRIMARY KEY constraint to the EMP2 table on the ID column. The
constraint should be named at creation. Name the constraint my_emp_id_pk.*/

ALTER TABLE emp2 ADD CONSTRAINT my_emp_id_pk PRIMARY KEY(id);

/*5. Create a PRIMARY KEY constraint to the DEPT2 table using the ID column. The constraint
should be named at creation. Name the constraint my_dept_id_pk.*/

ALTER TABLE dept2 ADD CONSTRAINT my_dept_id_pk PRIMARY KEY(id);

/*6. Add a foreign key reference on the EMP2 table that ensures that the employee is not
assigned to a nonexistent department. Name the constraint my_emp_dept_id_fk.*/

ALTER TABLE emp2 ADD CONSTRAINT my_emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES dept2(id);

/*7. Modify the EMP2 table. Add a COMMISSION column of the NUMBER data type, precision 2,
scale 2. Add a constraint to the COMMISSION column that ensures that a commission value
is greater than zero.*/

ALTER TABLE emp2 ADD(commission NUMBER(2, 2));

ALTER TABLE emp2 ADD CONSTRAINT emp2_comm_ck CHECK(commission > 0);

/*8. Drop the EMP2 and DEPT2 tables so that they cannot be restored.*/

DROP TABLE emp2 PURGE;
DROP TABLE dept2 PURGE;
