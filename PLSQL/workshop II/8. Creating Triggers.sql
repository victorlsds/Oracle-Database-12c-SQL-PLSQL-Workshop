/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 05/12/2022
-- Tópico: 8
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a) 

CREATE OR REPLACE PROCEDURE check_salary(p_jobid  jobs.job_id%TYPE,
                                         p_salary NUMBER) IS
  v_minsal jobs.min_salary%TYPE;
  v_maxsal jobs.max_salary%TYPE;
BEGIN
  SELECT min_salary,
         max_salary
  INTO   v_minsal,
         v_maxsal
  FROM   jobs
  WHERE  job_id = UPPER(p_jobid);
  IF p_salary NOT BETWEEN v_minsal AND v_maxsal THEN
    RAISE_APPLICATION_ERROR(-20210,
                            'Invalid salary R$' ||
                            TO_CHAR(p_salary, 'fm99999D00') ||
                            '. Salaries for job ' || UPPER(p_jobid) ||
                            ' must be betweeen R$' ||
                            TO_CHAR(v_minsal, 'fm99999D00') || ' and R$' ||
                            TO_CHAR(v_maxsal, 'fm99999D00') || '.');
  END IF;
END check_salary;

--b)

CREATE OR REPLACE TRIGGER check_salary_trg
  BEFORE INSERT OR UPDATE OF job_id, salary ON employees
  FOR EACH ROW
BEGIN
  check_salary(:NEW.job_id, :NEW.salary);
END check_salary_trg;


/*Exercício nº2*/

--a) 

EXECUTE emp_pkg.add_employee('Eleanor', 'Beh', 30);

-- ORA-20210: Invalid salary R$1000.00. Salaries for job SA_REP must be betweeen R$6000.00 and R$12008.00.

/* O erro apresentado é chamado na verificação do trigger 'CHECK_SALARY_TRG', que confirma que o 
   valor padrão de salario '1000' para o valor padrão de job_id 'SA_REP' esta abaixo da regra 
   da tabela */ 
   
--b)
 --i)
UPDATE employees
SET salary = 2000
WHERE employee_id = 115;

-- ORA-20210: Invalid salary R$2000,00. Salaries for job PU_CLERK must be betweeen R$2500,00 and R$5500,00.

/* O mesmo erro de validação de salário por job_id da questão anterior se repete, causando o lançamento do 
   erro. */

 --ii)   
UPDATE employees
SET job_id = 'HR_REP'
WHERE employee_id = 115;

-- ORA-20210: Invalid salary R$3100,00. Salaries for job HR_REP must be betweeen R$4000,00 and R$9000,00.

/* Aqui o erro é semelhante, devido ao acionamento do trigger, porém o salário é incompatível para o 
   novo cargo que será atualizado. */ 
   
--c)

UPDATE employees
SET salary = 2800
WHERE employee_id = 115;

-- 1 row updated

/* A declaração roda normalmente pois o salário está entre os R$2500,00 e R$5500,00. */


/*Exercício nº3*/

--a)

CREATE OR REPLACE TRIGGER check_salary_trg
  BEFORE INSERT OR UPDATE OF job_id, salary ON employees
  FOR EACH ROW
  WHEN (NEW.job_id <> NVL (OLD.job_id, 'NULL') OR
        NEW.salary <> NVL (OLD.salary, 0))
BEGIN
  check_salary(:NEW.job_id, :NEW.salary);
END check_salary_trg;

--b)

EXECUTE  emp_pkg.add_employee('Eleanor', 'Beh', 'EBEH', p_job => 'IT_PROG', p_sal => 5000); 

-- PL/SQL procedure successfully completed

--c)

UPDATE employees
SET salary = salary + 2000
WHERE job_id = 'IT_PROG';

-- ORA-20210: Invalid salary R$11000,00. Salaries for job IT_PROG must be betweeen R$4000,00 and R$10000,00.

/* Devido a este caso onde o salário + 2000 supera o valor de verificação do trigger, toda declaração sofre um 
   ROLLBACK e nenhum funcionário tem seu salário alterado. */

--d)

UPDATE employees
SET    salary = 9000
WHERE  employee_id = (SELECT employee_id
                      FROM   employees
                      WHERE  first_name = 'Eleanor'
                      AND    last_name = 'Beh');

-- 1 row updated.                      

--e)

UPDATE employees
SET    job_id = 'ST_MAN'
WHERE  employee_id = (SELECT employee_id
                      FROM   employees
                      WHERE  first_name = 'Eleanor'
                      AND    last_name = 'Beh');
                      
-- ORA-20210: Invalid salary R$9000,00. Salaries for job ST_MAN must be betweeen R$5500,00 and R$8500,00.


/*Exercício nº4*/

--a)

CREATE OR REPLACE TRIGGER delete_emp_trg
  BEFORE DELETE ON employees
BEGIN
  IF (TO_CHAR(SYSDATE, 'DY') NOT IN ('SAT', 'SUN')) AND
     (TO_CHAR(SYSDATE, 'HH24') BETWEEN 9 AND 18) THEN
    RAISE_APPLICATION_ERROR(-20500,
                            'You can not delete over EMPLOYEES table during normal business hours.');
  END IF;
END delete_emp_trg;


--b)

DELETE FROM employees
WHERE job_id = 'SA_REP'
AND department_id IS NULL; 

-- ORA-20500: You can only delete over EMPLOYEES table only during normal business hours.

CREATE OR REPLACE TRIGGER employee_dept_fk_trg
BEFORE UPDATE OF department_id ON employees 
FOR EACH ROW
BEGIN
INSERT INTO departments VALUES(:new.department_id,
'Dept '||:new.department_id, NULL, NULL);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
NULL; -- mask exception if department exists
END; 
/

