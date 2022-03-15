-- EX 145- contar quantos departamentos tem na tabela DEPT_EMP na tabela Employees
select * from dept_emp;

SELECT 
    COUNT(DISTINCT dept_no)
FROM
    dept_emp;
    
-- Exemplo 147- verificar quanto a empresa gasta em salários por ano
SELECT 
    SUM(salary)
FROM
    salaries;
    
-- Ex 148- o total gasto em salários em todos os contratos que começaram a partir de 1° de janeiro de 97
SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date >= '1997-01-01';
    
-- Exp 150- descobrir o maior e o menor salário que a empresa paga
SELECT 
    MAX(salary)
FROM
    salaries;
SELECT 
    MIN(salary)
FROM
    salaries;
    
-- Ex 151- qual o menor e o maior número do empregado?
SELECT 
    MAX(emp_no)
FROM
    employees;
SELECT 
    MIN(emp_no)
FROM
    employees;
    
-- Exp 153- qual a média salarial dos empregados?
SELECT 
    AVG(salary)
FROM
    salaries;
    
-- Ex 154- Qual a média salaria paga aos empregados que começaram depois de 1/01/97?
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    from_date >= '1997-01-01';
    
-- Exp 156- Arredondar o resultado da média salarial para um inteiro e depois com a casa dos centavos.
-- 01
SELECT 
    ROUND(AVG(salary))
FROM
    salaries;
-- 02
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries;
    
-- Ex 157- arredondar a média salarial para quem recebeu a partir de 1997/01/01
SELECT 
    ROUND(AVG(salary), 2)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

-- Exp 160- Utilizar o IFNULL e modificar o Output para Não informado ao invés de NULL
SELECT 
    dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name
FROM
    departments_dup;
-- agora será usado o COALESCE que é o mesmo que o IFNULL, porém terão mais argumentos;
    SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no DESC;

-- EX 162- selecionar o Dept-dup e adcionar uma terceira coluna (coalesce) como dept-info. Se for nulo, usar 'dept_name'
SELECT 
    dept_no,
    dept_name,
    coalesce(dept_no, 'dept_name') AS dept_info
FROM
    departments_dup
    order by dept_no ASC;
    
-- EX 163- Modificar o exemplo 160 IFFNULL por COALESCE, onde 'N/A' é mostrado quando dept_no= NULL e 'not provided' quando dept_name =null
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;