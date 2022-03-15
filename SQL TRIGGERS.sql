#vamos criar um BEFORE INSERT TRIGGER
commit;

DELIMITER $$

CREATE TRIGGER before_salaries_insert		#declarei o nome da trigger, a tabela e como ela se dará
BEFORE INSERT ON salaries					#aqui declarei qual a tabela será usada para base da trigger
for each row								#aqui que deve ser observado cada linha e seguir a trigger
BEGIN 
	IF NEW.salary <0 then
    SET NEW.salary = 0;
	END IF;
END$$
DELIMITER ;

SELECT 
    *
FROM						#criei um novo contrato do employee 10001 apenas para verificar se de fato funcionou o salário negativo
    salaries				#a trigger automaticamente impediu que o salário fosse negativo.
WHERE
    emp_no = '10001';
  
insert into salaries values ('10001', '-92891', '2010-06-22', '9999-01-01');

#vamos criar agora um BEFORE UPDATE TRIGGER
DELIMITER $$
CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries				#criei a trigger e agora sempre que dar um update ela irá ser executada
FOR EACH ROW							#caso o salário seja igual a 0, ele deverá trazer o ultimo salário como o valor da tabela
BEGIN										
	IF NEW.salary <0 THEN
    SET NEW.salary = OLD.salary;
	END IF;
END$$
DELIMITER ;

UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

SELECT 
    *
FROM						#vou verificar o salário atual e em seguida dar um update de um salario negativo
    salaries				
WHERE
    emp_no = '10001' and from_date= '2010-06-22';

UPDATE salaries 
SET 
    salary = -50000							#mesmo dando o UPDATE, a trigger retornou o salário informado anteriormente de 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

#agora irei aprender system functions ou built-in functions
#a primeira coloca a data em que o código é executado

select sysdate();

# a segunda executa o formato da data
select date_format(sysdate(), '%d - %m - %y') as today;

# agora irei usar uma trigger mais complexa com condicional
#imagine que um empregado foi promovido a gerente e irá ganhar 20.000 a mais por ano, devo atualizar a base de dados e  
#utilizar uma trigger que faça a data término do contrato ser a mesma que a data de início do novo onde será a data de execução do código
#primeiramente será atualizado o dept_manager, porém a tabela salaries também será atualizada com isso

DELIMITER $$
CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary INT;
    
SELECT 
    MAX(salary)
INTO v_curr_salary FROM
    salaries
WHERE
    emp_no = NEW.emp_no;
    
		IF v_curr_salary IS NOT NULL THEN
			UPDATE salaries
			SET to_date = sysdate()
			WHERE emp_no=NEW.emp_no and to_date=NEW.to_date	;
    
    INSERT INTO salaries VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    
    END IF;
END$$
DELIMITER ;

INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01'); 

SELECT * FROM dept_manager WHERE emp_no= 111534;
SELECT * FROM salaries WHERE emp_no= 111534;

-- EX 243- criar uma trigger que verifica se a data de contrato é maior que a data atual e atualiza diretamente para a data atual;
DELIMITER $$
CREATE TRIGGER trig_ins_check_hire_date
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN
    SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%m-%d');
    END IF;

END$$
DELIMITER ;

#vamos verificar
INSERT INTO employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT * FROM employees WHERE emp_no= 999904;