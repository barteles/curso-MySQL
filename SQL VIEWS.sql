-- EXP 215 irei criar uma view do contrato mais recente dos empregados para facilitar a visualização dos dados
SELECT 
    *
FROM						#aqui obtive 331603 linhas de retorno com mais de 1 data de contrato de alguns empregados
    dept_emp;
    
SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS num
FROM													#aqui eu apenas contabilizei quantos tem mais de 1 contrato e quais são eles
    dept_emp
GROUP BY emp_no
HAVING num > 1;

#agora irei criar a view
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 																#para verifica-lo agora só basta ir no navegador e procurar views
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date	#lá trará todas as views e você terá acesso para verificar os dados
    FROM																#isso é interessante quando vc só quer deixar as pessoas verificarem os dados e
        dept_emp														#agilizar o processo necessitando menos comandos e assim menos espaço necessário
    GROUP BY emp_no;
    
SELECT 
    emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM																	#aqui é para verificar se está tudo certo e o retorno foi
    dept_emp															#300024 rows e trouxe os ultimos contratos de cada empregado
GROUP BY emp_no;														#esse será o display que o VIEW trará toda vez

/* EX 216- criar um view do salário médio de cada gerente, arredondando-o para a casa dos centavos */

CREATE OR REPLACE VIEW v_avg_manager_salary AS
SELECT 
    ROUND(AVG(s.salary),2) AS average_salary
FROM
    salaries s
        JOIN
    dept_manager dm
ON
    s.emp_no = dm.emp_no;