
/*
    A busca é de dentro para fora. Então, eu tenho todos que foram cadastrados no primeiro dia,
    depois, a busca de fora compara com o que está dentro.

    1º dia = 452 clientes
    2º dia (em diante, começa a comparação.)

   Questão: dos clientes que começaram SQL no primeiro dia, quantos chegaram ao 5o dia?

*/

SELECT count(DISTINCT IdCliente)
FROM transacoes AS t1

WHERE t1.idCliente IN(
    SELECT DISTINCT iDCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10)= "2025-08-25"
)

AND substr(t1.DtCriacao,1, 10)="2025-08-29"



