/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 24/11/2022
-- Tópico: 3
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a) 

CREATE OR REPLACE PACKAGE job_pkg IS

  PROCEDURE add_job(p_id    IN jobs.job_id%TYPE,
                    p_title IN jobs.job_title%TYPE);
                    
  PROCEDURE upd_job(p_id    IN jobs.job_id%TYPE,
                    p_title IN jobs.job_title%TYPE);
                    
  PROCEDURE del_job(p_id IN jobs.job_id%TYPE);
  
  FUNCTION get_job(p_job_id jobs.job_id%TYPE) RETURN VARCHAR2;
  
END job_pkg;

--b)

CREATE OR REPLACE PACKAGE BODY job_pkg IS

  PROCEDURE add_job(p_id    IN jobs.job_id%TYPE,
                    p_title IN jobs.job_title%TYPE) IS
  BEGIN
    INSERT INTO jobs
      (job_id,
       job_title)
    VALUES
      (UPPER(p_id),
       p_title);
  END add_job;

  PROCEDURE upd_job(p_id    IN jobs.job_id%TYPE,
                    p_title IN jobs.job_title%TYPE) IS
  BEGIN
    UPDATE jobs
    SET    job_title = p_title
    WHERE  job_id = UPPER(p_id);
  
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20202, 'No job updated.');
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END upd_job;

  PROCEDURE del_job(p_id IN jobs.job_id%TYPE) IS
  BEGIN
    DELETE jobs
    WHERE  job_id = UPPER(p_id);
  
    IF SQL%NOTFOUND THEN
      RAISE_APPLICATION_ERROR(-20201, 'No jobs deleted.');
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END del_job;

  FUNCTION get_job(p_job_id jobs.job_id%TYPE) RETURN VARCHAR2 IS
    v_job_title jobs.job_title%TYPE;
  BEGIN
    SELECT job_title
    INTO   v_job_title
    FROM   jobs
    WHERE  job_id = p_job_id;
  
    RETURN v_job_title;
  END get_job;

END job_pkg;

--d) 

EXECUTE job_pkg.add_job('IT_SYSAN', 'SYSTEMS ANALYST');

--e) 

SELECT * FROM jobs WHERE job_id = 'IT_SYSAN';

/*Exercício nº2*/

--a) 

-- package specification 

CREATE OR REPLACE PACKAGE emp_pkg IS

  PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                         p_last_name  employees.last_name%TYPE,
                         p_email      employees.email%TYPE,
                         p_job        employees.job_id%TYPE DEFAULT 'SA_REP',
                         p_mgr        employees.manager_id%TYPE DEFAULT 145,
                         p_sal        employees.salary%TYPE DEFAULT 1000,
                         p_comm       employees.commission_pct%TYPE DEFAULT 0,
                         p_deptid     employees.department_id%TYPE DEFAULT 30);
  
  PROCEDURE get_employee(p_id     IN employees.employee_id%TYPE,
                         p_salary OUT employees.salary%TYPE,
                         p_job_id OUT employees.job_id%TYPE);

END emp_pkg;

--package body

CREATE OR REPLACE PACKAGE BODY emp_pkg IS

  FUNCTION valid_deptid(p_deptid employees.department_id%TYPE) RETURN BOOLEAN IS
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

  PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                         p_last_name  employees.last_name%TYPE,
                         p_email      employees.email%TYPE,
                         p_job        employees.job_id%TYPE DEFAULT 'SA_REP',
                         p_mgr        employees.manager_id%TYPE DEFAULT 145,
                         p_sal        employees.salary%TYPE DEFAULT 1000,
                         p_comm       employees.commission_pct%TYPE DEFAULT 0,
                         p_deptid     employees.department_id%TYPE DEFAULT 30) IS
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
    ELSE
      RAISE_APPLICATION_ERROR(-20200,
                              'The informed department ID is invalid');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END add_employee;

  PROCEDURE get_employee(p_id     IN employees.employee_id%TYPE,
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

END emp_pkg;

--b)

EXECUTE emp_pkg.add_employee('Jane', 'Harris' , 'JAHARRIS', p_deptid => 15);

--c)

EXECUTE emp_pkg.add_employee('David', 'Smith' , 'DASMITH', p_deptid => 80);

--d)

SELECT * FROM EMPLOYEES WHERE email = 'DASMITH';


