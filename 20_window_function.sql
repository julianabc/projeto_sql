
-- pega os clientes apenas de 2025
WITH tb_cliente_dia AS(

       SELECT DISTINCT idCliente, 
              substr(DtCriacao, 1, 10) AS dtDia
       
       FROM transacoes
       
       WHERE substr(DtCriacao, 1, 4)='2025'
       
       GROUP BY idCliente, dtDia

),

-- faz a comparação de dia por cliente e com a ordenação por dia
tb_lag AS(

    SELECT *, 
      lag(dtDia) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagDia


    FROM tb_cliente_dia


), 


-- faz a diferença de dia 
tb_diff_dt AS (
    
    SELECT *,
    julianday(dtDia) - julianday(lagDia) as DtDiff
    FROM tb_lag

),


-- apresenta a media de dias por cliente

tb_avg AS (
    
    SELECT idCliente, avg(DtDiff) as avgDia
    FROM tb_diff_dt
    GROUP BY idCliente
)


-- a media geral

SELECT avg(avgDia) as avgTotal
FROM tb_avg