/* Clientes mais antigos tem mais transferencia de transação?

    Obs: o SQL traz os dados mas esse tipo de analise só pode ser feita
    junto a um visualização de dados. 

 */

SELECT t1.idCliente,
    -- idade do cliente na base
    julianday('now') - julianday(substr(t1.DtCriacao,1,19)) AS idadeBase, 
    count(t2.IdTransacao) AS qtdeTransacoes
    
FROM clientes AS t1

LEFT JOIN transacoes AS t2 ON t1.idCliente = t2.idCliente
GROUP BY t1.idCliente, idadeBase

