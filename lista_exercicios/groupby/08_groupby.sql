/*
        A questão é sobre o produto mais caro que foi vendido. Precisa multiplicar porque eu posso vender mais de 1 unidade
        É como se fosse valor produto * quantidade
*/

SELECT IdProduto, 
        sum(vlProduto * QtdeProduto) AS totalPontos,
        sum(qtdeProduto) AS qtdeVendas,
        

FROM transacao_produto

GROUP BY IdProduto
ORDER BY totalPontos DESC

