/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 18/10/2022
-- Tópico: 4
-- Instrutor: Gustavo
****************************************************************************
*/

/*1 The staff in the HR department wants to hide some of the data in the EMPLOYEES table.
Create a view called EMPLOYEES_VU based on the employee numbers, employee last
names, and department numbers from the EMPLOYEES table. The heading for the
employee name should be EMPLOYEE.*/

CREATE VIEW employees_vu
AS SELECT employee_id,
          last_name AS EMPLOYEE,
          department_id
   FROM employees;
   
/*2. Confirm that the view works. Display the contents of the EMPLOYEES_VU view.*/

SELECT * 
FROM employees_vu;

/*3. Using your EMPLOYEES view, write a query for the HR department to display all
employee names and department numbers.*/

SELECT employee,
       department_id 
FROM employees_vu;

/*4. Department 80 needs access to its employee data. Create a view named DEPT50 that
contains the employee numbers, employee last names, and department numbers for all
employees in department 80. You have been asked to label the view columns EMPNO,
EMPLOYEE, and DEPTNO. For security purposes, do not allow an employee to be
reassigned to another department through the view.*/

CREATE VIEW dept50 (empno, employee, deptno)
AS SELECT employee_id,
          last_name,
          department_id
   FROM   employees
   WHERE department_id = 50
   WITH CHECK OPTION CONSTRAINT dept50_ck; 

/*5. Display the structure and contents of the DEPT50 view.*/

DESC dept50;

SELECT * 
FROM dept50;

/*6. Test your view. Attempt to reassign Abel to department 80.*/

UPDATE dept50
SET    deptno = 80
WHERE  LOWER(employee) = LOWER('Mikkilineni');

/*7. Run lab_04_07.sql to create the dept50 view for this exercise.
You need to determine the names and definitions of all the views in your schema.
Create a report that retrieves view information: the view name and text from the
USER_VIEWS data dictionary view.*/

CREATE VIEW dept50
AS SELECT employee_id empno,
          last_name employee,
          department_id deptno
   FROM   employees
   WHERE department_id = 50
   WITH CHECK OPTION CONSTRAINT dept50_ck; 
   
SELECT view_name,
       text 
FROM  user_views
WHERE view_name = 'DEPT50';

/*Remove the views created in this practice.*/

DROP VIEW employees_vu;
DROP VIEW dept50;
