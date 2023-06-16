/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 28/09/2022
-- Tópico: 4
****************************************************************************
*/

/*Exercício nº 1*/

[1. Write a query to display the system date. Label the column Date.]

SELECT SYSDATE "Date"
FROM   dual;

/*Exercício nº 2, 3*/

[2. The HR department needs a report to display the employee number, last name, salary, and
salary increased by 15.5% (expressed as a whole number) for each employee. Label the
column New Salary. Save your SQL statement in a file named lab_04_02.sql.
3. Run your query in the lab_04_02.sql file.]

SELECT employee_id,
       last_name,
       salary,
       ROUND((salary * 115.5 / 100)) "New Salary"
FROM   employees;

/*Exercício nº 4*/

[4. Modify your query in the lab_04_02.sql to add a column that subtracts the old salary
from the new salary. Label the column Increase. Save the contents of the file as
lab_04_04.sql. Run the revised query.]

SELECT employee_id,
       last_name,
       salary,
       ROUND((salary * 115.5 / 100)) "New Salary",
       ROUND((salary * 115.5 / 100)) - salary "Increase"
FROM   employees;

/*Exercício nº 5*/

[5. Perform the following tasks:
a. Write a query that displays the last name (with the first letter in uppercase and all the
other letters in lowercase) and the length of the last name for all employees whose
name starts with the letters “J,” “A,” or “M.” Give each column an appropriate label. Sort
the results by the employees’ last names.]

--a)

SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  last_name LIKE 'J%'
OR     last_name LIKE 'A%'
OR     last_name LIKE 'M%'
ORDER  BY last_name;

--b) 

[b. Rewrite the query so that the user is prompted to enter a letter that the last name starts
with. For example, if the user enters “H” (capitalized) when prompted for a letter, the
output should show all employees whose last name starts with the letter “H.”]

SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  last_name LIKE ('&name%')
ORDER  BY last_name;

--c) 

[c. Modify the query such that the case of the letter that is entered does not affect the
output. The entered letter must be capitalized before being processed by the SELECT
query.]

SELECT INITCAP(last_name) "Name",
       LENGTH(last_name) "Length"
FROM   employees
WHERE  UPPER (last_name) LIKE UPPER('&name_letter%')
ORDER  BY last_name;

/*Exercício nº 6*/

[6. The HR department wants to find the duration of employment for each employee. For each
employee, display the last name and calculate the number of months between today and
the date on which the employee was hired. Label the column as MONTHS_WORKED. Order
your results by the number of months employed. The number of months must be rounded
to the closest whole number.]

SELECT last_name,
       ROUND(months_between(SYSDATE, hire_date)) months_worked
FROM   employees
ORDER  BY 2;

/*Exercício nº 7*/

[7. Create a query to display the last name and salary for all employees. Format the salary to
be 15 characters long, left-padded with the $ symbol. Label the column SALARY.]

SELECT last_name,
       LPAD(salary, 15, '$') AS salary
FROM   employees;

/*Exercício nº 8*/

[8. Create a query that displays the first eight characters of the employees’ last names, and
indicates the amounts of their salaries with asterisks. Each asterisk signifies a thousand
dollars. Sort the data in descending order of salary. Label the column
EMPLOYEES_AND_THEIR_SALARIES.]

SELECT RPAD(last_name, 8, ' ') || RPAD(' ', TRUNC(salary / 1000) + 1, '*') AS employees_and_their_salaries
FROM   employees
ORDER  BY salary DESC;

/*Exercício nº 9*/

[9. Create a query to display the last name and the number of weeks employed for all
employees in department 90. Label the number of weeks column as TENURE. Truncate the
number of weeks value to 0 decimal places. Show the records in descending order of the
employee’s tenure.]

SELECT last_name,
       TRUNC((SYSDATE - hire_date)/7) AS tenure
FROM   employees
WHERE  department_id = 90
ORDER  BY 2 DESC;
