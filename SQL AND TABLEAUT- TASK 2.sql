-- EX 271- Compare o n° de gerentes homens e mulheres ao longo dos anos e monte um gráfico de área 
SELECT d.dept_name,
ee.gender, dm.emp_no, dm.from_date, dm.to_date, e.calendar_year,
case
	when YEAR(dm.to_date) >=e.calendar_year and year(dm.from_date) <= e.calendar_year then '1'
    else '0' 
    end as active
from 
	(select year(hire_date) as calendar_year
    from t_employees 
    group by calendar_year) e
    cross join t_dept_manager dm 
    join t_departments d on d.dept_no = dm.dept_no
    join t_employees ee on dm.emp_no = ee.emp_no
    
    order by dm.emp_no, calendar_year;