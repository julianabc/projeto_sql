-- ciclo completo de DDL e DML 

-- DROP TABLE IF EXISTS clientes_d28;

CREATE TABLE IF NOT EXISTS clientes_d28(
    idCliente varchar(250) PRIMARY KEY,
    Qtdetransacoes INTEGER
);

DELETE FROM clientes_d28;

-- inserção na tabela nova
INSERT INTO clientes_d28

SELECT idCliente, count(DISTINCT IdTransacao) AS Qtdetransacoes
FROM transacoes
WHERE julianday('now') - julianday(substr(DtCriacao,1, 10)) <= 32 
GROUP BY idCliente;

SELECT * FROM clientes_d28;