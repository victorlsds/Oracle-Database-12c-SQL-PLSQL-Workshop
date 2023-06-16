/******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: PL/SQL
-- Data: 08/11/2022
-- Tópico: 3
-- Instrutor: Gustavo
****************************************************************************/

/*Exercício nº 1*/

/* Variáveis válidas:

             a. today
             b. last_name
             e. Isleap$year
             g. NUMBER#
             h. number1to7
             
   Variáveis inválidas:
   
             c. today's_date - [não é possível devido a presença de aspas simples]
             d. Number_of_days_in_February_this_year - [o nome da variável é muito grande]
             f. #number - [não é possível devido a presença de cerquilha]  */
             
/*Exercício nº 2*/

/* Declarações válidas:
   
             a. number_of_copies   PLS_INTEGER;
             d. by_when        DATE := CURRENT_DATE+1;
             
   Declarações inválidas:
   
             b. PRINTER_NAME   constant VARCHAR2(10); - [falta inicialização devido a presneça do 'constant']
             c. deliver_to     VARCHAR2(10) := Johnson; - [falta a presença de aspas simples em 'Johnson']  */

/*Exercício nº 3*/

--a) The block executes successfully and prints "ferndandez"

/*Exercício nº 4*/

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

/*Exercício nº 5*/

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
