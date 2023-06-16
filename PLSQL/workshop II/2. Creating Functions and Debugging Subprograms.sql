/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL1 
-- Data: 23/11/2022
-- Tópico: 2
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a)

CREATE OR REPLACE FUNCTION get_job(p_job_id jobs.job_id%TYPE)
  RETURN VARCHAR2 IS
  v_job_title jobs.job_title%TYPE;
BEGIN
  SELECT job_title
  INTO   v_job_title
  FROM   jobs
  WHERE  job_id = p_job_id;

  RETURN v_job_title;
END get_job;

--b) 

VARIABLE b_title VARCHAR2(35);
EXECUTE :b_title := get_job('SA_REP');

/*Exercício nº2*/

--a)

CREATE OR REPLACE FUNCTION get_annual_comp(p_salary         employees.salary%TYPE,
                                           p_commission_pct employees.commission_pct%TYPE)
  RETURN NUMBER IS
BEGIN
  IF p_salary IS NULL THEN
    RETURN 0;
  ELSIF p_commission_pct IS NULL THEN
    RETURN(p_salary * 12);
  ELSE
    RETURN(p_salary * 12) +(p_commission_pct + p_salary + 12);
  END IF;
END get_annual_comp;

--b)

SELECT employee_id,
       last_name,
       get_annual_comp(salary, commission_pct) AS "Annual Compesation"
FROM employees
WHERE department_id = 30;

/*Exercício nº3*/

--a) 

CREATE OR REPLACE FUNCTION valid_deptid(p_deptid employees.department_id%TYPE)
  RETURN BOOLEAN IS
  v_valid_deptid departments.department_id%TYPE;
BEGIN
  SELECT department_id
  INTO   v_valid_deptid
  FROM   departments
  WHERE  department_id = p_deptid;
  RETURN TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END valid_deptid;

--b)

CREATE OR REPLACE PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                                         p_last_name  employees.last_name%TYPE,
                                         p_email      employees.email%TYPE,
                                         p_job        employees.job_id%TYPE DEFAULT 'SA_REP',
                                         p_mgr        employees.manager_id%TYPE DEFAULT 145,
                                         p_sal        employees.salary%TYPE DEFAULT 1000,
                                         p_comm       employees.commission_pct%TYPE DEFAULT 0,
                                         p_deptid     employees.department_id%TYPE DEFAULT 30) IS
  e_invalid_deptid EXCEPTION;
BEGIN
  IF valid_deptid(p_deptid) THEN
    INSERT INTO employees
      (employee_id,
       first_name,
       last_name,
       email,
       hire_date,
       job_id,
       manager_id,
       salary,
       commission_pct,
       department_id)
    VALUES
      (employees_seq.NEXTVAL,
       p_first_name,
       p_last_name,
       p_email,
       TRUNC(SYSDATE),
       p_job,
       p_mgr,
       p_sal,
       p_comm,
       p_deptid);
  COMMIT;
  ELSE
    RAISE e_invalid_deptid;
  END IF;
EXCEPTION
  WHEN e_invalid_deptid THEN
    DBMS_OUTPUT.PUT_LINE('The informed department ID is invalid');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Internal Code Error');
END add_employee;

--c) 

EXECUTE add_employee(p_first_name => 'Jane', p_last_name => 'Harris', p_email => 'JAHARRIS', p_deptid => 15);

-- Um erro é informado, pois a função verifica que o department_id é inválido

--d) 

EXECUTE add_employee(p_first_name => 'Joe', p_last_name => 'Harris', p_email => 'JAHARRIS', p_deptid => 80);

-- A procedure é executada com sucesso, pois o departmento é válido
