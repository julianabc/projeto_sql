
/* Dentre os clientes de janeiro/25, quantos assistiram o curso de SQL */


/* passo a passo: */


-- todo mundo que é janeiro:

WITH tb_clientes_janeiro AS(

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 7)='2025-01'

),


-- todo mundo que estava no curso
tb_clientes_curso AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'
),


tb_join_tables AS (
    SELECT count(DISTINCT t1.idCliente) AS clienteJaneiro,
           count(DISTINCT t2.idCliente) AS clienteCurso
    FROM tb_clientes_janeiro AS t1
    LEFT JOIN tb_clientes_curso AS t2 ON t1.idCliente=t2.idCliente

)

SELECT * FROM tb_join_tables




/* maneira mais direta: */


WITH tb_clientes_janeiro AS(

    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 7)='2025-01'

)

SELECT count(DISTINCT t1.idCliente) AS clienteJaneiro,
           count(DISTINCT t2.idCliente) AS clienteCurso
FROM tb_clientes_janeiro AS t1

-- necessario fazer essa condiçao dentro do proprio JOIN
-- where, nesse caso, estava filtrando a pós o join (ou seja, perdendo valor da t1)
LEFT JOIN transacoes AS t2 ON t1.idCliente=t2.idCliente
AND t2.DtCriacao >= '2025-08-25' AND t2.DtCriacao < '2025-08-30'





