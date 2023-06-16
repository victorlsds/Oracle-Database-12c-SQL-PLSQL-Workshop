/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 30/09/2022
-- Tópico: 5
****************************************************************************
*/

/*Exercício nº 1*/

[1. Create a report that produces the following for each employee:
<employee last name> earns <salary> monthly but wants <3 times salary.>.
Label the column Dream Salaries.]

SELECT last_name || ' earns ' || TO_CHAR(salary, 'fm$99,999.00') ||
       ' monthly but wants ' || TO_CHAR(salary * 3, 'fm$99,999.00') AS "Dream Salaries"
FROM   employees;

SELECT last_name || ' earns $' || salary || ' monthly but wants $' ||
       salary * 3 "Dream Salary"
FROM   employees;

/*Exercício nº 2*/

[2. Display each employee’s last name, hire date, and salary review date, which is the first
Monday after six months of service. Label the column REVIEW. Format the dates to
appear in a format that is similar to “Monday, the Thirty-First of July, 2000.”]

SELECT last_name,
       hire_date,
       TO_CHAR(next_day(ADD_MONTHS(hire_date, 6), 'Monday'),
               'fmDay, "the" Ddspth Month, YYYY') AS review
FROM   employees;

/*Exercício nº 3*/

[3. Create a query that displays employees’ last names and commission amounts. If an
employee does not earn commission, show “No Commission.” Label the column COMM.]

SELECT last_name,
       NVL(TO_CHAR(commission_pct), 'No Commission')
FROM   employees;

/*Exercício nº 4*/

[4. Using the DECODE function, write a query that displays the grade of all employees based
on the value of the JOB_ID column, using the following data:]
       
SELECT job_id,
DECODE(job_id, 'AD_PRES', 'A', 
'ST_MAN', 'B', 'IT_PROG', 'C', 'SA_REP', 'D', 'ST_CLERK', 'E', '0')
FROM   employees;
