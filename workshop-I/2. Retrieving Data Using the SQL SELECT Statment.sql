/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 28/09/2022
-- Tópico: 2
****************************************************************************
*/

/*Exercício nº 1*/

[1. The following SELECT statement executes successfully:
SELECT last_name, job_id, salary AS Sal
FROM employees;]

--a) TRUE

[2. The following SELECT statement executes successfully:
SELECT *
FROM job_grades;]

--b) TRUE

[3. There are four coding errors in the following statement. Can you identify them?]
--c) Os erros são: a falta de vírgula após "last_name"; nome da coluna "salary", escrita como "sal" no exercício; o operador de multiplicação (*) que está incorreto "x"; os outros dois erros estão na forma de renomear a coluna, em que deveria ser utilizado o 'AS' seguido do nome, que por conter espaço deve estar entre aspas, "ANUAL SALARY".


/*Exercício nº 2*/

[1. Your first task is to determine the structure of the DEPARTMENTS table and its contents.]
--a)(Command Window)

DESC departments;

SELECT *
FROM   departments;

[2. Your task is to determine the structure of the DEPARTMENTS table and its contents.
a. Determine the structure of the EMPLOYEES table.]
--b) 
  --i)(Command Window)

DESC employees;

[b. The HR department wants a query to display the last name, job ID, hire date, and
employee ID for each employee, with the employee ID appearing first. Provide an alias
STARTDATE for the HIRE_DATE column. Save your SQL statement to a file named
lab_02_05.sql so that you can dispatch this file to the HR department. Test your
query in the lab_02_05.sql file to ensure that it runs correctly.]
  --ii) 

SELECT employee_id,
       last_name,
       job_id,
       hire_date AS "STARTDATE"
FROM   employees;

[3. The HR department wants a query to display all unique job IDs from the EMPLOYEES table.]
--c)

SELECT DISTINCT job_id
FROM   employees;


/*Exercício nº 3*/

[1. The HR department wants more descriptive column headings for its report on employees.
Copy the statement from lab_02_05.sql to a new SQL Worksheet. Name the columns
Emp #, Employee, Job, and Hire Date, respectively. Then run the query again.]
--a)

SELECT employee_id AS "Emp #",
       last_name   AS "Employee",
       job_id      AS "Job",
       hire_date   AS "Hire Date"
FROM   employees;

[2. The HR department has requested a report of all employees and their job IDs. Display the
last name concatenated with the job ID (separated by a comma and space) and name the
column Employee and Title.]
--b)

SELECT last_name || ', ' || job_id AS "Employee and Title"
FROM   employees;

[3. To familiarize yourself with the data in the EMPLOYEES table, create a query to display all
the data from that table. Separate each column output by a comma. Name the column
THE_OUTPUT.]
--c)

SELECT employee_id || ',' || first_name || ',' || last_name || ',' ||
       email || ',' || phone_number || ',' || hire_date || ',' || job_id || ',' ||
       salary || ',' || commission_pct || ',' || manager_id || ',' ||
       department_id AS "THE_OUTPUT"
FROM   employees;
