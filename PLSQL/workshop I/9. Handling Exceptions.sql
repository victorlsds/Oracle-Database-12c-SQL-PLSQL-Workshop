/*
******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- M�dulo: PLSQL1 
-- Data: 16/11/2022
-- T�pico: 9
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exerc�cio n�1*/

CREATE TABLE messages        --cria��o da tabela messages
       (teste  VARCHAR2(50));

/*Exerc�cio n�2-3-4-5-6-7*/

DECLARE
  v_ename   employees.last_name%TYPE;
  v_emp_sal employees.salary%TYPE := 6000;
BEGIN
  SELECT last_name
  INTO   v_ename
  FROM   employees
  WHERE  salary = v_emp_sal;
  INSERT INTO messages
    (teste)
  VALUES
    (v_ename || '- R$' || TO_CHAR(v_emp_sal));
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    INSERT INTO messages
      (teste)
    VALUES
      ('No employee with a salary of ' || TO_CHAR(v_emp_sal));
  WHEN TOO_MANY_ROWS THEN
    INSERT INTO messages
      (teste)
    VALUES
      ('More than one employee with a salary of ' || TO_CHAR(v_emp_sal));
  WHEN OTHERS THEN
    INSERT INTO messages
      (teste)
    VALUES
      ('Some other error occurred');    
END;
/
SELECT * FROM messages;

/*Exerc�cio n�8*/

DECLARE
  v_ename   employees.last_name%TYPE;
  v_emp_sal employees.salary%TYPE := 2000;
BEGIN
  ...
END;
