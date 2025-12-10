/* Saldo de pontos acumulado de cada usuario */

-- usar transacoes para poder olhar para um tempo mais antigo
WITH tb_clientes_dias AS (
    
    SELECT idCliente, substr(DtCriacao, 1, 10) AS Dias,
        sum(qtdePontos) AS totalPontos,
        -- apenas pontos positivos
        sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS pontosPositivos
    FROM transacoes
    GROUP BY idCliente, Dias
    
)


SELECT *, 
       sum(totalPontos) OVER (PARTITION BY idCliente ORDER BY Dias) AS saldoFinal,

       -- apenas positivos (nunca vai diminuir)
       sum(pontosPositivos) OVER (PARTITION BY idCliente ORDER BY Dias) AS totalPontosPositivo
FROM tb_clientes_dias



