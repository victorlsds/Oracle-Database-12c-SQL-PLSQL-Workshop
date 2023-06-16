/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 06/12/2022
-- Tópico: 9
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a) 

CREATE OR REPLACE PACKAGE emp_pkg IS

  ...

  PROCEDURE set_salary(p_jobid jobs.job_id%TYPE,
                       p_new_minsal NUMBER);

END emp_pkg;

--b) 

CREATE OR REPLACE TRIGGER upd_minsalary_trg
  AFTER UPDATE OF min_salary ON jobs
  FOR EACH ROW
BEGIN
  emp_pkg.set_salary(:NEW.job_id, :NEW.min_salary);
END upd_minsalary_trg;

--c)

SELECT employee_id,
       last_name,
       job_id,
       salary,
       MIN(salary) OVER(PARTITION BY department_id) AS "Min Salary"
FROM   employees E
WHERE  job_id = 'IT_PROG';

  --ou
  
SELECT e.employee_id,
       e.last_name,
       e.job_id,
       e.salary,
       MIN(a.salary)
FROM   employees e,
       employees a
WHERE  e.department_id = a.department_id
AND    e.job_id = 'IT_PROG'
GROUP  BY e.department_id,
          e.employee_id,
          e.last_name,
          e.job_id,
          e.salary;

UPDATE jobs
SET min_salary = min_salary + 1000
WHERE job_id = 'IT_PROG';

/* Temos um erro do tipo "mutating table", isso ocorre pois quando atualizamos
   um valor na tabela, o trigger chamado para atualizar o salários que são 
   menores que o atual entra em conflito com a primeira atualização feita. */
   
   
/*Exercício nº2*/

--a)

CREATE OR REPLACE PACKAGE jobs_pkg IS

  PROCEDURE initialize;
  FUNCTION get_minsalary(p_jobid VARCHAR2) RETURN NUMBER;
  FUNCTION get_maxsalary(p_jobid VARCHAR2) RETURN NUMBER;
  PROCEDURE set_minsalary(p_jobid      VARCHAR2,
                          p_min_salary NUMBER);
  PROCEDURE set_maxsalary(p_jobid      VARCHAR2,
                          p_max_salary NUMBER);
END jobs_pkg;

--b)

CREATE OR REPLACE PACKAGE BODY jobs_pkg IS

  TYPE jobs_tab_type IS TABLE OF jobs%ROWTYPE INDEX BY jobs.job_id%TYPE;
  jobstab jobs_tab_type;

  PROCEDURE initialize IS
    CURSOR c_jobs IS
      SELECT *
      FROM   jobs;
  BEGIN
    FOR rec IN c_jobs
    LOOP
      jobstab(rec.job_id) := rec;
    END LOOP;
  END initialize;

  FUNCTION get_minsalary(p_jobid VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN jobstab(p_jobid).min_salary;
  END get_minsalary;

  FUNCTION get_maxsalary(p_jobid VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN jobstab(p_jobid).max_salary;
  END get_maxsalary;

  PROCEDURE set_minsalary(p_jobid      VARCHAR2,
                          p_min_salary NUMBER) IS
  BEGIN
    jobstab(p_jobid).min_salary := p_min_salary;
  END set_minsalary;

  PROCEDURE set_maxsalary(p_jobid      VARCHAR2,
                          p_max_salary NUMBER) IS
  BEGIN
    jobstab(p_jobid).max_salary := p_max_salary;
  END set_maxsalary;

END jobs_pkg;


--c)

CREATE OR REPLACE PROCEDURE check_salary(p_jobid  jobs.job_id%TYPE,
                                         p_salary NUMBER) IS
  v_minsal jobs.min_salary%TYPE;
  v_maxsal jobs.max_salary%TYPE;
  e_invalidsal EXCEPTION;
BEGIN
--new--
  v_minsal := jobs_pkg.get_minsalary(UPPER(p_jobid));
  v_maxsal := jobs_pkg.get_maxsalary(UPPER(p_jobid));
--new--  
  IF p_salary NOT BETWEEN v_minsal AND v_maxsal THEN
    RAISE e_invalidsal;
  END IF;
  ...
END check_salary;

--d) 

CREATE OR REPLACE TRIGGER init_jobpkg_trg
  BEFORE INSERT OR UPDATE ON jobs
CALL jobs_pkg.initialize

--e)

UPDATE jobs
SET    min_salary = min_salary + 1000
WHERE  job_id = 'IT_PROG';

/* EMPLOYEES QUE TIVERAM SEU SALÁRIO ATUALIZADO 

EMPLOYEE_ID LAST_NAME                 JOB_ID      SALARY
----------- ------------------------- ------- ----------
        107 Lorentz                   IT_PROG    5000,00
        106 Pataballa                 IT_PROG    5000,00
        105 Austin                    IT_PROG    5000,00 */
        
        
/*Exercício nº3*/        

--a)

EXECUTE emp_pkg.add_employee('Steve', 'Morse', 'SMORSE', p_sal => 6500);

/* Aqui ocorre um erro devido a trigger check_sal tentar validar se a variável 
   de salário está entre o valor mínimo e máximo, porém essas variáveis não 
   estão inicializadas ainda, resultando em uma comparação com NULL e um erro. */
   
--b)

CREATE TRIGGER employee_initjobs_trg
BEFORE INSERT OR UPDATE OF job_id, salary ON employees
CALL jobs_pkg.initialize 

--c) Repetindo o processo de adicionar o employee temos a adição dele como resultado

SELECT employee_id,
       first_name,
       last_name,
       salary,
       job_id,
       department_id
FROM   employees
WHERE  last_name = 'Morse';

/*EMPLOYEE_ID FIRST_NAME           LAST_NAME                     SALARY JOB_ID     DEPARTMENT_ID
  ----------- -------------------- ------------------------- ---------- ---------- -------------
          232 Steve                Morse                        6500,00 SA_REP                30  */
