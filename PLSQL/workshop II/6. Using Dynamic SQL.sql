/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 29/11/2022
-- Tópico: 6
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

--a)

CREATE OR REPLACE PACKAGE table_pkg AUTHID CURRENT_USER IS

  PROCEDURE add_row(p_table_name VARCHAR2,
                    p_col_values VARCHAR2,
                    p_cols       VARCHAR2 := NULL);
                    
  PROCEDURE del_row(p_table_name VARCHAR2,
                    p_conditions VARCHAR2 := NULL);
                    
  PROCEDURE make(p_table_name VARCHAR2,
                 p_col_specs  VARCHAR2);
  
  PROCEDURE remove(p_table_name VARCHAR2);
  
  PROCEDURE upd_row(p_table_name VARCHAR2,
                    p_set_values VARCHAR2,
                    p_conditions VARCHAR2 := NULL);                    
END table_pkg;


--b) 

CREATE OR REPLACE PACKAGE BODY table_pkg IS
 
  PROCEDURE add_row(p_table_name VARCHAR2,
                    p_col_values VARCHAR2,
                    p_cols       VARCHAR2 := NULL) IS 
    v_add_stmt VARCHAR2(200) := 'INSERT INTO ' || p_table_name;
  BEGIN 
    IF p_cols IS NOT NULL THEN 
      v_add_stmt := v_add_stmt || '(' || p_cols || ')';
    END IF;
    
    v_add_stmt := v_add_stmt || ' VALUES (' || p_col_values || ')';
    EXECUTE IMMEDIATE v_add_stmt;
  END add_row;
  
  PROCEDURE del_row(p_table_name VARCHAR2,
                    p_conditions VARCHAR2 := NULL) IS
  v_del_stmt VARCHAR2(200) := 'DELETE FROM ' || p_table_name;
  BEGIN 
    IF p_conditions IS NOT NULL THEN
      v_del_stmt := v_del_stmt || 'WHERE ' || p_conditions;
    END IF;
    
    EXECUTE IMMEDIATE v_del_stmt;
  END del_row;
  
  PROCEDURE make(p_table_name VARCHAR2,
                 p_col_specs  VARCHAR2) IS
  v_make_stmt VARCHAR2(200) := 'CREATE TABLE ' || p_table_name || ' (' || p_col_specs || ')';
  BEGIN
    EXECUTE IMMEDIATE v_make_stmt;
  END make;
  
  PROCEDURE remove(p_table_name VARCHAR2) IS 
    v_cur_id INTEGER;
  BEGIN 
    v_cur_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cur_id, 'DROP TABLE ' || p_table_name, DBMS_SQL.NATIVE);
    DBMS_SQL.CLOSE_CURSOR(v_cur_id);
  END remove;
  
  PROCEDURE upd_row(p_table_name VARCHAR2,
                    p_set_values VARCHAR2,
                    p_conditions VARCHAR2 := NULL) IS 
  v_upd_stmt VARCHAR2(200) := 'UPDATE ' || p_table_name || ' SET ' || p_set_values;
  BEGIN 
    IF p_conditions IS NOT NULL THEN 
      v_upd_stmt := v_upd_stmt || ' WHERE ' || p_conditions;
    END IF; 
    EXECUTE IMMEDIATE v_upd_stmt;
  END upd_row; 
     
END table_pkg;


--c) 

EXECUTE table_pkg.make('my_contacts', 'id number(4), name varchar2(40)');

--d) 

DESC my_contacts;

--e)

BEGIN
 table_pkg.add_row('my_contacts','1,''Geoff Gallus''','id, name');
 table_pkg.add_row('my_contacts','2,''Nancy''','id, name');
 table_pkg.add_row('my_contacts','3,''Sunitha Patel''','id,name');
 table_pkg.add_row('my_contacts','4,''Valli Pataballa''','id,name');
END; 

--g)

EXECUTE table_pkg.del_row('my_contacts', 'id = 3');

--h)

EXECUTE table_pkg.upd_row('my_contacts','name=''Nancy Greenberg''','id=2') 

--j)

EXECUTE table_pkg.remove('my_contacts');


/*Exercício nº2*/

--a) 

CREATE OR REPLACE PACKAGE compile_pkg IS

  PROCEDURE make(p_obj_name VARCHAR2);

END compile_pkg;

--b)

CREATE OR REPLACE PACKAGE BODY compile_pkg IS

  FUNCTION get_type(p_search_obj VARCHAR2) RETURN VARCHAR2 IS
    v_obj_type user_objects.object_type%TYPE;
  BEGIN
    SELECT object_type
    INTO   v_obj_type
    FROM   user_objects
    WHERE  object_name = UPPER(p_search_obj)
    AND    ROWNUM = 1;
    RETURN v_obj_type;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END get_type;

  PROCEDURE make(p_obj_name VARCHAR2) IS
  v_obj_type user_objects.object_type%TYPE := get_type(p_obj_name);  
  v_make_stmt VARCHAR2(200) := 'ALTER ' || v_obj_type || ' ' || p_obj_name || ' COMPILE'; 
  e_invalid_obj EXCEPTION;
  BEGIN
    IF v_obj_type IS NOT NULL THEN 
      EXECUTE IMMEDIATE v_make_stmt; 
    ELSE 
      RAISE e_invalid_obj;
    END IF;
  EXCEPTION
    WHEN e_invalid_obj THEN 
      RAISE_APPLICATION_ERROR (-20206, 'The object required is not valid');
  END make;
  
END compile_pkg;

--c)

  --i)
  EXECUTE compile_pkg.make('employee_report');
  
  --ii)
  EXECUTE compile_pkg.make('emp_pkg');
  
  --iii) ERROR
    EXECUTE compile_pkg.make('emp_data');
