/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 11/10/2022
-- Tópico: adicionais
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

[1. The HR department needs to find data for all the clerks who were hired after 1997.]

SELECT *
FROM   employees
WHERE  job_id LIKE ('%CLERK')
AND    hire_date > TO_DATE('31-DEC-1997', 'DD-MON-RR');

/*Exercício nº 2*/

[2. The HR department needs a report of employees who earn a commission. Show the last
name, job, salary, and commission of these employees. Sort the data by salary in
descending order.]

SELECT last_name,
       job_id,
       salary,
       commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER  BY 3 DESC;

/*Exercício nº 3*/

[3. For budgeting purposes, the HR department needs a report on projected raises. The report
should display those employees who have no commission, but who have a 10% raise in
salary (round off the salaries).]

SELECT 'The salary of ' || (e.last_name) || ' after a 10% raise is ' ||
       TO_CHAR(ROUND(e.salary * 1.1)) AS "New Salary"
FROM   employees e
WHERE  commission_pct IS NULL;

/*Exercício nº 4*/

[4. Create a report of employees and their duration of employment. Show the last names of all
the employees together with the number of years and the number of completed months that
they have been employed. Order the report by the duration of their employment. The
employee who has been employed the longest should appear at the top of the list.]

SELECT last_name,
       TRUNC((MONTHS_BETWEEN(SYSDATE, hire_date)/12)) AS years,
       TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date), 12)) AS months
FROM   employees
ORDER BY 2 DESC, 3 DESC;

/*Exercício nº 5*/

[5. Show those employees who have a last name starting with the letters “J,” “K,” “L,” or “M.”]

SELECT last_name
FROM   employees
WHERE  SUBSTR(last_name, 1, 1) IN ('J', 'K', 'L', 'M');

/*Exercício nº 6*/

[6. Create a report that displays all employees, and indicate with the words Yes or No whether
they receive a commission. Use the DECODE expression in your query.]

SELECT last_name,
       salary,
       DECODE(commission_pct, NULL, 'No', 'Yes') AS commission
FROM   employees;

/*Exercício nº 7*/

[7. Create a report that displays the department name, location ID, last name, job title, and
salary of those employees who work in a specific location. Prompt the user for a location.
For example, if the user enters 1800, results are as follows:]

SELECT dep.department_name,
       dep.location_id,
       e.last_name,
       e.job_id,
       e.salary
FROM   departments dep
JOIN   employees e
USING  (department_id)
WHERE  dep.location_id = &valor_location;

/*Exercício nº 8*/

[8. Find the number of employees who have a last name that ends with the letter “n.” Create
two possible solutions.]

SELECT COUNT(*)
FROM   employees
WHERE  last_name LIKE ('%n');

SELECT COUNT(*)
FROM   employees
WHERE  SUBSTR(last_name, -1, 1) = ('n');

/*Exercício nº 9*/

[9. Create a report that shows the name, location, and number of employees for each
department. Make sure that the report also includes department_IDs without employees.]

SELECT department_id,
       department_name,
       location_id,
       COUNT(e.employee_id)
FROM   departments d
LEFT   OUTER JOIN employees e
USING  (department_id)
GROUP  BY (department_id, department_name, location_id);

/*Exercício nº 10*/

[10. The HR department needs to find the job titles in departments 10 and 20. Create a report to
display the job IDs for those departments.]

SELECT DISTINCT job_id
FROM   employees
WHERE  department_id IN (10, 20);

/*Exercício nº 11*/

[11. Create a report that displays the jobs that are found in the Administration and Executive
departments. Also display the number of employees for these jobs. Show the job with the
highest number of employees first.]

SELECT job_id,
       COUNT(*)AS frequency
FROM   employees
GROUP  BY (job_id)
HAVING job_id IN ('AD_VP', 'AD_ASST', 'AD_PRES')
ORDER  BY 2 DESC;

/*Exercício nº 12*/

[12. Show all the employees who were hired in the first half of the month (before the 16th of the
month, irrespective of the year).]

SELECT last_name,
       hire_date
FROM   employees
WHERE  TO_CHAR(hire_date, 'dd') < 16;

