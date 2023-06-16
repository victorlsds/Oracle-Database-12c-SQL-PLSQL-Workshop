/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL1 
-- Data: 14/11/2022
-- Tópico: 8
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

DECLARE
  v_deptno NUMBER := 10;
  CURSOR c_emp_cursor IS
    SELECT last_name,
           salary,
           manager_id
    FROM   employees
    WHERE  department_id = v_deptno;
BEGIN
  FOR emp_record IN c_emp_cursor
  LOOP
    IF emp_record.salary < 5000 AND
       emp_record.manager_id IN (101, 124) THEN
      DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' Due for a raise');
    ELSE
      DBMS_OUTPUT.PUT_LINE(emp_record.last_name || ' Not Due for a raise');
    END IF;
  END LOOP;
END;
/
      
/*Exercício nº2*/

DECLARE
  CURSOR c_dept_cursor IS --primeiro cursor para departments
    SELECT department_id,
           department_name
    FROM   departments
    WHERE  department_id < 100
    ORDER  BY department_id;
  CURSOR c_emp_cursor(deptno NUMBER) IS --segundo cursor com parâmetro para employees
    SELECT last_name,
           job_id,
           hire_date,
           salary
    FROM   employees
    WHERE  department_id = deptno
    AND    employee_id < 120;
  --variáveis
  v_deptid   departments.department_id%TYPE; 
  v_deptname departments.department_name%TYPE;
  v_lastname employees.last_name%TYPE;
  v_jobid    employees.job_id%TYPE;
  v_hiredate employees.hire_date%TYPE;
  v_salary   employees.salary%TYPE;
BEGIN
  OPEN c_dept_cursor;
  LOOP
    --loop do cursor de departamentos
    FETCH c_dept_cursor
      INTO v_deptid,
           v_deptname;
    EXIT WHEN c_dept_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('[Dpt Number]: ' || v_deptid || ' [Dept Name]: ' ||
                         v_deptname);
    OPEN c_emp_cursor(v_deptid);
    LOOP
      --loop interno do outro cursor
      FETCH c_emp_cursor
        INTO v_lastname,
             v_jobid,
             v_hiredate,
             v_salary;
      EXIT WHEN c_emp_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(' • Name: ' || v_lastname || ' - ' || v_jobid ||
                           ' (' || v_hiredate || ') - R$' || v_salary);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('...............................................');
    CLOSE c_emp_cursor;
  END LOOP;
  CLOSE c_dept_cursor;
END;
/
