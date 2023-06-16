/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 12/12/2022
-- Tópico: Adicionais 2
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

CREATE OR REPLACE FUNCTION validation_passuser(p_password     VARCHAR2,
                                               p_user VARCHAR2)
  RETURN BOOLEAN IS
BEGIN
  IF REGEXP_COUNT(p_password, p_user) = 0 AND
     LENGTH(p_password) >= 8 AND
     REGEXP_LIKE(p_password, '^.*[0-9].*$') AND
     REGEXP_LIKE(p_password, '^.*[[:alpha:]]{1,}.*[[:alpha:]]{1,}.*$') AND
     REGEXP_LIKE(p_password, '^.*[@#$%&*].*$') AND
     NOT REGEXP_LIKE(p_password, '^.[[:space:]].*$')
     THEN RETURN TRUE;
  ELSE RETURN FALSE;
  END IF;
END validation_passuser;

/*Exercício nº2*/

CREATE OR REPLACE FUNCTION validar_email(p_mail VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    IF NOT REGEXP_LIKE(p_mail, '^.* .*$') AND
       REGEXP_LIKE(p_mail, '^[a-zA-Z0-9._]+@{1}[a-zA-Z0-9]+[.]{1,}+[a-zA-Z0-9.]{1,}+$') THEN
      RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
    
  END validar_email;
