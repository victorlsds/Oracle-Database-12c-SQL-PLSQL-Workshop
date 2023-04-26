/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva
-- Módulo: SQL2
-- Data: 24/10/2022
-- Tópico: 8
-- Instrutor: Gustavo
****************************************************************************
*/

/*1. What privilege should a user be given to log on to the Oracle server? Is this a system
privilege or an object privilege?*/

-- O privilégio "CREATE SESSION", sendo este um privilégio de sistema.


/*2. What privilege should a user be given to create tables?*/ 

-- O privilégio "CREATE TABLE".

/*3. If you create a table, who can pass along privileges to other users in your table?*/

-- Eu como criador da tabela e outros usuários que atribuí privilégios
-- usando [WITH GRANT OPTION]. 

/*4. You are the DBA. You create many users who require the same system privileges.
What should you use to make your job easier?*/

-- Para facilitar a atribuição de mesmos privilégios, pode-se utilizar
-- da criação de ROLES e atribuílas diretamente aos novos usuários.

/*5. What command do you use to change your password?*/

ALTER USER vlsantoss
IDENTIFIED BY senha;

/*6. User21 is the owner of the EMP table and grants the DELETE privilege to User22 by using
the WITH GRANT OPTION clause. User22 then grants the DELETE privilege on EMP to
User23. User21 now finds that User23 has the privilege and revokes it from User22.
Which user can now delete from the EMP table?*/

-- Apenas o USER21. Pois quando um usuário possui qualquer privilégio 
-- atribuido usando [WITH GRANT OPTION] é revogado, todos os usuários
-- que receberam a partir dele também são revogados.

/*7. You want to grant SCOTT the privilege to update data in the DEPARTMENTS table. You also
want to enable SCOTT to grant this privilege to other users. What command do you use?*/

GRANT UPDATE
ON    departments
TO    scott
WITH GRANT OPTION;

/*8. Grant another user query privilege on your table. Then, verify whether that user can use the
privilege.*/

--a) Grant another user (for example, ora22) privilege to view records in your REGIONS
table. Include an option for this user to further grant this privilege to other users.


GRANT SELECT
ON    regions 
TO    lmpolezel
WITH GRANT OPTION;
-- feito por vlsantoss

--b) Have the user query your REGIONS table.

SELECT * 
FROM   vlsantoss.regions;
--feito por lmpolezel

--c) Have the user pass on the query privilege to a third user, ora23.

GRANT SELECT
ON    vlsantoss.regions
TO    ora23;
--feito por lmpolezel

--d) Take back the privilege from the user who performs step b.

REVOKE SELECT
ON     regions
FROM   lmpolezel;
-- feito por vlsantoss

/*9. Grant another user query and data manipulation privileges on your COUNTRIES table. Make
sure that the user cannot pass on these privileges to other users.*/

GRANT SELECT, UPDATE, INSERT 
ON    countries
TO    lmpolezel;
-- feito por vlsantoss

/*10. Take back the privileges on the COUNTRIES table granted to another user.*/

REVOKE SELECT, UPDATE, INSERT 
ON     countries
FROM   lmpolezel;
-- feito por vlsantoss

/*11. Grant another user access to your DEPARTMENTS table*/

--i)

GRANT SELECT
ON    departments
TO    lmpolezel;
-- feito por vlsantoss

--ii)

GRANT SELECT
ON    departments
TO    vlsantoss;
-- feito por lmpolezel

/*12. Query all the rows in your DEPARTMENTS table.*/

SELECT *
FROM   departments;
-- feito por lmpolezel

/*13. Add a new row to your DEPARTMENTS table. Team 1 should add Education as department
number 500. Team 2 should add Human Resources as department number 510. Query the
other team’s table.*/

--i)

INSERT INTO departments (department_name, department_id)
VALUES ('Education', 500);

COMMIT; 
-- feito por vlsantoss

--ii)

INSERT INTO departments (department_name, department_id)
VALUES ('Human Resources', 510);

COMMIT;
-- feito por lmpolezel 

/*14. Create a synonym for the other team’s DEPARTMENTS table.*/

--i)

CREATE SYNONYM dept1
       FOR vlsantoss.departments;
-- feito por lmpolezel 
       
--ii)

CREATE SYNONYM dept2
       FOR lmpolezel.departments;
-- feito por vlsantoss

/*15. Query all the rows in the other team’s DEPARTMENTS table by using your synonym.*/

--i) 

SELECT *
FROM dept1;
-- feito por lmpolezel 

--ii)

SELECT *
FROM dept2;
-- feito por vlsantoss

/*16. Revoke the SELECT privilege from the other team.*/

--i)

REVOKE SELECT
ON     departments
FROM   vlsantoss;
-- feito por lmpolezel

--ii)

REVOKE SELECT
ON     departments
FROM   lmpolezel;
-- feito por vlsantoss

/*17. Remove the row that you inserted into the DEPARTMENTS table in step 13 and save the
changes.*/

--i)

DELETE FROM departments
WHERE department_id = 500;

COMMIT;
-- feito por vlsantoss

--ii)

DELETE FROM departments
WHERE department_id = 510;

COMMIT;
-- feito por lmpolezel

/*18. Drop the synonyms team1 and team2.*/

DROP SYNONYM dept1;
DROP SYNONYM dept2;
