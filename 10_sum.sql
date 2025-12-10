SELECT sum(QtdePontos)
FROM transacoes
WHERE DtCriacao >='2025-07-01' AND DtCriacao < '2025-08-01' AND QtdePontos > 0 


-- exemplo de separação entre valores positivo e negativos

SELECT sum(QtdePontos),

        sum(CASE
            WHEN QtdePontos > 0 THEN QtdePontos 
            END) AS qtdePontosPositivos,
        
        sum(CASE
            WHEN QtdePontos < 0 THEN QtdePontos 
            END) AS qtdePontosNegativos 


FROM transacoes
WHERE DtCriacao >='2025-07-01' AND DtCriacao < '2025-08-01'