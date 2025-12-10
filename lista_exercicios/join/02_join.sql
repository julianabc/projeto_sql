SELECT t1.idCliente, substr(t1.DtCriacao, 1, 10) AS Dia, t3.DescNomeProduto
FROM transacoes AS t1
LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao=t2.IdTransacao
LEFT JOIN produtos AS t3 ON t2.IdProduto=t3.IdProduto

WHERE Dia = "2025-08-25" AND t3.DescNomeProduto="Lista de presença"
GROUP BY t1.idCliente