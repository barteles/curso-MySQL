-- EX 134- dar uptdate no empregado 999903
UPDATE employees 
SET 
    first_name = 'Stella',
    last_name = 'Parkingson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
    emp_no = 999903;

SELECT 
    *
FROM
    departments
;
-- EX 136- utilizar ROLLBACK em um erro. Primeiro deve dar comit, depois fazer o erro e depois ROLLBACK e dar comit novamente
UPDATE departments_dup
SET 
dept_no= 'd011', dept_name = 'Quality_control';

SELECT 
    *
FROM
    departments;

ROLLBACK;

COMMIT;

-- EX 138- mudar o nome do departamento de business analysis para data analysis
UPDATE departments 
SET 
    dept_name = 'Data_analysis'
WHERE
    dept_no = 'd010';
-- EX 139- deletar informações sobre o trab 999903. Primeiro dar comit para poder voltar caso necessário.alter
DELETE FROM employees 
WHERE
    emp_no = 999903;
rollback;
-- Ex 141- deletar o departamento 010 do dept_emp
DELETE FROM departments_d 
WHERE
    dept_no = 'd010';
commit;