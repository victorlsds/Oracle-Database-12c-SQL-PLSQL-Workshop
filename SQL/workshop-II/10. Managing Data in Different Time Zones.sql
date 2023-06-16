/******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 27/10/2022
-- Tópico: 10
-- Instrutor: Gustavo
****************************************************************************/

/*1. Alter the session to set NLS_DATE_FORMAT to DD-MON-YYYY HH24:MI:SS.*/

ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

/*2. Write queries to display the time zone offsets (TZ_OFFSET) for the following time zones*/

--a)

SELECT TZ_OFFSET('US/PACIFIC-NEW')
FROM DUAL;

SELECT TZ_OFFSET('SINGAPORE')
FROM DUAL;

SELECT TZ_OFFSET('EGYPT')
FROM DUAL;

--b)

ALTER SESSION
SET TIME_ZONE = '-7:00';

ALTER SESSION
SET TIME_ZONE = 'US/PACIFIC-NEW';

--c)

SELECT CURRENT_DATE,
       CURRENT_TIMESTAMP,
       LOCALTIMESTAMP
FROM dual;

--d)

ALTER SESSION
SET TIME_ZONE = '+8:00';

ALTER SESSION
SET TIME_ZONE = 'SINGAPORE';

--e)

SELECT CURRENT_DATE,
       CURRENT_TIMESTAMP,
       LOCALTIMESTAMP
FROM dual;

/*3. Write a query to display DBTIMEZONE and SESSIONTIMEZONE.*/

SELECT DBTIMEZONE, 
       SESSIONTIMEZONE
FROM dual;

/*4. Write a query to extract the YEAR from the HIRE_DATE column of the EMPLOYEES table for
those employees who work in department 80.*/

SELECT last_name,
       EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id = 80;

/*5. Ater the session to set NLS_DATE_FORMAT to DD-MON-YYYY.*/

ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

/*6. Examine and run the lab_10_06.sql script to create the SAMPLE_DATES table and
populate it.*/

CREATE TABLE sample_dates
       (date_col    DATE);
       
INSERT INTO sample_dates
VALUES (SYSDATE);

COMMIT;

--a) Select from the table and view the data.

SELECT * 
FROM sample_dates;

--b) Modify the data type of the DATE_COL column and change it to TIMESTAMP. Select from the table to view the data.

ALTER TABLE sample_dates
MODIFY (date_col TIMESTAMP(9));

SELECT * FROM sample_dates;

--c)

ALTER TABLE sample_dates
MODIFY (date_col TIMESTAMP WITH TIME ZONE);

/*7. Create a query to retrieve last names from the EMPLOYEES table and calculate the review
status. If the year hired was 2008, display Needs Review for the review status; otherwise,
display not this year! Name the review status column Review. Sort the results by the
Robert Banda*/

SELECT last_name,
       (CASE EXTRACT(YEAR FROM hire_date) WHEN 2008 THEN 'Needs review'
            ELSE 'not this year!' END) AS "Review"
FROM employees
ORDER BY hire_date;

/*8. Create a query to print the last names and the number of years of service for each
employee. If the employee has been employed for five or more years, print s years of
service. Ifthe employee has been employed for 10 or more years, print 10 years of
service. Ifthe employee has been employed for 15 or more years, print 15 years of
service. If none of these conditions matches, print maybe next yearl Sort the results
by the HIRE_DATE column. Use the EMPLOYEES table.*/

SELECT last_name, 
       hire_date,
       SYSDATE,
       (CASE WHEN (SYSDATE - TO_YMINTERVAL('15-0')) >= hire_date 
             THEN '15 years of service'
             WHEN (SYSDATE - TO_YMINTERVAL('10-0')) >= hire_date 
             THEN '10 years of service'
             WHEN (SYSDATE - TO_YMINTERVAL('5-0')) >= hire_date 
             THEN '5 years of service'
               ELSE 'maybe next year!' END) AS "Awards"
FROM employees;
