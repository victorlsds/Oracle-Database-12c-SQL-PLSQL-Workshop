/******************************Exerc�cios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- M�dulo: PL/SQL
-- Data: 08/11/2022
-- T�pico: 3
-- Instrutor: Gustavo
****************************************************************************/

/*Exerc�cio n� 1*/

/* Vari�veis v�lidas:

             a. today
             b. last_name
             e. Isleap$year
             g. NUMBER#
             h. number1to7
             
   Vari�veis inv�lidas:
   
             c. today's_date - [n�o � poss�vel devido a presen�a de aspas simples]
             d. Number_of_days_in_February_this_year - [o nome da vari�vel � muito grande]
             f. #number - [n�o � poss�vel devido a presen�a de cerquilha]  */
             
/*Exerc�cio n� 2*/

/* Declara��es v�lidas:
   
             a. number_of_copies   PLS_INTEGER;
             d. by_when        DATE := CURRENT_DATE+1;
             
   Declara��es inv�lidas:
   
             b. PRINTER_NAME   constant VARCHAR2(10); - [falta inicializa��o devido a presne�a do 'constant']
             c. deliver_to     VARCHAR2(10) := Johnson; - [falta a presen�a de aspas simples em 'Johnson']  */

/*Exerc�cio n� 3*/

--a) The block executes successfully and prints "ferndandez"

/*Exerc�cio n� 4*/

DECLARE 
v_today     DATE := SYSDATE;
v_tomorrow  v_today%TYPE;
BEGIN 
  v_tomorrow := v_today + 1;
  DBMS_OUTPUT.PUT_LINE('Hello World');
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/

/*Exerc�cio n� 5*/

VARIABLE b_basic_percent NUMBER
VARIABLE b_pf_percent NUMBER
DECLARE 
v_today     DATE := SYSDATE;
v_tomorrow  v_today%TYPE;
BEGIN 
  v_tomorrow := v_today + 1;
  :b_basic_percent := 45;
  :b_pf_percent := 12;
  DBMS_OUTPUT.PUT_LINE('Hello World');
  DBMS_OUTPUT.PUT_LINE('TODAY IS : ' || v_today);
  DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/
PRINT
