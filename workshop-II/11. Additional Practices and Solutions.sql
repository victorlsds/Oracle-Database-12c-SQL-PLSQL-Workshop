/******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 27/10/2022
-- Tópico: Adicionais
-- Instrutor: Gustavo
****************************************************************************/

/*Exercício nº 1*/

-- Criando a tabela SPECIAL_SAL:

CREATE TABLE special_sal
       (employee_id     NUMBER(6)
                        CONSTRAINT spec_sal_id_pk PRIMARY KEY,
        salary          NUMBER(8,2));
        
-- Criando a tabela SAL_HISTORY:

CREATE TABLE sal_history
       (employee_id     NUMBER(6)
                        CONSTRAINT sal_hist_id_pk PRIMARY KEY,
        hire_date       DATE,
        salary          NUMBER(8,2));
        
-- Criando a tabela MGR_HISTORY:

CREATE TABLE mgr_history
       (employee_id     NUMBER(6)
                        CONSTRAINT mgr_his_id_pk PRIMARY KEY,
        manager_id      NUMBER(6),
        salary          NUMBER(8,2));

-- Populando a tabela:

INSERT ALL
WHEN salary < 5000 THEN
  INTO special_sal VALUES (employee_id, salary)
ELSE
  INTO sal_history VALUES (employee_id, hire_date, salary)
  INTO mgr_history VALUES (employee_id, manager_id, salary)
SELECT employee_id,
       salary,
       hire_date,
       manager_id
FROM   employees
WHERE  employee_id >= 200;

COMMIT;

/*Exercício nº 2*/

SELECT *
FROM   especial_sal;

SELECT *
FROM   sal_history;

SELECT *
FROM   mgr_history;

/*Exercício nº 3*/

CREATE TABLE locations_named_index(deptno NUMBER(4) PRIMARY KEY USING
                                   INDEX(CREATE INDEX locations_pk_idx ON
                                         locations_named_index(deptno)),
                                   dname VARCHAR2(30));

/*Exercício nº 4*/

SELECT index_name,
       table_name
FROM   user_indexes
WHERE  LOWER(table_name) = 'locations_named_index';

/*Exercício nº 5*/

ALTER SESSION SET NSL_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

/*Exercício nº 6*/

--a) 

SELECT TZ_OFFSET('AUSTRALIA/SYDNEY')
FROM   dual;

SELECT TZ_OFFSET('CHILE/EASTERLAND')
FROM   dual;

--b)

SELECT TZ_OFFSET('AUSTRALIA/SYDNEY')
FROM   DUAL;

ALTER SESSION SET TIME_ZONE = '+11:00';

--c)

SELECT SYSDATE,
       CURRENT_DATE,
       CURRENT_TIMESTAMP,
       LOCALTIMESTAMP
FROM   DUAL;

--d)

SELECT TZ_OFFSET('CHILE/EASTERISLAND')
FROM   DUAL;

ALTER SESSION SET TIME_ZONE = '-5:00';

--e)

SELECT SYSDATE,
       CURRENT_DATE,
       CURRENT_TIMESTAMP,
       LOCALTIMESTAMP
FROM   DUAL;

--f)

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

/*Exercício nº 7*/

SELECT last_name,
       EXTRACT(MONTH FROM hire_date),
       hire_date
FROM   employees
WHERE  EXTRACT(MONTH FROM hire_date) = 1;

/*Exercício nº 8*/

SELECT out_tab.last_name,
       out_tab.salary
FROM   employees out_tab
WHERE  3 > (SELECT COUNT(*)
            FROM   employees inn_tab
            WHERE  inn_tab.salary > out_tab.salary);

/*Exercício nº 9*/

-- pergunta 

SELECT otr.employee_id,
       otr.last_name
FROM   employees otr
WHERE  (otr.department_id) IN
       (SELECT department_id
        FROM   departments d,
               locations   l
        WHERE  d.location_id = l.location_id
        AND    LOWER(l.state_province) = 'california');

-- versão correta:

SELECT e.employee_id,
       e.last_name
FROM   employees e
WHERE  ((SELECT d.location_id
         FROM   departments d
         WHERE  e.department_id = d.department_id) IN
       (SELECT location_id
         FROM   locations l
         WHERE  LOWER(l.state_province) = 'california'));

/*Exercício nº 10*/

DELETE FROM job_history jh
WHERE  employee_id = (SELECT employee_id
                      FROM   employees e
                      WHERE  jh.employee_id = e.employee_id
                      AND    START_DATE =
                             (SELECT MIN(start_date)
                               FROM   job_history JH
                               WHERE  jh.employee_id = e.employee_id)
                      AND    3 > (SELECT COUNT(*)
                                  FROM   job_history JH
                                  WHERE  jh.employee_id = e.employee_id
                                  GROUP  BY EMPLOYEE_ID
                                  HAVING COUNT(*) >= 2));
SELECT *
FROM   JOB_HISTORY;

/*Exercício nº 11*/

ROLLBACK;

/*Exercício nº 12*/

WITH max_sal_calc AS
 (SELECT job_title,
         MAX(salary) AS max_salary
  FROM   employees,
         jobs
  WHERE  employees.job_id = jobs.job_id
  GROUP  BY job_title)
SELECT job_title,
       max_salary
FROM   max_sal_calc
WHERE  max_salary > (SELECT MAX(max_salary) * 1 / 2
                     FROM   max_sal_calc)
ORDER  BY max_salary DESC;
