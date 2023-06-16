/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2 
-- Data: 17/10/2022
-- Tópico: 3
-- Instrutor: Gustavo
****************************************************************************
*/

/*1. Create the DEPT table based on the following table instance chart. Confirm that the table
is created.*/

CREATE TABLE dept
       (id     NUMBER (7) 
               CONSTRAINT dep_id_pk PRIMARY KEY,
        name   VARCHAR2 (25));
        
/*2. You need a sequence that can be used with the PRIMARY KEY column of the DEPT
table. The sequence should start at 200 and have a maximum value of 1 ,000. Have your
sequence increment by 10. Name the sequence DEPT ID SEQ.*/

CREATE SEQUENCE dept_deptid_seq
       INCREMENT BY 10
       START WITH 200
       MAXVALUE 1000;
       
/*3. To test your sequence, write a script to insert two rows in the DEPT table. Name your
script lab 03_03 sql. Be sure to use the sequence that you created for the ID
column. Add two departments: Education and Administration. Confirm your additions.
Run the commands in your script.*/
      
INSERT INTO dept (id, name)
VALUES (dept_deptid_seq.NEXTVAL, 'Education');

INSERT INTO dept (id, name)
VALUES (dept_deptid_seq.NEXTVAL, 'Administration');

COMMIT; 

/*4. Find the names your sequences. Ate a query In a scnptto Isp y e owqng
information about your sequences: sequence name, maximum value, increment size,
and last number. Name the script lab 03 04 . sal. Run the statement in vour script.*/

SELECT sequence_name, 
       max_value, 
       increment_by, 
       last_number
FROM user_sequences;

/*5. Create a synonym for your EMPLOYEES table. Call it EMPI- Then find the names of all
synonyms that are in ur schema.*/

CREATE SYNONYM emp1
FOR dept;

SELECT synonym_name, 
       table_owner, 
       table_name, 
       db_link
FROM user_synonyms;

/*6. Drop the EMPI synonym.*/

DROP SYNONYM emp1;

/*7. Create a nonunique index on the NAME column in the DEPT table.*/

CREATE INDEX dept_name_idx
ON dept(name);

/*8. Create the SALES_DEPT table based on the following table instance chart. Name the
index for the PRIMARY KEY column SALES_PK_IDX. Then query the data dictionary
view to find the index name, table name, and whether the index is unique.*/

CREATE TABLE sales_dept 
       (team_id      NUMBER(3)
             CONSTRAINT sales_pk_idx PRIMARY KEY,
        location     VARCHAR(30));

SELECT index_name,
       table_name,
       uniqueness
FROM user_indexes
WHERE LOWER(index_name) = 'sales_pk_idx';

/*9 Drop the tables and sequences created in this practice.*/

DROP TABLE dept;
DROP SEQUENCE dept_deptid_seq;
DROP SYNONYM emp1;
DROP TABLE sales_dept;
