-- Q: qual o produto mais transacionado?

/*
    Aqui nao faz diferença porque já tem um produto por linha. 
    A coluna QtdeProduto tá sendo valorada com 1, mas o correto é usar o sum
*/

SELECT idProduto, 
    -- count(idTransacao) - funciona, mas o melhor é o sum
    sum(QtdeProduto) as qtProdutoSum


FROM transacao_produto
GROUP BY idProduto
ORDER BY qtProdutoSum DESC

LIMIT 1


SELECT *
FROM transacao_produto
LIMIT 10 