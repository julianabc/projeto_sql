/*Qual dia da semana mais ativo de cada usuário*/

WITH tb_curso_dias AS(
    
    SELECT idCliente, strftime('%w', substr(DtCriacao, 1, 10)) AS DiaSemana, 
           count(DISTINCT IdTransacao) AS qtTransacoes
    FROM transacoes
    GROUP BY idCliente, DiaSemana

),

tb_rn AS (

    SELECT *,
        row_number() OVER (PARTITION BY idCliente ORDER BY qtTransacoes DESC, DiaSemana) AS rn
    FROM tb_curso_dias

)

SELECT * FROM tb_rn
WHERE rn=1