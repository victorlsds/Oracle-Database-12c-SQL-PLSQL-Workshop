/*
******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- M�dulo: PLSQL1 
-- Data: 10/11/2022
-- T�pico: 6
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exerc�cio n�1*/

--a)b)c)

CREATE TABLE messages        --cria��o da tabela messages
       (teste NUMBER(2));

BEGIN                        --plsql block
  FOR i IN 1 .. 10
  LOOP
    IF i = 6 OR
       i = 8 THEN
      NULL;
    ELSE
      INSERT INTO messages
        (teste)
      VALUES
        (i);
    END IF;
  END LOOP;
  COMMIT;
END;
/
SELECT * FROM messages;

/*Exerc�cio n�2*/

CREATE TABLE emp             --cria��o da tablea emp
AS SELECT * 
FROM employees; 

ALTER TABLE emp              --adicionando a coluna stars
ADD (stars  VARCHAR2(50));

--a)

SET SERVEROUTPUT ON
DECLARE
  v_empno    emp.employee_id%TYPE := 176;
  v_asterisk emp.stars%TYPE := NULL;
  v_sal      emp.salary%TYPE;
BEGIN
  SELECT ROUND(salary / 1000)
  INTO   v_sal
  FROM   emp
  WHERE  employee_id = v_empno;
  FOR i IN 1 .. v_sal
  LOOP
    v_asterisk := v_asterisk || '*';
    UPDATE emp
    SET    stars = v_asterisk
    WHERE  employee_id = v_empno;
    COMMIT;
    END LOOP;
  END;
/ 
SELECT *
FROM   employees
WHERE  employee_id = 176;
