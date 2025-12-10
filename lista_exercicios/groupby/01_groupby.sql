SELECT count(*)
FROM clientes
WHERE FlEmail=1

--- outra maneira. onde estou somando todos (0+0 = 0, logo nao conta). 

SELECT sum(flEmail)
FROM clientes;

