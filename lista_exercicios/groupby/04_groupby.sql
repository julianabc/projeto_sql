SELECT count(*) as QtdRPG
FROM produtos
WHERE DescCategoriaProduto="rpg"


--- outra maneira

SELECT DescCategoriaProduto, count(*)
FROM produtos
GROUP BY DescCategoriaProduto