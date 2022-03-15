-- EX 169- criar e inserir informações na coluna dept_manager
ALTER TABLE departments_dup 
modify dept_name VARCHAR(40) NULL;

SELECT 
    *
FROM
    dept_manager_dup
    order by dept_no;

insert into departments_dup
(dept_name) values ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_name = 'Public Relations';

drop table if exists dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date VARCHAR(10) NOT NULL,
    to_date VARCHAR(10) NULL
);

insert into dept_manager_dup select * from dept_manager;

insert into dept_manager_dup (emp_no, from_date) 
values (999904, '2017-01-01'),
(999905, '2017-01-01'), 
(999906, '2017-01-01'), 
(999907, '2017-01-01');

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

-- EXP 171- utilizar o INNER JOIN para juntar as informações do dep_manager_dup e departments_dup
-- dep_manager _dup será chamado de 'm' e departments_dup de 'd' para facilitar e agilizar (usando aliases ou 'AS')

SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

-- Ex 172- extrair os primeiro e ultimo nome, número do trabalhador, dept_no e hire_date
SELECT 
    e.emp_no, e.first_name, e.last_name, e.hire_date, d.dept_no
FROM
    employees e
        INNER JOIN
    dept_emp d ON e.emp_no = d.emp_no
ORDER BY e.emp_no;

# LEFT JOIN (a ordem importa)
-- executar um left join entre dept_manager_dup e departments_dup 
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

-- Ex 178- fazer join do employees e dept_manager e retornar todos os empregados com sobrenome Markovitch
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
       left JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC, e.emp_no;
# a única gerente é a Margareta, porém esse left join trouxe todos os empregados com o sobrenome procurado.

-- EX 182- Retirar todos os dados dos managers usando a sintaxe antiga WHERE e compare com o Join
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager d
WHERE
    e.emp_no = d.emp_no
ORDER BY e.emp_no;

SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        JOIN
    dept_manager d ON e.emp_no = d.emp_no
ORDER BY e.emp_no;

-- EX 186- selecionar nome, sobrenome e data de contratação e título de todo empregado chamado Margareta Markovitch
SELECT 
    e.first_name, e.last_name, t.title, e.hire_date
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

-- EXP 188- Crossjoin (pega todos os dados de uma tabela e junta com os dados de outra tabela)
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;
# agora faremos o mesmo, porém não retornando o departamento atual dos gerentes
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    dm.dept_no <> d.dept_no
ORDER BY dm.emp_no , d.dept_no;

-- EX 189- retornar todas as combinações possíveis entre dept_manager table e o departamento 09
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY dm.dept_no;

-- EX 192- retornar os 10 primeiros empregados e todos os departamentos que podem ser mandados sem usar Limit
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

-- EXP 193- Seu chefe pede o salário médio de funcionários por gênero
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

-- EXp 194- juntar 3 tabelas ao mesmo tempo Employees, dept_manager e departments
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d 
    ON dm.dept_no = d.dept_no;
    
-- Ex 195- selecionar os nomes de todos os gerentes, título, dia de contratação, from_date e o nome do departamento
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
    where t.title = 'Manager'
    order by e.emp_no;
    -- EXP 197- obter o salário médio por departamento
    SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;

-- EX 198- quantos gerentes homens e mulheres temos na base de dados?
SELECT 
    e.gender, COUNT(m.emp_no) AS emp_per_gender
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY gender;

-- EX 202- UNION e UNION ALL
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees e
WHERE
    e.last_name = 'Denis' 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    dm.dept_no,
    dm.from_date
FROM
    dept_manager dm as a
ORDER BY -a.emp_no DESC;
# não entendi o erro, não foi possível rodar essa query