/*Exercício nº 13*/

[13. Create a report that displays the following for all employees: last name, salary, and salary
expressed in terms of thousands of dollars.]

SELECT last_name,
       salary,
       TRUNC(salary / 1000) AS thousands
FROM   employees;

/*Exercício nº 14*/

[14. Show all the employees who have managers with a salary higher than $15,000. Show the
following data: employee name, manager name, manager salary, and salary grade of the
manager.]

SELECT e.last_name,
       m.last_name,
       m.salary,
       j.grade_level
FROM   employees e
JOIN   employees m
ON     (e.manager_id = m.employee_id)
AND    m.salary > 15000
JOIN   job_grades j
ON     (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

/*Exercício nº 15*/

[15. Show the department number, name, number of employees, and average salary of all the
departments, together with the names, salaries, and jobs of the employees working in each
department.]

SELECT d.department_id,
       d.department_name,
       COUNT(t.department_id),
       NVL(TO_CHAR(AVG(t.salary),'fm999999D00'), 'No average'),
       e.last_name,
       TO_CHAR(e.salary, 'fm999999D00'),
       e.job_id
FROM   employees e
LEFT OUTER JOIN   departments d
ON     (e.department_id = d.department_id)
LEFT OUTER JOIN   employees t
ON     (d.department_id = t.department_id)
GROUP  BY (d.department_id, d.department_name, e.last_name, e.salary,
           e.job_id)
ORDER BY d.department_id;

/*Exercício nº 16*/

[16. Create a report to display the department number and lowest salary of the department with
the highest average salary.]

SELECT department_id,
       MIN(salary)
FROM   employees
GROUP  BY department_id
HAVING AVG(salary) = (SELECT MAX(AVG(salary))
                      FROM   employees
                      GROUP  BY department_id);

/*Exercício nº 17*/

[17. Create a report that displays departments where no sales representatives work. Include the
department number, department name, manager ID, and location in the output.]

SELECT *
FROM   departments
WHERE  department_id IN
       (SELECT department_id
        FROM   employees
        WHERE  job_id NOT LIKE ('SA_REP'));

/*Exercício nº 18*/

[18. Create the following statistical reports for the HR department. Include the department
number, department name, and the number of employees working in each department that:
a. Employs fewer than three employees:]

--i)

SELECT d.department_id,
       department_name,
       COUNT(*)
FROM   departments d
JOIN   employees e
ON     (d.department_id = e.department_id)
GROUP  BY d.department_id,
          department_name
HAVING COUNT(*) < 3;

--ii) 

[b. Has the highest number of employees:]

SELECT d.department_id,
       department_name,
       COUNT(*)
FROM   departments d
JOIN   employees e
ON     (d.department_id = e.department_id)
GROUP  BY d.department_id,
          department_name
HAVING COUNT(*) IN (SELECT MAX(COUNT(department_id))
                    FROM   employees
                    GROUP  BY department_id);

--iii)

[c. Has the lowest number of employees:]

SELECT d.department_id,
       department_name,
       COUNT(*)
FROM   departments d
JOIN   employees e
ON     (d.department_id = e.department_id)
GROUP  BY d.department_id,
          department_name
HAVING COUNT(*) IN (SELECT MIN(COUNT(department_id))
                    FROM   employees
                    GROUP  BY department_id
                    HAVING COUNT(department_id) <> 0);

/*Exercício nº 19*/

[19. Create a report that displays the employee number, last name, salary, department number,
and the average salary in their department for all employees.]

SELECT e.employee_id,
       e.last_name,
       e.department_id,
       e.salary,
       AVG(s.salary)
FROM   employees e
JOIN   employees s
ON     (e.department_id = s.department_id)
GROUP  BY e.employee_id,
          e.last_name,
          e.department_id,
          e.salary;

/*Exercício nº 20*/

[20. Create an anniversary overview based on the hire date of the employees. Sort the
anniversaries in ascending order.]

SELECT last_name,
       TO_CHAR(hire_date, 'Month   dd') AS birthday
FROM employees
ORDER BY TO_CHAR(hire_date, 'MM-dd') ASC;
