-- EXP 250- Usando IF e CASE condicionais
SELECT 
    emp_no,
    first_name,								#case eu posso utilizar vários condicionais ao mesmo tempo, facilitando meu trabalho
    last_name,
    CASE
        WHEN gender = 'M' THEN 'male'
        ELSE 'female'
    END AS gender
FROM
    employees;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;

SELECT 													#IF eu só posso usar uma única condição e essa é a principal diferença entre
    emp_no,												#IF e CASE
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender		#(coloco a condição, caso seja verdadeiro retorna isso, caso seja falso retorna isso)
FROM
    employees;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30.000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more then $20.000, but less then $30.000'
        ELSE 'Salary was raised by less then $20.000'
    END AS salary_increase
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

-- EX 251- criar uma case que retorne o nome completo e n° do empregado de todos os empregados c/ n° > 109990, 
# criar uma quarta coluna indicando se é Manager ou Regular Employee
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Regular Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;
    
-- EXP 253- retornar do dept_manager nome completo, n° e adcionar a diferença salarial e se está acima de 30.000 ou não
# fazer por dois métodos (if e case)
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised more then $30.000'
        ELSE 'Salary was raised less then $30000'
    END AS salary_raise
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diference,
    IF(MAX(s.salary) - min(s.salary) >30000, 'Salary raised more then $30.000', 'Salary raised less then $30.000') AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY s.emp_no;

-- EX 255- retornar nome completo e n° dos 100 primeiros empregados e na 4° coluna se ainda estão empregados ou nãoptimize
SELECT 
    d.emp_no,
    e.first_name,
    e.last_name, d.to_date,
    CASE
        WHEN d.to_date >= DATE_FORMAT(SYSDATE(), '%y-%m-%d') THEN 'Is still Employed'
        ELSE 'Not an employee anymore'
    END AS emp_situation
FROM
    employees e
        JOIN
    dept_emp d ON e.emp_no = d.emp_no
group by d.emp_no
LIMIT 100;