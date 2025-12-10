/*  Acumulo por cliente, ordenado por dia. 
    Depois, o calculo de tendencia (aumento ou diminuição por dia) */


WITH tb_cliente_dia AS(

       SELECT idCliente, 
              substr(DtCriacao, 1, 10) AS dtDia, 
              count(DISTINCT IdTransacao) as qtdeTransacao
       
       FROM transacoes
       
       WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'
       
       GROUP BY idCliente, dtDia

),

tb_lag AS(

    SELECT *, 
       sum(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) AS acumuloPorCliente,
       
       -- traz a comparação dia a dia
       
       lag(qtdeTransacao) OVER (PARTITION BY idCliente ORDER BY dtDia) AS lagTransacao


    FROM tb_cliente_dia


)


-- o percentual 
SELECT *, 
        1.* qtdeTransacao/lagTransacao

FROM tb_lag