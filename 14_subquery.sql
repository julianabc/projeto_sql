SELECT *
FROM transacao_produto AS t1
WHERE t1.IdProduto IN(
    SELECT IdProduto
    FROM produtos
    WHERE DescNomeProduto="Resgatar Ponei"
);


-- poderia ser feito assim, embora, subquery nao seja sinonimo de join
SELECT *
FROM transacao_produto AS t1
LEFT JOIN produtos AS t2 ON t1.idProduto=t2.IdProduto
WHERE t2.DescNomeProduto="Resgatar Ponei"
