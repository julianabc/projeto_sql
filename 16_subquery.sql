/* Exemplo de subquery sendo usada dentro do FROM. 
   substr(t1.DtCriacao,1, 10)="2025-08-29"
   Nesse caso, não há diferença entre usar o AND (e nao fazer a subquery) */

SELECT *

FROM(
    SELECT *
    FROM transacoes
    WHERE DtCriacao >= '2025-01-01'
)

WHERE DtCriacao < '2025-07-01'


