/* EX 281- Você deve criar uma stored procedure que contenha o salário médio de homens e mulheres separados por departamento e esse salário 
deve estar contido dentro de um intervalo (acima de 50k e abaixo de 90k). */
use employees_mod;

drop procedure if exists filter_salary;

DELIMITER $$
CREATE PROCEDURE filter_salary(in p_min_salary float, in p_max_salary float)
BEGIN
	SELECT e.gender, d.dept_name, avg(s.salary) as avg_salary 
    from t_salaries s join t_employees e  on s.emp_no = e.emp_no
    join t_dept_emp de on de.emp_no = e.emp_no
    join t_departments d on d.dept_no = de.dept_no
    where s.salary between p_min_salary and p_max_salary
    
    group by d.dept_no, e.gender;

END$$
DELIMITER ;

call filter_salary(50000,90000);