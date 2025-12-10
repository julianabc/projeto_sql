SELECT IdCliente, DtCriacao,

strftime('%w', datetime(substr(DtCriacao, 1, 19))) AS diaSemana

FROM transacoes

WHERE diaSemana in("0","6")
