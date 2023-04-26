/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 20/10/2022
-- Tópico: 6
-- Instrutor: Gustavo
****************************************************************************
*/

/*1. Write a query to display the last name, department number, and salary of any employee
whose department number and salary both match the department number and salary of any
employee who earns a commission.*/

SELECT e.last_name,
       e.department_id,
       e.salary
FROM   employees e
WHERE  (e.department_id, e.salary) IN
       (SELECT d.department_id,
               d.salary
        FROM   employees d
        WHERE  commission_pct IS NOT NULL);

/*2. Display the last name, department name, and salary of any employee whose salary and
job ID match the salary and job_1D of any employee located in location ID 1700.*/

SELECT e.last_name,
       d.department_name,
       e.salary
FROM   employees e
JOIN   departments d
ON     (e.department_id = d.department_id)
WHERE  (e.salary, e.job_id) IN
       (SELECT i.salary,
               i.job_id
        FROM   employees i
        JOIN   departments p
        ON     (i.department_id = p.department_id)
        WHERE  location_id = 1700);

/*3. Create a query to display the last name, hire date, and salary for all employees who have
the same salary and manager_ID as Kochhar.*/

SELECT e.last_name,
       e.hire_date,
       e.salary
FROM   employees e
WHERE  (salary, manager_id) IN
       (SELECT salary,
               manager_id
        FROM   employees
        WHERE  LOWER(last_name) = 'kochhar')
AND    LOWER(last_name) <> 'kochhar';

/*4. Create a query to display the employees who earn a salary that is higher than the salary of
all the sales managers (JOB_ID = 'SA_MAN'). Sort the results from the highest to the
lowest.*/

SELECT e.last_name,
       e.job_id,
       e.salary
FROM   employees e
WHERE  e.salary > (SELECT MAX(d.salary)
                  FROM   employees d
                  WHERE  d.job_id = 'SA_MAN')
ORDER BY e.salary DESC;

/*5. Display details such as the employee ID, last name, and department ID of those
employees who live in cities the names of which begin with T.*/

SELECT e.employee_id,
       e.last_name,
       e.department_id
FROM   employees e
WHERE  e.department_id IN (SELECT d.department_id
                           FROM   departments d,
                                  locations   l
                           WHERE  d.location_id = l.location_id
                           AND    city LIKE ('T%'));

/*6. Write a query to find all employees who eam more than the average salary in their
departments. Display last name, salary, department ID, and the average salary for the
department. Sort by average salary and round to two decimals. Use aliases for the columns
retrieved by the query as shown in the sample output.*/

SELECT last_name AS ename,
       salary,
       department_id AS deptno,
       (SELECT ROUND(AVG(salary), 2)
        FROM   employees inner_table
        WHERE  inner_table.department_id = outer_table.department_id) AS dept_avg
FROM   employees outer_table
WHERE  salary >
       (SELECT AVG(salary)
        FROM   employees inner_table
        WHERE  inner_table.department_id = outer_table.department_id)
ORDER  BY dept_avg;

--ou--

SELECT a.last_name AS ename,
       a.salary,
       a.department_id AS deptno,
       ROUND(AVG(b.salary), 2) AS dept_avg
FROM   employees a
JOIN   employees b
ON     (a.department_id = b.department_id)
GROUP  BY a.last_name,
          a.salary,
          a.department_id
HAVING a.salary > AVG(b.salary)
ORDER  BY dept_avg;

/*7. Find all employees who are not supervisors.*/

--i) First, do this by using the NOT EXISTS operator.

SELECT last_name
FROM   employees e
WHERE  NOT EXISTS (SELECT 'X'
        FROM   employees
        WHERE  manager_id = e.employee_id);

--ii) Neste caso não é possivel alternar diretamente do "NOT EXISTS"
--    para "NOT IN" devido a presença de campos NULL. Desta maneira o 
--    "NOT IN" irá comparar o employee_id com NULL, retornando uma tabela vazia

SELECT last_name
FROM   employees
WHERE  employee_id NOT IN (SELECT manager_id
                           FROM   employees
                           WHERE  manager_id IS NOT NULL);

/*8. Write a query to display the last names of the employees who earn less than the average
salary in their departments.*/

SELECT last_name
FROM   employees o_table
WHERE  salary <
       (SELECT AVG(salary)
        FROM   employees i_table
        WHERE  i_table.department_id = o_table.department_id);

/*9. Write a query to display the last names of the employees who have one or more coworkers
in their departments with later hire dates but higher salaries.*/

SELECT last_name
FROM   employees o_table
WHERE  EXISTS (SELECT 'X'
        FROM   employees i_table
        WHERE  i_table.department_id = o_table.department_id
        AND    i_table.hire_date > o_table.hire_date
        AND    i_table.salary > o_table.salary);

/*10. Write a query to display the employee ID, last names, and department names of all the
employees.*/

SELECT e.employee_id,
       e.last_name,
       (SELECT department_name
        FROM   departments d
        WHERE  e.department_id = d.department_id) department
FROM   employees e
ORDER  BY department;

/*11. Write a query to display the department names of those departments whose total salary
cost is above one-eighth (1/8) of the total salary cost of the whole company. Use the WITH
clause to write this query. Name the query SUMMARY.*/

WITH summary AS
 (SELECT d.department_name,
         SUM(e.salary) AS "DEPT_TOTAL"
  FROM   employees e
  JOIN   departments d
  USING  (department_id)
  GROUP  BY department_name)
SELECT department_name,
       dept_total
FROM   summary
WHERE  dept_total > (SELECT SUM(dept_total) / 8
                     FROM   summary)
ORDER  BY 2 DESC;
