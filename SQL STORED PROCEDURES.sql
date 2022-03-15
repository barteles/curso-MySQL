-- EXP 219 aqui aprenderemos  usar STORED PROCEDURES que agilizam a obtenção de dados comuns no dia a dia que outros usuários precisam.
use employees;     		#só para garantir que está usando a base de dados correta

drop procedure if exists select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
		SELECT * FROM employees
        limit 1000;
END$$

DELIMITER ;

-- EXP 221- como invocar uma stored procedure
CALL employees.select_employees();

#como já usamos o use employees e selecionamos a base de dados anteriormente, podemos ir direto para

CALL select_employees();

-- EX 222- Criar uma procedure que providencia o salário médio de todos os empregados e depois retorne-a;
DROP PROCEDURE IF EXISTS avg_salary;

DELIMITER $$
CREATE PROCEDURE avg_salary()
begin
		select round(avg(salary),2) from salaries;
end$$

delimiter ;

CALL avg_salary();

-- EXP 225- criando uma procedure não paramétrica

drop procedure if exists emp_salary;

delimiter $$
create procedure emp_salary(in p_emp_no INTEGER)
begin 
		select 
			e.first_name, e.last_name, s.salary, s.from_date, s.to_date
		from 
        employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no;
END$$

delimiter ;

delimiter $$
create procedure emp_avg_salary(in p_emp_no INTEGER)
begin 
		select 
			e.first_name, e.last_name, avg(salary)
		from 
        employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no;
END$$

delimiter ;

call emp_avg_salary(11300);					#somente para mostrar como retornar um valor usando uma linha de código

-- EXP 226- Executar uma OUT procedure
delimiter $$
create procedure emp_avg_salary_out(in p_emp_no INTEGER, out p_avg_salary decimal(10,2))
begin 
		select 
			avg(salary) into p_avg_salary
		from 
        employees e
        join salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no;
END$$

delimiter ;

-- EX 227- criar uma procedure chamada emp_info que usa o nome e sobrenome como parametros e retorna o emp_no

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name VARCHAR(255), in p_last_name VARCHAR(255), out p_emp_no INTEGER)
BEGIN
SELECT e.emp_no INTO p_emp_no from employees e 							#eu selecionei o termo que será o valor de retorno no p_emp_no
	WHERE e.first_name = p_first_name and e.last_name = p_last_name;	#no in eu informo um valor e no OUT eu devo informar o que ele deve retornar.
END$$
DELIMITER ;

-- EX 230- criar uma variável v_emp_no para salvar o output do processo do exercício anterior e procurar por Aruna Journel entre os empregados
set @v_emp_no = 0;											#aqui eu criei uma variável e dei um valor arbitrário para ela
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);		#aqui eu joguei a info que eu queria e mandei substituir na variável criada
SELECT @v_emp_no;											#aqui ela retornou a informação que eu precisava.

-- EXP 232- FUNCTIONS

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC										#isso serve para evitar o ERROR 1418
BEGIN 
DECLARE v_avg_salary DECIMAL(10,2);					#criei uma variável através do DECLARE, determinei o tipo de data que ela é e depois
													#selecionei o que quero que seja informado nesta variável como OUTPUT
	SELECT avg(s.salary) into v_avg_salary			#no final ela deve retornar o salário médio como especificado.
		from employees e
		join salaries s on e.emp_no = s.emp_no
		where e.emp_no = p_emp_no;
        
RETURN v_avg_salary;
END$$
DELIMITER ;

-- EX 234- Criar uma função que usa primeiro e segundo nome e retornam o salário do mais novo contrato
DELIMITER $$ 
CREATE FUNCTION f_emp_salary (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS  DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_emp_salary DECIMAL(10,2);
DECLARE v_max_from_date DATE;

SELECT 
    MAX(s.from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

SELECT 
    s.salary
INTO v_emp_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;

RETURN v_emp_salary;
END$$
DELIMITER ;

