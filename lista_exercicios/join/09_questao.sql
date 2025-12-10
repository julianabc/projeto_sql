/* Em 2024, quantas transações de lovers tivemos? */

SELECT t2.IdProduto, count(distinct t1.IdTransacao)

FROM transacoes AS t1

LEFT JOIN transacao_produto AS t2 ON t1.IdTransacao=t2.IdTransacao

LEFT JOIN produtos AS t3 ON t2.IdProduto=t3.IdProduto -- ele está a direita ao primeiro join

WHERE substr(t1.DtCriacao, 1, 4) = "2024" AND t3.DescCategoriaProduto = "lovers"






