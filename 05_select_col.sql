-- apenas uma consulta, nao muda nada no banco principal 

SELECT IdCliente,
-- não é necessário o AS mas é bom ser explicito 
   -- QtdePontos + 10 AS QtdePontosPlus10 
    DtCriacao,
    -- primeiro, trato a data e depois vem o datetime
    datetime(substr(DtCriacao, 1, 19)) AS dtCriacaoNova,

    strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS diaSemana
    
    

FROM clientes

LIMIT 10