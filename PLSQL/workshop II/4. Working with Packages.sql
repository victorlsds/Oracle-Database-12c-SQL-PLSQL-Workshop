/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 25/11/2022
-- Tópico: 4
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--atualização em cima do módulo 3, exercício 2

CREATE OR REPLACE PACKAGE emp_pkg IS
  ...
--a)
  PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                         p_last_name  employees.last_name%TYPE,
                         p_deptid     employees.department_id%TYPE DEFAULT 30);
--b)
  PROCEDURE get_employee(p_id     IN employees.employee_id%TYPE,
                         p_salary OUT employees.salary%TYPE,
                         p_job_id OUT employees.job_id%TYPE);

END emp_pkg;


--c)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  ...
  
  PROCEDURE add_employee(p_first_name employees.first_name%TYPE,
                         p_last_name  employees.last_name%TYPE,
                         p_deptid     employees.department_id%TYPE DEFAULT 30) IS
    p_email employees.email%TYPE;
  BEGIN
    p_email := UPPER(SUBSTR(p_first_name, 1, 1) ||
                     SUBSTR(p_last_name, 1, 7));
    add_employee(p_first_name, p_last_name, p_email, p_deptid => p_deptid);
  END;

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

--d)

EXECUTE emp_pkg.add_employee('Samuel', 'Joplin' , p_deptid => 30);

--e)

SELECT * 
FROM employees 
WHERE department_id = 30;

/*Exercício nº2*/

--a)

CREATE OR REPLACE PACKAGE emp_pkg IS
  ...
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE;

  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE;

END emp_pkg;


--c)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  ...
  
  FUNCTION get_employee(p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE IS
    rec_employee employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   rec_employee
    FROM   employees
    WHERE  employee_id = p_emp_id;
  
    RETURN rec_employee;
  END get_employee;

  FUNCTION get_employee(p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE IS
    rec_employee employees%ROWTYPE;
  BEGIN
    SELECT *
    INTO   rec_employee
    FROM   employees
    WHERE  last_name = p_family_name;
  
    RETURN rec_employee;
  END get_employee;

END emp_pkg;

--e)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS
  ...

  PROCEDURE print_employee(rec_employee employees%ROWTYPE) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(rec_employee.department_id || ' ' ||
                         rec_employee.employee_id || ' ' ||
                         rec_employee.first_name || ' ' ||
                         rec_employee.last_name || ' ' || 
                         rec_employee.job_id || ' ' ||
                         rec_employee.salary);
  END print_employee;

END emp_pkg;


/*Exercício nº3*/

--a)

CREATE OR REPLACE PACKAGE emp_pkg IS
  ...

  PROCEDURE init_departments;

  PROCEDURE print_employee(rec_employee employees%ROWTYPE); 

END emp_pkg;

--b) 

CREATE OR REPLACE PACKAGE BODY emp_pkg IS

--i)

TYPE boolean_tab_type IS TABLE OF BOOLEAN
INDEX BY BINARY_INTEGER;
valid_departments boolean_tab_type; 

...

--ii)
  
  PROCEDURE init_departments IS BEGIN 
    FOR rec IN (SELECT department_id FROM departments)
      LOOP 
        valid_departments(rec.department_id) := TRUE;
      END LOOP;
  END init_departments;
 
...

END emp_pkg;
  
--c) 

CREATE OR REPLACE PACKAGE emp_pkg IS
  ...
  
  BEGIN 
    init_departments;
  
END emp_pkg;

/*Exercício nº4*/

--a)

CREATE OR REPLACE PACKAGE BODY emp_pkg IS

TYPE boolean_tab_type IS TABLE OF BOOLEAN
INDEX BY BINARY_INTEGER;
valid_departments boolean_tab_type; 

  FUNCTION valid_deptid(p_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
  BEGIN
    RETURN valid_departments.exists(p_deptid);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END valid_deptid;
  
  ...
END emp_pkg; 

--b) 

EXECUTE emp_pkg.add_employee('James', 'Bond' , p_deptid => 15);

-- O erro aparece pois o departamento é inválido

--d)

/* O erro persiste pois o novo departamento não está contido na
   tabela valid_departments */
   
--f) 

/* Agora a procedure é completa pois o departamento está na tabela
   usada de verificação (valid_departments), então o novo funcionário
   é adicionado. */
   

/*Exercício nº5*/

--a) Neste caso, a especificação já havia sido escrita em ordem alfabética

CREATE OR REPLACE PACKAGE emp_pkg IS

  PROCEDURE add_employee(...);

  PROCEDURE add_employee(...);

  PROCEDURE get_employee(...);

  FUNCTION get_employee(...)
    RETURN employees%ROWTYPE;

  FUNCTION get_employee(...)
    RETURN employees%ROWTYPE;

  PROCEDURE init_departments;

  PROCEDURE print_employee(...); 

END emp_pkg;

--b) 

/* Ocorre um erro na compilação pois valid_deptid é referenciado antes
   dele aparecer em add_employee. A modificação está no item c). */
   
--c)

/* Agora a compilação ocorre com sucesso, pois o valid_deptid é 
   referenciado no início */
   
CREATE OR REPLACE PACKAGE BODY emp_pkg IS

TYPE boolean_tab_type IS TABLE OF BOOLEAN
INDEX BY BINARY_INTEGER;
valid_departments boolean_tab_type; 

  FUNCTION valid_deptid(p_deptid departments.department_id%TYPE) RETURN BOOLEAN;

  ...
   
  PROCEDURE print_employee(rec_employee employees%ROWTYPE) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(...);
  END print_employee;

  FUNCTION valid_deptid(p_deptid departments.department_id%TYPE) RETURN BOOLEAN IS
  BEGIN
    RETURN valid_departments.exists(p_deptid);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END valid_deptid;

  BEGIN 
    init_departments;
  
END emp_pkg;
   
