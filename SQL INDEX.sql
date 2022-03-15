-- EXP 245- vamos criar um índice para agilizar o processo de busca do SQL
SELECT 
    *
FROM
    employees
WHERE
    hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees (hire_date);		#ele irá optmizar a procura por empregados através da coluna hire_date

#criar um índice composto
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Georgi'
        AND last_name = 'Facello';
	
CREATE INDEX i_composite ON employees (first_name, last_name);

-- EX 246- dropar o índice i_hire
ALTER TABLE employees
DROP INDEX i_hire_date;

-- EX 249- Selecionar todos os salários onde o valor é maior que R$89k anual e depois crie um índice para acelerar o processo
SELECT 
    *
FROM
    salaries
WHERE
    salary > 89000;

create index i_salary on salaries (salary);
