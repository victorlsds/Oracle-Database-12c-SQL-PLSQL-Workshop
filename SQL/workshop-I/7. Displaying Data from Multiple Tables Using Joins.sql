/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 03/10/2022
-- Tópico: 7
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

[1. Write a query for the HR department to produce the addresses of all the departments. Use
the LOCATIONS and COUNTRIES tables. Show the location ID, street address, city, state or
province, and country in the output. Use a NATURAL JOIN to produce the results.]

SELECT l.location_id,
       l.street_address,
       l.city,
       l.state_province,
       c.country_name
FROM   locations l NATURAL
JOIN   countries c;

/*Exercício nº 2*/

[2. The HR department needs a report of all employees with corresponding departments. Write
a query to display the last name, department number, and department name for these
employees.]

SELECT e.last_name,
       e.department_id,
       d.department_name
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id;

/*Exercício nº 3*/

[3. The HR department needs a report of employees in Toronto. Display the last name, job,
department number, and the department name for all employees who work in Toronto.]

SELECT e.last_name,
       e.job_id,
       e.department_id,
       d.department_name
FROM   employees e
JOIN   departments d
ON     (e.department_id = d.department_id)
JOIN   locations l
ON     (d.location_id = l.location_id)
WHERE  l.city = 'Toronto';

/*Exercício nº 4*/

[4. Create a report to display employees’ last names and employee numbers along with their
managers’ last names and manager numbers. Label the columns Employee, Emp#,
Manager, and Mgr#, respectively. Save your SQL statement as lab_07_04.sql. Run the
query.]

SELECT worker.last_name    "Employee",
       worker.employee_id  "EMP#",
       manager.last_name   "Manager",
       manager.employee_id "Mgr#"
FROM   employees worker
JOIN   employees manager
ON     (worker.manager_id = manager.employee_id);

/*Exercício nº 5*/

[5. Modify lab_07_04.sql to display all employees, including King, who has no manager.
Order the results by employee number. Save your SQL statement as lab_07_05.sql.
Run the query in lab_07_05.sql.]

SELECT worker.last_name    "Employee",
       worker.employee_id  "EMP#",
       manager.last_name   "Manager",
       manager.employee_id "Mgr#"
FROM   employees worker
LEFT   JOIN employees manager
ON     (worker.manager_id = manager.employee_id)
ORDER  BY 2;

/*Exercício nº 6*/

[6. Create a report for the HR department that displays employee last names, department
numbers, and all the employees who work in the same department as a given employee.
Give each column an appropriate label. Save the script to a file named lab_07_06.sql.]

SELECT dp.department_id AS department,
       dp.last_name     AS employee,
       samedp.last_name AS colleague
FROM   employees samedp
JOIN   employees dp
ON     (dp.department_id = samedp.department_id)
WHERE  dp.employee_id != samedp.employee_id
ORDER  BY 1;

/*Exercício nº 7*/

[7. The HR department needs a report on job grades and salaries. To familiarize yourself with
the JOB_GRADES table, first show the structure of the JOB_GRADES table. Then create a
query that displays the name, job, department name, salary, and grade for all employees.]

-- DESC job_grades

SELECT e.last_name,
       e.job_id,
       d.department_name,
       e.salary,
       j.grade_level
FROM   employees e
JOIN   departments d
ON     e.department_id = d.department_id
JOIN   job_grades j
ON     e.salary BETWEEN j.lowest_sal AND j.highest_sal;

/*Exercício nº 8*/

[8. The HR department wants to determine the names of all employees who were hired after
Davies. Create a query to display the name and hire date of any employee hired after
employee Davies.]

SELECT e.first_name,
       to_CHAR(e.hire_date, 'DD-MON-RR')
FROM   employees e
LEFT JOIN   employees d
ON     (d.last_name = 'Davies')
WHERE  d.hire_date < e.hire_date;

/*Exercício nº 9*/

[9. The HR department needs to find the names and hire dates of all employees who were
hired before their managers, along with their managers’ names and hire dates. Save the
script to a file named lab_07_09.sql.]

SELECT em.last_name,
       to_CHAR(em.hire_date, 'DD-MON-RR'),
       man.last_name,
       to_CHAR(man.hire_date, 'DD-MON-RR')
FROM   employees em
JOIN   employees man
ON     (em.manager_id = man.employee_id)
WHERE  em.hire_date < man.hire_date;
