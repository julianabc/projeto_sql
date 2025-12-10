/* Quantidade de usuarios cadastrados (absoluto e acumulado) ao longo do tempo*/


WITH tb_curso_clientes AS (
    SELECT substr(DtCriacao,1,10) AS Dias, 
        count(DISTINCT idCliente) AS qtClientes 
    FROM clientes
    GROUP BY Dias
),

tb_clientes_acumulados AS (

    SELECT *,
            sum(qtClientes) OVER (ORDER BY Dias) AS qtdClientesAcum
    FROM tb_curso_clientes

)

SELECT * FROM tb_clientes_acumulados