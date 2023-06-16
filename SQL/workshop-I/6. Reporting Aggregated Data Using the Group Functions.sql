/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 02/10/2022
-- Tópico: 6
****************************************************************************
*/

/*Exercício nº 1*/

[1. Group functions work across many rows to produce one result per group.
True/False]

--TRUE

/*Exercício nº 2*/

[2. Group functions include nulls in calculations.
True/False]

--FALSE

/*Exercício nº 3*/

[3. The WHERE clause restricts rows before inclusion in a group calculation.
True/False]

--TRUE

/*Exercício nº 4*/

[4. Find the highest, lowest, sum, and average salary of all employees. Label the columns
Maximum, Minimum, Sum, and Average, respectively. Round your results to the
nearest whole number. Save your SQL statement as lab_06_04.sql. Run the query.]

SELECT ROUND(MAX(salary)) "Maximum",
       ROUND(MIN(salary)) "Minimum",
       ROUND(SUM(salary)) "Sum",
       ROUND(AVG(salary)) "Average"
FROM   employees;

/*Exercício nº 5*/

[5. Modify the query in lab_06_04.sql to display the minimum, maximum, sum, and
average salary for each job type. Save lab_06_04.sql as lab_06_05.sql again.
Run the statement in lab_06_05.sql.]

SELECT job_id,
       ROUND(MAX(salary)) "Maximum",
       ROUND(MIN(salary)) "Minimum",
       ROUND(SUM(salary)) "Sum",
       ROUND(AVG(salary)) "Average"
FROM   employees
GROUP  BY job_id;

/*Exercício nº 6*/

[6. Write a query to display the number of people with the same job.
Generalize the query so that the user in the HR department is prompted for a job title.
Save the script to a file named lab_06_06.sql. Run the query. Enter IT_PROG when
prompted.]

SELECT job_id,
       COUNT(*)
FROM   employees
WHERE  (upper(job_id) = upper('&job_entrada'))
GROUP  BY job_id;

/*Exercício nº 7*/

[7. Determine the number of managers without listing them. Label the column Number of
Managers.]

SELECT COUNT(DISTINCT manager_id) AS "Number of Managers"
FROM   employees;

/*Exercício nº 8*/

[8. Find the difference between the highest and lowest salaries. Label the column
DIFFERENCE.]

SELECT (MAX(salary) - MIN(SALARY))
FROM   employees;

/*Exercício nº 9*/

[9. Create a report to display the manager number and the salary of the lowest-paid
employee for that manager. Exclude anyone whose manager is not known. Exclude
any groups where the minimum salary is $6,000 or less. Sort the output in descending
order of salary.]

SELECT manager_id,
       MIN(salary)
FROM   employees
WHERE  manager_id IS NOT NULL
GROUP  BY manager_id
HAVING MIN(salary) > 6000
ORDER  BY 2 DESC;

/*Exercício nº 10*/

[10. Create a query to display the total number of employees and, of that total, the number
of employees hired in 2005, 2006, 2007, and 2008. Create appropriate column
headings.]

--COMO O COUNT NÃO CONTA NULOS, USO ISSO NO DECODE 

SELECT COUNT(*) total,
       COUNT(decode(to_char(hire_date, 'YYYY'), '2005', hire_date, NULL)) "2005",
       COUNT(decode(to_char(hire_date, 'YYYY'), '2006', hire_date, NULL)) "2006",
       COUNT(decode(to_char(hire_date, 'YYYY'), '2007', hire_date, NULL)) "2007",
       COUNT(decode(to_char(hire_date, 'YYYY'), '2008', hire_date, NULL)) "2008"
FROM   employees;

/*Exercício nº 11*/

[11. Create a matrix query to display the job, the salary for that job based on the department
number, and the total salary for that job, for departments 20, 50, 80, and 90, giving each
column an appropriate heading.]

SELECT job_id "Job",
       SUM(decode(department_id, 20, salary, NULL)) AS "Dept 20",
       SUM(decode(department_id, 50, salary, NULL)) AS "Dept 50",
       SUM(decode(department_id, 80, salary, NULL)) AS "Dept 80",
       SUM(decode(department_id, 90, salary, NULL)) AS "Dept 90", 
       SUM(salary) "Total"
FROM employees
GROUP BY job_id;
