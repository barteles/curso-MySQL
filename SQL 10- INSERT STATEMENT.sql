-- EX 126- selecionar TItles, entender tabela, depois criar funcionário 999903 como senrior engineer que trabalha desde 1° out 1997
SELECT 
    *
FROM
    titles
GROUP BY title
LIMIT 10
;

insert into employees
values
(999903,
'1973-11-11',
'John',
'Smith',
'M',
'1997-10-01');

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;

insert into titles
(emp_no, title, from_date)
values 
(
	999903,
    'Senior Engineer',
    '1997-10-01');
    SELECT 
    *
FROM
    titles
GROUP BY emp_no
order by emp_no desc
LIMIT 10
;
-- EX 128-  inserir mais informações, agora que o trab 999903 trabalha no dept 5
insert into dept_emp
(emp_no, dept_no, from_date, to_date)
values 
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01');

-- Ex 130- duplicar informações tirando uma informação de uma tabela diretamente para outra
create table deptartments_dup
(
	dept_no char(4) not null,
    dept_name varchar(255) not null
    );

INSERT INTO deptartments_dup
(dept_no, dept_name)
SELECT * 
from departments;
ALTER TABLE deptartments_dup 
RENAME departments_dup;
-- EX 131- Inserir um novo departamento chamado Busisness alanysis como d010

INSERT INTO departments 
values ( 'd010', 'Business Analysis');

select * from departments order by dept_no;