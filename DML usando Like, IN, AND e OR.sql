-- aqui eu seleciono apenas aquilo que me interessa
SELECT 
    dept_no
FROM
    departments
    ;
    
-- aqui eu seleciono todas as informações referentes à tabela departments
select * from departments;

-- agora irei selecionar com condicionais, neste caso, todos os chamados Elvis da tabela employees

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
    
-- aqui irei usar o OPERADOR AND na condicional, ele me deixa colocar mais de uma condição de busca no WHERE
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Kellie' AND gender = 'F';
-- o OPERADOR AND deve usar informação de diferentes colunas e o OR de colunas iguais
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');
   -- para conseguir usar mais de um condicional (AND e OR) vc precisa separar por () para não atrapalhar o fluxo de de precedÊncia AND > OR
   
   -- caso eu queira pegar inforamações de 3 funcionários com nomes diferentes, ao invés de usar OR 3x, eu uso o IN
   -- além disso, IN é mais rápido para conseguir trazer a informaçaõ do que vários OR ou AND
   
   SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis', 'Elvis');
    -- o Contrário de IN trará todos os resultados que não contenham os nomes que busco:
       SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Jacob', 'Mark');
    
    -- ao usar o OPERADOR LIKE eu procuro por padrões parecidos com o que busco, por exemplo, caso eu queira
    -- buscar alguém com parte do nome tendo MAR (Marcos, Mark, Amaro) eu usarei o sinal de %, ele indicará quais as
    -- sequências irão aparecer, sendo antes de MAR ele vai completar o nome com letras antes, sendo depois ele irá procurar nomes depois de MAR
    -- sendo antes e depois ele irá procurar qualquer nome que tenha MAR em qualquer posição:
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%mar');
    
    SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mar%');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
-- se eu usar NOT LIKE, ele irá procurar nomes que não possuam tais caracteres
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%mar');

-- caso eu use _ ao invés de % ele irá somente procurar nomes que tenha 1 caracter para completar a procura, por exemplo:
-- Mar_ (Marc, Marv, Marl, Mary)
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mar_');
    
-- exercício de LIKE (87), 1- procurar por pessoas que o nome começa com MARK e sequência aberta, 2- procurar por pessoas contratadas no ano 2000
-- 3- procurar por pessoas que tenham o número de empregado a partir de 1000 e com 5 digitos
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('mark%');

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');
    
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
/* Ex 93- 1- Obter salários da tabela Salaries de 66k até 70k/ano
 2-Recuperar os indivíduos que o employee number não esteja contido entre 10004 e 10012.
 3- selecionar os departamentos com números entre d003 e d006 */
SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN '60000' AND '70000';

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

-- Ex 96; selecionar os departamentos que não estejam com nome "nulo"
SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
    
/* ex 99: 1- pegar todas as trabalhadoras mulheres contratadas a partir de 2000
2- extrair uma lista de trabalhadores que recebem mais do que 150k */
SELECT 
    *
FROM
    employees
WHERE
    gender = 'F' AND hire_date >= '2000-01-01';
    
SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';

-- Ex 102: 1- selecionar todas as datas de contrato da employee table
SELECT 
    hire_date
FROM
    employees;

/* Ex105: 1- quantos contratados ganham igual ou mais que $100k
2- quantos gerentes temos na base de dados employees? */
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= '100000';

SELECT 
    COUNT(*)
FROM
    dept_manager;
-- Ex 108: ordernar a lista de empregados pela data de contratação descendente.
SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

/* Ex 112: Escrever query com 2 colunas. A 1° deve conter salários maiores que 80k e a segunda ser renomeada 'emps_with_same_salary' e 
mostrar o número de empregados com o mesmo salário */

SELECT 
    salary, COUNT(emp_no) AS 'emp_with_same_salary'
FROM
    salaries
WHERE
    salary > '80000'
GROUP BY salary
ORDER BY salary;

-- EX 115- Selecionar todos os trab que recebem a média salarial maior que 120k
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > '120000'
ORDER BY emp_no;
-- EX 119- selecionar todos os empregados que assinaram mais de 1 contrato depois de 1° de janeiro de 2000
SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) >1
ORDER BY emp_no;
-- EX 122- selecionar as 100° linhas do dept_emp table
SELECT 
    *
FROM
    dept_emp
LIMIT 100;