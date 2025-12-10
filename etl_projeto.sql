
-- obs: criar tabela a partir do que foi feito aqui     


/* Quantidade de Transacoes historicas: */

-- separar os campos para facilitar o case when logo após
WITH tb_transacoes AS(
    SELECT IdTransacao, idCliente, QtdePontos,
          datetime(substr(dtCriacao, 1, 19)) AS dataCriacao,
          julianday('{date}') - julianday(substr(dtCriacao,1,10)) AS diffDate, 
          CAST(strftime('%H', substr(dtCriacao,1,19)) AS INTEGER) AS dtHora
    
    FROM transacoes
    WHERE dtCriacao < '{date}' -- deixar a data dinamica para o script de python
), 

-- definir idade base (quando foi registrado para o agora)
tb_cliente AS(
     SELECT idCliente,
     datetime(substr(dtCriacao, 1, 19)) AS dataCriacao,
     julianday('{date}') - julianday(substr(dtCriacao,1, 10)) AS idadeBase
     
     FROM clientes
),

tb_sumario_transacoes AS(
     --- vida e as separações dentro do count
     SELECT idCliente,
          count(*) AS qtdTransacoesVida,
          --- vida e as separações dentro do count
          count(CASE WHEN diffDate <= 56 THEN IdTransacao END)  AS qtdeTransacoes56,
          count(CASE WHEN diffDate <= 28 THEN IdTransacao END)  AS qtdeTransacoes28,
          count(CASE WHEN diffDate <= 14 THEN IdTransacao END)  AS qtdeTransacoes14,
          count(CASE WHEN diffDate <= 7 THEN IdTransacao END)  AS qtdeTransacoes7,
          
          -- saber a menor diferença (pensar em idade, por exemplo)8

          -- quantidade de pontos atual
          sum(qtdePontos) as saldoPontos,

          min(diffDate) AS diasUltimaInteracao,

          -- quant de pontos posistivos nas transacoes historicas:
          sum(CASE WHEN qtdePontos > 0 THEN qtdePontos ELSE 0 END) AS qtdePontosPositivosVida,
          sum(CASE WHEN qtdePontos>0 AND diffDate<=56 THEN qtdePontos ELSE 0 END) AS qtdePontosPositivos56,
          sum(CASE WHEN qtdePontos>0 AND diffDate<=28 THEN qtdePontos ELSE 0 END) AS qtdePontosPositivos28,
          sum(CASE WHEN qtdePontos>0 AND diffDate<=14 THEN qtdePontos ELSE 0 END) AS qtdePontosPositivos14,
          sum(CASE WHEN qtdePontos>0 AND diffDate<=7 THEN qtdePontos ELSE 0 END) AS qtdePontosPositivos7,

          -- quant de pontos negativos nas transacoes historicas:
          sum(CASE WHEN qtdePontos < 0 THEN qtdePontos ELSE 0 END) AS qtdePontosNegativosVida,
          sum(CASE WHEN qtdePontos < 0 AND diffDate <= 56 THEN qtdePontos ELSE 0 END) AS qtdePontosNegativos56,
          sum(CASE WHEN qtdePontos < 0 AND diffDate <= 28 THEN qtdePontos ELSE 0 END) AS qtdePontosNegativos28,
          sum(CASE WHEN qtdePontos < 0 AND diffDate <= 14 THEN qtdePontos ELSE 0 END) AS qtdePontosNegativos14,
          sum(CASE WHEN qtdePontos < 0 AND diffDate <= 7  THEN qtdePontos ELSE 0 END) AS qtdePontosNegativos7

     FROM tb_transacoes
     GROUP BY idCliente

),


/* Produtos mais usados:*/

-- relacionada a transação produto
tb_transacao_produto AS (
     SELECT t1.*,
            t3.DescNomeProduto,
            t3.DescCategoriaProduto

     FROM tb_transacoes AS t1
     
     
     LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao=t2.IdTransacao

     LEFT JOIN produtos AS t3 ON t2.idProduto=t3.idProduto

     
),

