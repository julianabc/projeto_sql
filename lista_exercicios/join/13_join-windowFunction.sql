-- Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?


-- separa o primeiro dia
WITH alunos_dia01 AS(

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1,10)='2025-08-25'

),


-- cruza todos os dias do curso, agrupa e ordena por cliente e dia
tb_dia_cliente AS (
    
    SELECT t1.idCliente,
           substr(t2.DtCriacao, 1, 10) AS dtDia, 
           count(*) AS qtdeInteracoes
    FROM alunos_dia01 AS t1
    LEFT JOIN transacoes AS t2 ON t1.idCliente=t2.idCliente
    AND t2.DtCriacao >= '2025-08-25' AND t2.DtCriacao < '2025-08-30' -- esse AND se refere a tabela do JOIN (transacoes)

    GROUP BY t1.idCliente, substr(t2.DtCriacao, 1, 10)
    ORDER BY t1.IdCliente, dtDia

),


/* enumera linhas em ordem decrescente para sempre ter o maior como o primeiro valor,
   pois, pode haver perda de clientes nos dias posteriores ao primeiro dia
*/

tb_rn AS (

    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtdeInteracoes DESC, dtDia) AS rn
    FROM tb_dia_cliente

)

SELECT * FROM tb_rn
WHERE rn=1