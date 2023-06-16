/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 01/12/2022
-- Tópico: 7
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a)

CREATE OR REPLACE PACKAGE emp_pkg IS

 --ii)
  TYPE deptab_type IS TABLE OF employees%ROWTYPE;
  ...
 
 --i)

  PROCEDURE get_employees(p_dept_id employees.department_id%TYPE);
  ...
  
END emp_pkg;

--b)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  ...
  
 --i)
  v_deptab deptab_type;
  
  ...

 --ii)
 
   PROCEDURE get_employees(p_dept_id employees.department_id%TYPE) IS
  BEGIN
    SELECT *
    BULK   COLLECT
    INTO   v_deptab
    FROM   employees e
    WHERE  department_id = p_dept_id;
  END get_employees;
  
  ...
   
END emp_pkg;

--c)

PROCEDURE show_employees IS
BEGIN
  IF v_deptab.COUNT < 1 THEN
    RETURN;
  END IF;
  FOR i IN 1 .. v_deptab.COUNT
  LOOP
    print_employee(v_deptab(i));
  END LOOP;
EXCEPTION
  WHEN COLLECTION_IS_NULL THEN
    RAISE_APPLICATION_ERROR(-20208, 'You need to select the department_id first!');
  
END show_employees;

--d)

EXECUTE emp_pkg.get_employees(30);
EXECUTE emp_pkg.show_employees;

EXECUTE emp_pkg.get_employees(60);
EXECUTE emp_pkg.show_employees;


/*Exercício nº2*/

--b)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS

  ...
  
  PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                         p_last_name  employees.last_name%TYPE,
                         p_email      employees.email%TYPE,
                         p_job        employees.job_id%TYPE DEFAULT 'SA_REP',
                         p_mgr        employees.manager_id%TYPE DEFAULT 145,
                         p_sal        employees.salary%TYPE DEFAULT 1000,
                         p_comm       employees.commission_pct%TYPE DEFAULT 0,
                         p_deptid     employees.department_id%TYPE DEFAULT 30) IS
    e_invalid_deptid EXCEPTION; 
    
    PROCEDURE audit_newemp IS PRAGMA AUTONOMOUS_TRANSACTION;
      user_id VARCHAR2(100) := USER; 
    BEGIN 
      INSERT INTO log_newemp (entry_id, user_id, log_time, name)
      VALUES (log_newemp_seq.NEXTVAL, user_id, SYSDATE, p_first_name||' '||p_last_name);
      COMMIT;
    END audit_newemp; 
    
  ...
  
  END add_employee;
  
--c)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS

  ...
    
  BEGIN
    IF valid_deptid(p_deptid) THEN
      audit_newemp;
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
      ...
  END add_employee;
  
--d)

EXECUTE emp_pkg.add_employee('Max', 'Smart', 'MSMART', p_deptid => 20);
EXECUTE emp_pkg.add_employee('Clark', 'Kent', 'CKENT', p_deptid => 10);

-- As duas procedures rodam sem erros

--e)

SELECT * 
FROM log_newemp;

-- Apenas duas linhas de log

--f)

/* Após o ROLLBACK, os dois employees que foram adicionados são removidos
   porém os logs não são afetadas devido o uso do 
   PRAGMA AUTONOMOUS_TRANSACTION */
