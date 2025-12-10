
-- limpar a tabela antes para que não tenha dados duplicados 
DELETE FROM relatorio_diario;

WITH tb_curso_dias AS(
        
        SELECT substr(DtCriacao, 1, 10) as qtDias, 
            count(DISTINCT IdTransacao) as qtTransacoes
        FROM transacoes
        GROUP BY qtDias

),

tb_transAcumuladas AS (
        SELECT *,
        sum(qtTransacoes) OVER (ORDER BY qtDias) AS transacoesAcum

        FROM tb_curso_dias
)

INSERT INTO relatorio_diario

SELECT * FROM tb_transAcumuladas;

SELECT * FROM relatorio_diario;
