SELECT avg(QtdePontos), 
       round(avg(QtdePontos),2) as Media_Arredondada,
       min(qtdePontos) as minCarteira,
       max(qtdePontos) as maxCarteira

FROM clientes