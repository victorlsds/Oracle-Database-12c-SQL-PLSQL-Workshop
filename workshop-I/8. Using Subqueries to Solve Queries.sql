/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 05/10/2022
-- Tópico: 8
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

[1. The HR department needs a query that prompts the user for an employee’s last name. The
query then displays the last name and hire date of any employee in the same department
as the employee whose name the user supplies (excluding that employee). For example, if
the user enters Zlotkey, find all employees who work with Zlotkey (excluding Zlotkey).]

SELECT last_name,
       e.hire_date
FROM   employees e
WHERE  e.department_id IN
       (SELECT f.department_id
        FROM   employees f
        WHERE  UPPER(f.last_name) = UPPER('&nome'))
AND    UPPER(e.last_name) != UPPER('&nome');

/*Exercício nº 2*/

[2. Create a report that displays the employee number, last name, and salary of all employees
who earn more than the average salary. Sort the results in ascending order by salary.]

SELECT e.employee_id,
       e.last_name,
       e.salary
FROM   employees e
WHERE  e.salary > (SELECT AVG(f.salary)
                   FROM   employees f)
ORDER  BY 3;

/*Exercício nº 3*/

[3. Write a query that displays the employee number and last name of all employees who work
in a department with any employee whose last name contains the letter “u.” Save your SQL
statement as lab_08_03.sql. Run your query.]

SELECT e.employee_id,
       e.last_name
FROM   employees e
WHERE  e.department_id IN
       (SELECT f.department_id
        FROM   employees f
        WHERE  UPPER(last_name) LIKE UPPER('%u%'));

/*Exercício nº 4*/

[4. The HR department needs a report that displays the last name, department number, and
job ID of all employees whose department location ID is 1700.]

--i)

SELECT e.last_name,
       e.department_id,
       e.job_id
FROM   employees e
WHERE  e.department_id IN (SELECT f.department_id
                           FROM   departments f
                           WHERE  f.location_id = 1700);
                           
--ii)

SELECT e.last_name,
       e.department_id,
       e.job_id
FROM   employees e
WHERE  e.department_id IN (SELECT f.department_id
                           FROM   departments f
                           WHERE  f.location_id = (&valor_location));

/*Exercício nº 5*/

[5. Create a report for HR that displays the last name and salary of every employee who
reports to King.]

SELECT e.last_name,
       e.salary
FROM   employees e
WHERE  e.manager_id IN (SELECT employee_id
                        FROM   employees
                        WHERE  last_name = 'King');

/*Exercício nº 6*/

[6. Create a report for HR that displays the department number, last name, and job ID for every
employee in the Executive department.]

SELECT e.department_id,
       e.last_name,
       e.job_id
FROM   employees e
WHERE  e.department_id IN
       (SELECT department_id
        FROM   departments
        WHERE  department_name = 'Executive');

/*Exercício nº 7*/

[7. Create a report that displays a list of all employees whose salary is more than the salary of
any employee from department 60.]

SELECT last_name
FROM   employees
WHERE  salary > ANY (SELECT salary
        FROM   employees
        WHERE  department_id = 60);

/*Exercício nº 8*/

[8. Modify the query in lab_08_03.sql to display the employee number, last name, and
salary of all employees who earn more than the average salary, and who work in a
department with any employee whose last name contains the letter “u.” Save
lab_08_03.sql as lab_08_08.sql again. Run the statement in lab_08_08.sql.]

SELECT e.employee_id,
       e.last_name,
       e.salary
FROM   employees e
WHERE  e.department_id IN
       (SELECT f.department_id
        FROM   employees f
        WHERE  UPPER(last_name) LIKE UPPER('%u%'))
AND    e.salary > (SELECT AVG(salary)
                   FROM   employees);
                   
