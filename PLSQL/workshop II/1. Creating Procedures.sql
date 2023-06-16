/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL1 
-- Data: 22/11/2022
-- Tópico: 1
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a)

CREATE OR REPLACE PROCEDURE add_job(p_id    IN jobs.job_id%TYPE,
                                    p_title IN jobs.job_title%TYPE) IS
BEGIN
  INSERT INTO jobs
    (job_id,
     job_title)
  VALUES
    (UPPER(p_id),
     p_title);
END add_job;

--b) 

EXECUTE add_job(p_id => 'IT_DBA', p_title => 'Database Administrator');

SELECT * FROM jobs;

--c) Não é possível adicionar pois o uso de 'ST_MAN' viola a constraint
--   de primary key da tabela, conforme o erro ORA-00001: unique constraint violated.

/*Exercício nº2*/

--a)

CREATE OR REPLACE PROCEDURE upd_job(p_id    IN jobs.job_id%TYPE,
                                    p_title IN jobs.job_title%TYPE) IS
  e_no_id EXCEPTION;
BEGIN
  UPDATE jobs
  SET    job_title = p_title
  WHERE  job_id = UPPER(p_id);

  IF SQL%NOTFOUND THEN
    RAISE e_no_id;
  END IF;

EXCEPTION
  WHEN e_no_id THEN
    DBMS_OUTPUT.PUT_LINE('No job updated.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INTERNAL ERROR');
END upd_job;
   
--b)

EXECUTE upd_job(p_id => 'IT_DBA', p_title => 'Data Administrator');

SELECT * FROM jobs;

--c) Testando na Command Window
/*   SQL> EXECUTE upd_job('IT_WEB','Web Master');
     No job updated.
     PL/SQL procedure successfully completed   */

/*Exercício nº3*/

--a)

CREATE OR REPLACE PROCEDURE del_job(p_id IN jobs.job_id%TYPE) IS
  e_no_job EXCEPTION;
BEGIN
  DELETE jobs
  WHERE  job_id = UPPER(p_id);

  IF SQL%NOTFOUND THEN
    RAISE e_no_job;
  END IF;

EXCEPTION
  WHEN e_no_job THEN
    DBMS_OUTPUT.PUT_LINE('No jobs deleted.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('INTERNAL ERROR');
END del_job;

--b)

EXECUTE del_job('IT_DBA');

SELECT * FROM jobs;

--c) Testando na Command Window
/*   SQL> EXECUTE del_job('it_web');
     No jobs deleted.
     PL/SQL procedure successfully completed   */
     
/*Exercício nº4*/

--a) 

CREATE OR REPLACE PROCEDURE get_employee(p_id     IN employees.employee_id%TYPE,
                                         p_salary OUT employees.salary%TYPE,
                                         p_job_id OUT employees.job_id%TYPE) IS
BEGIN
  SELECT salary,
         job_id
  INTO   p_salary,
         p_job_id
  FROM   employees
  WHERE  employee_id = p_id;
END get_employee;

--b)

VARIABLE b_salary NUMBER;
VARIABLE b_job_id VARCHAR2(20);

EXECUTE get_employee(120, :b_salary, :b_job_id);

--c) Ocorre o erro "NO_DATA_FOUND" pois não existe um employee_id associado 
--   a esse valor.


