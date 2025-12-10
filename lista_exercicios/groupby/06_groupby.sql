SELECT strftime('%w', DATETIME(substr(DtCriacao, 1, 10))) AS dia_Semana,
       count(idTransacao)
FROM transacoes
WHERE substr(DtCriacao, 1, 4) = "2025"
Group BY 1 -- pelo dia da Semana

ORDER BY 2 DESC
