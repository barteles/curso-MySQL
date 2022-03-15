-- EXP 262- você deve retornar o número de empregados homens e mulheres de cada ano até 2002
SELECT 
YEAR(d.from_date) as Calendar_year, e.gender, count(e.emp_no) as Num_of_employees

FROM t_employees e
join t_dept_emp d on d.emp_no=e.emp_no
group by Calendar_year, e.gender
HAVING Calendar_year >=1990
order by Calendar_year;