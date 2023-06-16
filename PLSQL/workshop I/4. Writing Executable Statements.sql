/*
******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- M�dulo: PLSQL1 
-- Data: 09/11/2022
-- T�pico: 4
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exerc�cio n�1*/

--a) 2 - NUMBER
--b) Western Europe - VARCHAR2
--c) 601 - NUMBER
--d) Product 10012 is in stock - VARCHAR2
--e) [ERRO: pois a vari�vel n�o foi declarada]


/*Exerc�cio n�2*/

--a) 201 - NUMBER
--b) Unisports - VARCHAR2 
--c) GOOD - VARCHAR2
--d) Womansport - VARCHAR2
--e) [ERRO: pois a vari�vel n�o foi declarada] 
--f) EXCELLENT - VARCHAR2 


/*Exerc�cio n�3*/

--a/b)

SET SERVEROUTPUT ON
--VARIABLE b_basic_percent NUMBER
--VARIABLE b_pf_percent NUMBER
DECLARE
  v_today    DATE := SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  /*:b_basic_percent := 45;
  :b_pf_percent := 12; */
  DBMS_OUTPUT.PUT_LINE('Hello World');
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/ PRINT

--c/d/e)

SET SERVEROUTPUT ON
--VARIABLE b_basic_percent NUMBER
--VARIABLE b_pf_percent NUMBER
DECLARE
  v_today         DATE := SYSDATE;
  v_tomorrow      v_today%TYPE;
  b_basic_percent NUMBER;
  b_pf_percent    NUMBER;
  v_fname         VARCHAR2(15);
  v_emp_sal       NUMBER(10);
BEGIN
  v_tomorrow := v_today + 1;
  /*:b_basic_percent := 45;
  :b_pf_percent := 12; */
  SELECT first_name,
         salary
  INTO   v_fname,
         v_emp_sal
  FROM   employees
  WHERE  employee_id = 110;
  DBMS_OUTPUT.PUT_LINE('Hello ' || v_fname);
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/
--PRINT

--f)

SET SERVEROUTPUT ON
--VARIABLE b_basic_percent NUMBER
--VARIABLE b_pf_percent NUMBER
DECLARE
  v_today         DATE := SYSDATE;
  v_tomorrow      v_today%TYPE;
  v_basic_percent NUMBER;
  v_pf_percent    NUMBER;
  v_fname         VARCHAR2(15);
  v_emp_sal       NUMBER(10);
BEGIN
  v_tomorrow := v_today + 1;
  /*:b_basic_percent := 45;
  :b_pf_percent := 12; */
  v_basic_percent := 45 / 100;
  v_pf_percent    := 12 / 100;
  SELECT first_name,
         salary
  INTO   v_fname,
         v_emp_sal
  FROM   employees
  WHERE  employee_id = 110;
  DBMS_OUTPUT.PUT_LINE('Hello ' || v_fname);
  DBMS_OUTPUT.PUT_LINE('YOUR SALARY IS: ' || v_emp_sal);
  DBMS_OUTPUT.PUT_LINE('YOUR CONTRIBUITION TOWARDS PF: ' ||
                       v_emp_sal * v_basic_percent * v_pf_percent);
END;
/
--PRINT

