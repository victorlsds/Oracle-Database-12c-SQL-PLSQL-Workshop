/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL1 
-- Data: 11/11/2022
-- Tópico: 7
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

DECLARE
  v_countryid      VARCHAR2(2) := 'UK';
  v_country_record countries%ROWTYPE; --PRECISO DECLARAR O 'RECORD'?
BEGIN
  SELECT *
  INTO   v_country_record
  FROM   countries e
  WHERE  e.country_id = v_countryid;
  DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id ||
                       ' Country Name: ' || v_country_record.country_name ||
                       ' Region: ' || v_country_record.region_id);
END;
/

--e) apenas trocar o valor da variável v_countryid para 'DE'/'UK'/'US'


/*Exercício nº2*/

DECLARE
  TYPE dept_table_type IS TABLE OF departments.department_name%TYPE INDEX BY PLS_INTEGER;
  my_dept_table dept_table_type;
  f_loop_count  NUMBER := 10;
  v_deptno      NUMBER := 0;
BEGIN
  FOR i IN 1 .. f_loop_count
  LOOP
    v_deptno := v_deptno + 10;
    SELECT department_name
    INTO   my_dept_table(i)
    FROM   departments
    WHERE  department_id = v_deptno;
  END LOOP;
  FOR i IN my_dept_table.FIRST .. my_dept_table.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE(my_dept_table(i));
  END LOOP;
END;
/


/*Exercício nº3*/

SET SERVEROUTPUT ON
DECLARE
  TYPE dept_table_type IS TABLE OF departments%ROWTYPE INDEX BY PLS_INTEGER;
  my_dept_table dept_table_type;
  f_loop_count  NUMBER := 10;
  v_deptno      NUMBER := 0;
BEGIN
  FOR i IN 1 .. f_loop_count
  LOOP
    v_deptno := v_deptno + 10;
    SELECT *
    INTO   my_dept_table(i)
    FROM   departments
    WHERE  department_id = v_deptno;
  END LOOP;
  FOR i IN my_dept_table.FIRST .. my_dept_table.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE('Department Number: ' || my_dept_table(i).department_id ||
                         ' Department Name: ' || my_dept_table(i).department_name ||
                         ' Manager Id: ' || my_dept_table(i).manager_id ||
                         ' Location Id: ' || my_dept_table(i).location_id);
  END LOOP;
END;
/
