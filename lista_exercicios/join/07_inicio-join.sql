SELECT *, strftime('%w', DATETIME(substr(t1.DtAtualizacao, 1, 10))) AS dia_Semana
from clientes AS t1