tb_cliente_produto AS(

     SELECT idCliente, DescNomeProduto,
          count(*) AS qtdeVida, 
          count(CASE WHEN diffDate<=56 THEN idTransacao END) AS qtde56,
          count(CASE WHEN diffDate<=28 THEN idTransacao END) AS qtde28,
          count(CASE WHEN diffDate<=14 THEN idTransacao END) AS qtde14,
          count(CASE WHEN diffDate<=7  THEN idTransacao END) AS qtde7 

     FROM tb_transacao_produto
     GROUP BY idCliente, DescNomeProduto 

),

tb_cliente_produto_rn AS(

     SELECT *, 
          row_number() OVER (PARTITION BY idCliente ORDER BY qtdeVida DESC) AS rnVida,
          row_number() OVER (PARTITION BY idCliente ORDER BY qtde56 DESC) AS rn56,
          row_number() OVER (PARTITION BY idCliente ORDER BY qtde28 DESC) AS rn28,
          row_number() OVER (PARTITION BY idCliente ORDER BY qtde14 DESC) AS rn14,
          row_number() OVER (PARTITION BY idCliente ORDER BY qtde7 DESC) AS rn7

     FROM tb_cliente_produto
),




/* Dias da semana mais ativo (DB28) */

-- vem zerado porque essa quant de dias já passou

tb_cliente_dia AS(
     
     SELECT idCliente, 
     strftime('%w', dataCriacao) AS dtDia, 
     count(*) AS qtdTrasancao
FROM tb_transacoes
WHERE diffDate <=28
GROUP BY idCliente, dtDia

),

tb_cliente_dia_rn AS (

     SELECT *,
     row_number() OVER (PARTITION BY idCliente ORDER BY qtdTrasancao DESC) AS rnDia
     FROM tb_cliente_dia


),

/* Perido do dia mais ativo d28*/

tb_cliente_periodo AS (

    SELECT 
        idCliente,
        CASE
            WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
            WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
            WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
            ELSE 'MADRUGADA'
        END AS periodo,
            COUNT(*) AS qtdeTransacao

    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1,2 -- significa cliente e depois qtdeTransacao

),


tb_cliente_periodo_rn AS (

    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY idCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo

    FROM tb_cliente_periodo

),



tb_join AS(

     -- como estão em tabelas diferentes, necessário cruzar as tabelas
     SELECT t1.*, 
            t2.idadeBase,
            t3.DescNomeProduto AS produtoVida,
            t4.DescNomeProduto AS produto56,
            t5.DescNomeProduto AS produto28,
            t6.DescNomeProduto AS produto14,
            t7.DescNomeProduto AS produto7,
            COALESCE(t8.dtDia, -1) AS dtDia,
            COALESCE(t9.periodo, 'SEM INFORMACAO') AS periodoMaisTransacao28
     
     FROM tb_sumario_transacoes AS t1
     LEFT JOIN tb_cliente AS t2 ON t1.idCliente=t2.idCliente


     /* Continuação do produto mais usado*/
     -- cruzamento para cada separação para ter o cliente sem repetição
     LEFT JOIN tb_cliente_produto_rn AS t3 ON t1.idCliente = t3.idCliente AND t3.rnVida=1
     LEFT JOIN tb_cliente_produto_rn AS t4 ON t1.idCliente = t4.idCliente AND t4.rn56=1
     LEFT JOIN tb_cliente_produto_rn AS t5 ON t1.idCliente = t5.idCliente AND t5.rn28=1
     LEFT JOIN tb_cliente_produto_rn AS t6 ON t1.idCliente = t6.idCliente AND t6.rn14=1
     LEFT JOIN tb_cliente_produto_rn AS t7 ON t1.idCliente = t7.idCliente AND t7.rn7=1


     -- relacionado a quantidade de dias mais ativos (vai zerar porque nao existe dados nos ultimos 28 dias)
     LEFT JOIN tb_cliente_dia_rn AS t8 ON t1.idCliente = t8.idCliente AND t8.rnDia=1


     -- relacionado a periodo
     LEFT JOIN tb_cliente_periodo_rn AS t9 ON t1.idCliente = t9.idCliente AND t9.rnPeriodo = 1


)


--- ultima questão Engajamento em D28 versus Vida

SELECT 
        '{date}' AS dtRef,
        *,
        1. * qtdeTransacoes28 / qtdeTransacoesVida AS engajamento28Vida

FROM tb_join

