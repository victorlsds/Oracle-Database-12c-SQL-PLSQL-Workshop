/*
******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- M�dulo: PLSQL1 
-- Data: 09/11/2022
-- T�pico: 5
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exerc�cio n�1*/

--a)/b)/c)/d)

DECLARE
  v_max_deptno NUMBER;
BEGIN
  SELECT MAX(department_id)
  INTO   v_max_deptno
  FROM   departments;
  DBMS_OUTPUT.PUT_LINE('The maximum department_id is: ' || v_max_deptno);
END;
/

/*Exerc�cio n�2*/

--a)/b)/c)/d)/e)/f)

DECLARE
  v_max_deptno NUMBER;
  v_dept_name  departments.department_name%TYPE := 'Education';
  v_dept_id    NUMBER := 0;
BEGIN
  SELECT MAX(department_id)
  INTO   v_max_deptno
  FROM   departments;
  v_dept_id := v_max_deptno + 10;
  INSERT INTO departments
    (department_id,
     department_name,
     location_id)
  VALUES
    (v_dept_id,
     v_dept_name,
     NULL);
  DBMS_OUTPUT.PUT_LINE('Number of rows affected: ' || SQL%ROWCOUNT);
  DBMS_OUTPUT.PUT_LINE('The maximum department_id is: ' || v_max_deptno);
END;
/
SELECT * FROM departments WHERE department_id= 280;

/*Exerc�cio n�3*/

--a)/b)/c)/d)
BEGIN
  UPDATE departments
  SET    location_id = 3000
  WHERE  department_id = 280;
END;
/
SELECT *
FROM   departments
WHERE  department_id = 280;
DELETE FROM departments
WHERE  department_id = 280;
