/******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 25/10/2022
-- Tópico: 9
-- Instrutor: Gustavo
****************************************************************************/

/*1. Run the lab_09_01.sql script in the lab folder to create the SAL_HISTORY table.*/

CREATE TABLE sal_history
             (employee_id    NUMBER(6),
              hire_date      DATE,
              salary         NUMBER(8,2));
              
/*2. Display the structure of the SAL_HISTORY table.*/

DESC sal_history;

/*3. Run the lab_09_03.sql script in the lab folder to create the MGR_HISTORY table.*/

CREATE TABLE mgr_history
             (employee_id    NUMBER(6),
              manager_id     NUMBER(6),
              salary         NUMBER(8,2));
              
/*4. Display the structure of the MGR_HISTORY table.*/

DESC mgr_history;

/*5. Run the lab_09_05.sql script in the lab folder to create the SPECIAL_SAL table.*/

CREATE TABLE special_sal
             (employee_id    NUMBER(6),
              salary         NUMBER(8,2));

/*6. Display the structure of the SPECIAL_SAL table.*/

DESC special_sal;

/*Exercício nº 7*/

--A) Write a query to do the following:

INSERT ALL
WHEN salary > 20000 THEN
INTO special_sal VALUES (employee_id, salary)
ELSE
INTO sal_history VALUES (employee_id, hire_date, salary)
INTO mgr_history VALUES (employee_id, manager_id, salary)
SELECT employee_id,
       hire_date,
       salary,
       manager_id
FROM   employees
WHERE  employee_id <= 125;

COMMIT;
--B/C/D)

DESC special_sal;
DESC sal_history;
DESC mgr_history;

/*Exercício nº 8*/

--A) Run the lab_09_08_a.sql script in the lab folder to create the SALES_WEEK_DATA table.

CREATE TABLE sales_week_data(ID NUMBER(6),
                             week_id NUMBER(2),
                             qty_mon NUMBER(8, 2),
                             qty_tue NUMBER(8, 2),
                             qty_wed NUMBER(8, 2),
                             qty_thur NUMBER(8, 2),
                             qty_fri NUMBER(8, 2));

--B) Run the lab_09_08_b.sql script in the lab folder to insert records into the SALES_WEEK_DATA table.

INSERT INTO sales_week_data
VALUES
  (200,
   6,
   2050,
   2200,
   1700,
   1200,
   3000);

COMMIT;

--C) Display the structure of the SALES_WEEK_DATA table.

DESC sales_week_data;

--D) Display the records from the SALES_WEEK_DATA table.

SELECT *
FROM   sales_week_data;

--E)

CREATE TABLE emp_sales_info(id NUMBER(6),
                            week NUMBER(2),
                            qty_sales NUMBER(8, 2));

--F) 

DESC emp_sales_info;

--G)

INSERT ALL INTO emp_sales_info
VALUES
  (id,
   week_id,
   qty_mon) INTO emp_sales_info
VALUES
  (id,
   week_id,
   qty_tue) INTO emp_sales_info
VALUES
  (id,
   week_id,
   qty_wed) INTO emp_sales_info
VALUES
  (id,
   week_id,
   qty_thur) INTO emp_sales_info
VALUES
  (id,
   week_id,
   qty_fri)
  SELECT id,
         week_id,
         qty_mon,
         qty_tue,
         qty_wed,
         qty_thur,
         qty_fri
  FROM   sales_week_data;

COMMIT;

--H) 

SELECT *
FROM   emp_sales_info;

/*Exercício nº 11*/

CREATE TABLE emp2(id NUMBER(7),
                  last_name VARCHAR2(25),
                  first_name VARCHAR2(25),
                  dept_id NUMBER(7));

/*Exercício nº 12*/

DROP TABLE emp2;

/*Exercício nº 13*/

SELECT original_name,
       operation,
       droptime
FROM   recyclebin
WHERE  UPPER(type) = 'TABLE';

/*Exercício nº 14*/

FLASHBACK TABLE EMP2 TO BEFORE DROP;

/*Exercício nº 15*/

--i)
CREATE TABLE emp3(id NUMBER(7),
                  last_name VARCHAR2(25),
                  first_name VARCHAR2(25),
                  dept_id NUMBER(7));
                  
INSERT INTO emp3 (id, last_name, first_name, dept_id)
       SELECT employee_id, last_name, first_name, department_id
       FROM employees;

--ii)
UPDATE emp3
SET    dept_id = 60
WHERE LOWER(last_name) = 'kochhar';
COMMIT;

UPDATE emp3
SET    dept_id = 50
WHERE LOWER(last_name) = 'kochhar';
COMMIT;

--iii)
SELECT versions_starttime "START_DATE",
       versions_endtime "END_DATE", 
       dept_id
FROM emp3
       VERSIONS BETWEEN SCN MINVALUE 
       AND MAXVALUE
WHERE LOWER(last_name) = 'kochhar'; 

/*Exercício nº 16*/

--i)
DROP TABLE emp2 PURGE;
DROP TABLE emp3 PURGE;

--ii)
SELECT original_name,
       operation,
       droptime
FROM   recyclebin
WHERE  UPPER(type) = 'TABLE';
