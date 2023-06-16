/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 28/09/2022
-- Tópico: 3
****************************************************************************
*/

/*Exercício nº 1*/

[1. Because of budget issues, the HR department needs a report that displays the last name
and salary of employees who earn more than $12,000. Save your SQL statement as a file
named lab_03_01.sql. Run your query.]

SELECT last_name,
       salary
FROM   employees
WHERE  salary > 12000;

/*Exercício nº 2*/

[2. Open a new SQL Worksheet. Create a report that displays the last name and department
number for employee number 176. Run the query.]

SELECT last_name,
       department_id
FROM   employees
WHERE  employee_id = 176;

/*Exercício nº 3*/

[3. The HR department needs to find high-salary and low-salary employees. Modify
lab_03_01.sql to display the last name and salary for any employee whose salary is not
in the range $5,000 through $12,000. Save your SQL statement as lab_03_03.sql.]

SELECT last_name,
       salary
FROM   employees
WHERE  salary NOT BETWEEN 5000 AND 12000;

/*Exercício nº 4*/

[4. Create a report to display the last name, job ID, and hire date for employees with the last
names of Matos and Taylor. Order the query in ascending order by hire date.]

SELECT last_name,
       job_id,
       hire_date
FROM   employees
WHERE  last_name IN ('Matos', 'Taylor')
ORDER  BY hire_date;

/*Exercício nº 5*/

[5. Display the last name and department ID of all employees in departments 20 or 50 in
ascending alphabetical order by name.]

SELECT last_name,
       department_id
FROM   employees
WHERE  department_id IN (20, 50)
ORDER  BY last_name;

/*Exercício nº 6*/

[6. Modify lab_03_03.sql to display the last name and salary of employees who earn
between $5,000 and $12,000, and are in department 20 or 50. Label the columns
Employee and Monthly Salary, respectively. Save lab_03_03.sql as
lab_03_06.sql again. Run the statement in lab_03_06.sql.]

SELECT last_name AS "Employee",
       salary    AS "Monthly Salary"
FROM   employees
WHERE  salary BETWEEN 5000 AND 12000
AND    department_id IN (20, 50);

/*Exercício nº 7*/

[7. The HR department needs a report that displays the last name and hire date of all
employees who were hired in 2006.]

SELECT last_name,
       hire_date
FROM   employees
WHERE  hire_date LIKE '%06';

/*Exercício nº 8*/

[8. Create a report to display the last name and job title of all employees who do not have a
manager.]

SELECT last_name,
       job_id
FROM   employees
WHERE  manager_id IS NULL;

/*Exercício nº 9*/

[9. Create a report to display the last name, salary, and commission of all employees who earn
commissions. Sort the data in descending order of salary and commissions.
Use the column’s numeric position in the ORDER BY clause.]

SELECT last_name,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER  BY 8         DESC,
          9 DESC;

/*Exercício nº 10*/

[10. Members of the HR department want to have more flexibility with the queries that you are
writing. They would like a report that displays the last name and salary of employees who
earn more than an amount that the user specifies after a prompt. Save this query to a file
named lab_03_10.sql. (You can use the query created in Task 1 and modify it.) If you
enter 12000 when prompted, the report displays the following results:]

SELECT last_name,
       salary
FROM   employees
WHERE  salary > &salary_var;

/*Exercício nº 11*/

[11. The HR department wants to run reports based on a manager. Create a query that prompts
the user for a manager ID, and generates the employee ID, last name, salary, and
department for that manager’s employees. The HR department wants the ability to sort the
report on a selected column. You can test the data with the following values:]

SELECT employee_id,
       last_name,
       salary,
       department_id
FROM   employees
WHERE  manager_id = &manger_var
ORDER  BY &sorted_var;

/*Exercício nº 12*/

[12. Display the last names of all employees where the third letter of the name is “a.”]

SELECT last_name
FROM   employees
WHERE  last_name LIKE '__a%';

/*Exercício nº 13*/

[13. Display the last names of all employees who have both an “a” and an “e” in their last name.]

SELECT last_name
FROM   employees
WHERE  last_name LIKE '%a%'
AND    last_name LIKE '%e%';

/*Exercício nº 14*/

[14. Display the last name, job, and salary for all employees whose jobs are either that of a
sales representative or a stock clerk, and whose salaries are not equal to $2,500, $3,500,
or $7,000.]

SELECT last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id IN ('SA_REP', 'ST_CLERK')
AND    salary NOT IN (2500, 3500, 7000);

/*Exercício nº 15*/

[15. Modify lab_03_06.sql to display the last name, salary, and commission for all
employees whose commission is 20%. Save lab_03_06.sql as lab_03_15.sql again.
Rerun the statement in lab_03_15.sql.]

SELECT last_name      AS "Employee",
       salary         AS "Monthly Salary",
       commission_pct
FROM   employees
WHERE  commission_pct = 0.2;
