SELECT idCliente, 
       count(DISTINCT idTransacao) -- nao faz diferença aqui porque já é uma PK
FROM transacoes
WHERE strftime('%Y', substr(DtCriacao,1,10))="2024"
Group BY idCliente
ORDER BY count(idTransacao) DESC
LIMIT 1





