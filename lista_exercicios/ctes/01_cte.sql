/* Qual foi a curva de Churn no Curso de SQL */

/* 
    a forma que nao é a aconselhada a fazer, porque não tem como saber quem esteve presente desde o primeiro dia
    pode ter pessoas que começou o curso no segundo dia, ou seja, nao está contida no primeiro.
    
    serve mais como uma busca para saber o engajamento:


    SELECT substr(DtCriacao, 1, 10) AS dtDia, count(DISTINCT idCliente) AS qtdeCliente
    FROM transacoes 
    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-30'
    GROUP BY dtDia


1. * count(DISTINCT t1.idCliente) / (select count(*) FROM tb_clientes_d1)

*/


WITH tb_clientes_d1 AS(
    SELECT DISTINCT idCliente
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25' AND DtCriacao < '2025-08-26'
)

tb_join AS(
    SELECT substr(t2.DtCriacao, 1, 10) AS dtDia, 
    count(DISTINCT t1.idCliente) AS qtdeCliente,

    -- quant de cliente por dia / total de clientes do meu primeiro dia (254/452)
    -- qual a % de retenção? (sempre em relação ao primeiro dia) 
    1. * count(DISTINCT t1.idCliente) / (select count(*) FROM tb_clientes_d1) AS Retencao,
    1-1. * count(DISTINCT t1.idCliente) / (select count(*) FROM tb_clientes_d1) AS Churn
        
    FROM tb_clientes_d1 AS t1
    LEFT JOIN transacoes AS t2 ON t1.idCliente = t2.idCliente

    WHERE t2.DtCriacao >= '2025-08-25' AND t2.DtCriacao < '2025-08-30'
    GROUP BY dtDia

)







