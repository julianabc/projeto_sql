SELECT IdCliente, t1.QtdePontos, t3.DescCategoriaProduto, sum(t1.QtdePontos) as totalPontos
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao=t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto=t3.IdProduto
WHERE t3.DescCategoriaProduto="lovers"
GROUP BY t1.idCliente
ORDER BY totalPontos ASC



