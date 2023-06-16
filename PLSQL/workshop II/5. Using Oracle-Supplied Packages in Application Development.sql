/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 29/11/2022
-- Tópico: 5
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

CREATE OR REPLACE PROCEDURE employee_report(p_dir      IN VARCHAR2,
                                            p_filename IN VARCHAR2) IS
  f_file UTL_FILE.FILE_TYPE;

  CURSOR c_avg_dept IS
    SELECT first_name,
           last_name,
           department_id,
           salary
    FROM   employees outer_t
    WHERE  salary >
           (SELECT AVG(salary)
            FROM   employees inner_t
            WHERE  inner_t.department_id = outer_t.department_id)
    ORDER  BY department_id;
BEGIN
  f_file := UTL_FILE.FOPEN(p_dir, p_filename, 'w');
  UTL_FILE.PUT_LINE(f_file, 'REPORT: ' || SYSDATE);
  FOR rec IN c_avg_dept
  LOOP
    UTL_FILE.PUT_LINE(f_file,
                      RPAD(rec.first_name || ' ' || rec.last_name, 15) || ' ' ||
                      LPAD(TO_CHAR(rec.department_id, '9999'), 10) || ' ' ||
                      LPAD(TO_CHAR(rec.salary, '$99,999.00'), 15));
  END LOOP;
  UTL_FILE.PUT_LINE(f_file, 'END OF REPORT: ' || SYSDATE);
  UTL_FILE.FCLOSE(f_file);

EXCEPTION
  WHEN OTHERS THEN
    IF UTL_FILE.IS_OPEN(f_file) THEN
      UTL_FILE.FCLOSE(f_file);
    END IF;
END employee_report;
