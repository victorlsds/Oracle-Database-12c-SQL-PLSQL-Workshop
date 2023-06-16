/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL1 
-- Data: 18/11/2022
-- Tópico: 10
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

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

/*Exercício nº2*/

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
