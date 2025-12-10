/* 11 - Quem iniciou o curso no primeiro dia, em media, assistiu quantas aulas? */


-- quem participou da primeira aula
WITH tb_prim_dia AS (
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10)='2025-08-25'
), 

-- quem participou do curso inteiro
tb_dias_curso AS (
    SELECT DISTINCT idCliente, substr(DtCriacao, 1, 10) AS presenteDia
    FROM transacoes
    WHERE DtCriacao >='2025-08-25' AND DtCriacao < '2025-08-30'
    ORDER BY idCliente, presenteDia
),


-- contando quantas vezes quem participou do primeiro dia, voltou

tb_clientes_dias AS(
    SELECT t1.idCliente, count(DISTINCT t2.presenteDia) as qtdeDias
    FROM tb_prim_dia AS t1
    LEFT JOIN tb_dias_curso AS t2 ON t1.idCliente = t2.idCliente
    GROUP BY t1.idCliente

)

-- calcula a media

SELECT avg(qtdeDias), max(qtdeDias), min(qtdeDias)
FROM tb_clientes_dias;



