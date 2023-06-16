/*
******************************Exercícios Treinamento************************
-- Nome: Victor Lucas Santos da Silva 
-- Módulo: PLSQL2 
-- Data: 09/12/2022
-- Tópico: Adicionais 1
-- Instrutor: Gustavo
****************************************************************************
*/

/*Exercício nº1*/

CREATE OR REPLACE PACKAGE BODY xml_create IS

  l_newxml DBMS_XMLDOM.DOMDOCUMENT;

  PROCEDURE create_element(p_name      VARCHAR2,
                           l_node      IN OUT NOCOPY dbms_xmldom.DOMNOde,
                           l_root_node IN dbms_xmldom.DOMNode,
                           p_text      VARCHAR2) IS
    l_element dbms_xmldom.DOMElement;
    text      DBMS_XMLDOM.DOMTEXT;
    text_node DBMS_XMLDOM.DOMNODE;
  BEGIN
    l_element := dbms_xmldom.createElement(l_newxml, p_name);
    l_node    := dbms_xmldom.appendChild(l_root_node,
                                         dbms_xmldom.makeNode(l_element));
  
    text      := DBMS_XMLDOM.CREATETEXTNODE(l_newxml, p_text);
    text_node := DBMS_XMLDOM.APPENDCHILD(l_node, DBMS_XMLDOM.MAKENODE(text));
  END create_element;


  PROCEDURE create_element(l_element   IN OUT NOCOPY dbms_xmldom.DOMElement,
                           p_name      VARCHAR2,
                           l_node      IN OUT NOCOPY dbms_xmldom.DOMNOde,
                           l_root_node IN dbms_xmldom.DOMNode) IS
  BEGIN
    l_element := dbms_xmldom.createElement(l_newxml, p_name);
    l_node    := dbms_xmldom.appendChild(l_root_node,
                                         dbms_xmldom.makeNode(l_element));
  END create_element;


  PROCEDURE create_xml(p_directory VARCHAR2,
                       p_filename  VARCHAR2) IS
  
    l_root_node dbms_xmldom.DOMNode;
  
    l_departments_element dbms_xmldom.DOMElement;
    l_departments_node    dbms_xmldom.DOMNode;
  
    l_dept_element dbms_xmldom.DOMElement;
    l_dept_node    dbms_xmldom.DOMNode;
  
    l_deptname_node dbms_xmldom.DOMNode;
  
    l_manager_element dbms_xmldom.DOMElement;
    l_managers_node   dbms_xmldom.DOMNode;
  
    l_namemgr_node dbms_xmldom.DOMNode;
  
    l_emailmgr_node dbms_xmldom.DOMNode;
  
    l_salmgr_node dbms_xmldom.DOMNode;
  
    l_location_node dbms_xmldom.DOMNode;
  
    l_employees_element dbms_xmldom.DOMElement;
    l_employees_node    dbms_xmldom.DOMNode;
  
    l_emp_element dbms_xmldom.DOMElement;
    l_emp_node    dbms_xmldom.DOMNode;
  
    l_emp_firstname_node dbms_xmldom.DOMNode;
  
    l_empmail_node dbms_xmldom.DOMNode;
  
    l_emp_salary_node dbms_xmldom.DOMNode;
  
    v_deptcount NUMBER(6) := 0;
    v_empcount  NUMBER(6) := 0;
  
  BEGIN
    -- CRIA O DOCUMENTO OBJECT MODEL (XML VAZIO)
    l_newxml := dbms_xmldom.newDomDocument;
  
    --XML DECLARATION
    dbms_xmldom.setVersion(l_newxml, '1.0" encoding="UTF-8');
    dbms_xmldom.setCharset(l_newxml, 'UTF-8');
  
    -- CRIAR O PRIMEIRO NODE (root)
    l_root_node := dbms_xmldom.makeNode(l_newxml);
  
    -- CRIAÇÃO DO ELEMENTO (DEPARTAMENTO) E ATRIBUIÇÃO A UM NODE
    create_element(l_departments_element,
                   'Departamentos',
                   l_departments_node,
                   l_root_node);
  
    FOR r_dept IN (SELECT dept.department_id,
                          dept.department_name,
                          dept.manager_id,
                          e.first_name,
                          e.last_name,
                          e.email,
                          e.salary,
                          loc.city
                   FROM   departments dept,
                          locations   loc,
                          employees   e
                   WHERE  loc.location_id = dept.location_id
                   AND    dept.manager_id = e.employee_id
                   AND    dept.department_id IN (100, 110))
    
    -- CRIAÇÃO DE NOVOS NODE COM BASE EM CADA DEPARTAMENTO, ATRIBUTOS
    LOOP
      create_element(l_dept_element,
                     'Departamento',
                     l_dept_node,
                     l_departments_node);
      dbms_xmldom.setAttribute(l_dept_element, 'id', r_dept.Department_Id);
    
      -- NOME DEPARTAMENTO (NODE) 
      create_element('NomeDepartamento',
                     l_deptname_node,
                     l_dept_node,
                     r_dept.department_name);
    
      -- ELEMENTO E ATRIBUTO PARA OS GERENTES DE DEPARTAMENTO (NODE)
      create_element(l_manager_element,
                     'GerenteDepartamento',
                     l_managers_node,
                     l_dept_node);
      dbms_xmldom.setAttribute(l_manager_element, 'id', r_dept.manager_id);
    
      -- INFORMAÇÕES DO MANAGER
      -- NOME (NODE) (TEXTNODE)
      create_element('NomeFuncionario',
                     l_namemgr_node,
                     l_managers_node,
                     r_dept.first_name || ' ' || r_dept.last_name);
    
      -- EMAIL (NODE) (TEXTNODE) 
      create_element('EmailFuncionario',
                     l_emailmgr_node,
                     l_managers_node,
                     r_dept.email);
    
      -- SALARIO (NODE) (TEXTNODE)
      create_element('Salario',
                     l_salmgr_node,
                     l_managers_node,
                     TO_CHAR(r_dept.salary, 'fm999999D00'));
    
      -- CIDADE (NODE) (TEXTNODE)
      create_element('CidadeDepartamento',
                     l_location_node,
                     l_dept_node,
                     r_dept.city);
    
      -- CRIAÇÃO DO NODE FUNCIONARIOS
      create_element(l_employees_element,
                     'Funcionarios',
                     l_employees_node,
                     l_dept_node);
    
      FOR r_emp IN (SELECT employee_id,
                           first_name,
                           last_name,
                           email,
                           salary
                    FROM   employees e_out
                    WHERE  department_id = r_dept.department_id
                    AND    employee_id <> r_dept.manager_id)
      
      LOOP
        -- NODES PARA CADA FUNCIONÁRIO DO DEPARTAMENTO QUE ESTÁ NO LOOP DE FORA
        create_element(l_emp_element,
                       'Funcionario',
                       l_emp_node,
                       l_employees_node);
        dbms_xmldom.setAttribute(l_emp_element, 'id', r_emp.employee_id);
      
        -- NOME (NODE) (TEXTNODE)                   
        create_element('NomeFuncionario',
                       l_emp_firstname_node,
                       l_emp_node,
                       r_emp.first_name || ' ' || r_emp.last_name);
      
        -- EMAIL (NODE) (TEXTNODE)
        create_element('EmailFuncionario',
                       l_empmail_node,
                       l_emp_node,
                       r_emp.email);
      
        -- SALARIO (NODE) (TEXTNODE)            
        create_element('Salario',
                       l_emp_salary_node,
                       l_emp_node,
                       TO_CHAR(r_emp.salary, 'fm999999D00'));
      
        --CONTADOR DE FUNCIONÁRIOS                                                                                                      
        v_empcount := v_empcount + 1;
      END LOOP;
      -- CONTADOR DE DEPARTAMENTOS
      v_deptcount := v_deptcount + 1;
      -- ATRIBUTO QUANTIDADE FUNCIONARIOS (FIM DO LOOP)
      dbms_xmldom.setAttribute(l_employees_element,
                               'quantidadeFuncionarios',
                               v_empcount);
    END LOOP;
    -- ATRIBUTO QUANTIDADE DE DEPARTAMENTOS (FIM DO LOOP)
    dbms_xmldom.setAttribute(l_departments_element,
                             'QuantidadeDepartamentos',
                             v_deptcount);
  
    xmldom.writeToFile(l_newxml, p_directory || '/' || p_filename);
    dbms_xmldom.freeDocument(l_newxml);
  END create_xml;

END xml_create;
