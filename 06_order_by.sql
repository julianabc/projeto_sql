SELECT *
FROM clientes
ORDER BY QtdePontos DESC  -- ordenacao de forma decrescente 
LIMIT 10;


-- clientes mais antigos e que possuem mais pontos (asc é opcional)
-- where usado só para mostrar a ordem que a query funciona

SELECT *
FROM clientes
WHERE flTwitch=1
ORDER BY DtCriacao ASC, QtdePontos DESC

