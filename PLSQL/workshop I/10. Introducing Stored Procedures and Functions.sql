/*
******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- M�dulo: PLSQL1 
-- Data: 18/11/2022
-- T�pico: 10
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exerc�cio n�1*/

--a) 

CREATE PROCEDURE greet IS
  v_today    DATE := SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  DBMS_OUTPUT.PUT_LINE(' Hello World ');
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/

--e)

BEGIN 
  greet;
END;
/

/*Exerc�cio n�2*/

--a)

DROP PROCEDURE greet;

--b)c)

CREATE PROCEDURE greet (p_name VARCHAR2) IS
  v_today    DATE := SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  DBMS_OUTPUT.PUT_LINE(' Hello ' || p_name);
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/

--f) 

BEGIN 
  greet('Nancy');
END;
/
