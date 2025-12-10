
-- Q: qual o valor medio de pontos positivos por dia?

-- pensando como foi ensinado em aula. dia distinto / soma de pontos

/*
    Sum de pontos = para a média em si, contagem de pontos na coluna qtdpontos
    count distinct da dtCriacao = como pode ser feita +1 de uma transação por dia, preciso contar os dias de maneira singular. Ex: 30 dias no mes

    Obs: não coloca-se 30 dias porque esse calculo pode ser feito antes do mês acabar.

*/



SELECT sum(qtdePontos) AS totalPontos,
       count(DISTINCT substr(DtCriacao,1,10)) AS qtdeDiasUnicos,
       sum(qtdePontos) /  count(DISTINCT substr(DtCriacao,1,10)) AS avgPontosDias
FROM transacoes
WHERE qtdePontos > 0






--- calculo pensando na transação por dia


SELECT substr(DtCriacao, 1, 10) AS Dia,
round(avg(qtdePontos),2) as Media_Pontos
FROM transacoes
WHERE QtdePontos > 0
GROUP BY 1; -- para ordenar pela primeira coluna do select