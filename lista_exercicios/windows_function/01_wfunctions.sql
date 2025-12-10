/* Quantidade de transações acumuladas ao longo do tempo (diariamente) */

WITH tb_curso_dias AS(
    
    SELECT substr(DtCriacao, 1, 10) as qtDias, 
           count(DISTINCT IdTransacao) as qtTransacoes
    FROM transacoes
    GROUP BY qtDias

),

tb_transAcumuladas AS (
    SELECT *,
     sum(qtTransacoes) OVER (ORDER BY qtDias) AS transacoesAcum

    FROM tb_curso_dias
)


SELECT * FROM tb_transAcumuladas

    
