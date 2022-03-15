-- ExP214- SELF JOIN, vou tentar encontrar 2 linhas contendo somente os gerentes gerais 110022 e 110039
SELECT 
    *
FROM
    emp_manager
ORDER BY emp_manager.emp_no;

# irei seguir o passo a passo do vídeo
# 01
SELECT 
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
    -- aqui o resultado não foi satisfatório, pois só retornou os dados da tabela e1, se inverter e1 por e2, só retornará e2
    SELECT 
    e1.emp_no, e1.dept_no, e2.manager_no
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
-- o código funcionou, mas não resolveu o que eu buscava, portanto usarei DISTINC para trazer somente 2 resultados
    SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
-- esse trouxe o resultado, mas uma maneira mais profissional seria:
 SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no			#perfeito aqui
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager);
#perfeito