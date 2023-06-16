/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL1 
-- Data: 06/10/2022
-- Tópico: 9
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº 1*/

[1. The HR department needs a list of department IDs for departments that do not contain the
job ID ST_CLERK. Use the set operators to create this report.]

SELECT department_id
FROM   departments
MINUS
SELECT department_id
FROM   employees
WHERE  UPPER(job_id) = UPPER('ST_CLERK');


/*Exercício nº 2*/

[2. The HR department needs a list of countries that have no departments located in them.
Display the country IDs and the names of the countries. Use the set operators to create this
report.]

SELECT country_id,
       country_name
FROM   countries
MINUS
SELECT country_id,
       ce.country_name
FROM   locations l
JOIN   countries ce
USING  (country_id)
JOIN   departments d
ON     (l.location_id = d.location_id);


/*Exercício nº 3*/

[3. Produce a list of jobs for departments 10, 50, and 20, in that order. Display the job ID and
department ID by using the set operators.]

SELECT job_id,
       department_id
FROM employees 
WHERE department_id = 10
UNION
(SELECT job_id,
       department_id
FROM employees 
WHERE department_id = 50)
UNION ALL
(SELECT job_id,
       department_id
FROM employees 
WHERE department_id = 20);
