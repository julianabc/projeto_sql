/* Fazer um CREATE mais analitico, de uma tabela gerada em CTE 
   Isso ajuda muito a performance, pois o foco torna-se uma amostra bem menor. 
   Auxiliar na consulta até mesmo em relação a ferramenta de visualização
*/

DROP TABLE IF EXISTS relatorio_diario

CREATE TABLE IF NOT EXISTS relatorio_diario AS

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


SELECT * FROM tb_transAcumuladas

    
