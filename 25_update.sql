/* Mudar o conteudo da coluna */

SELECT * FROM relatorio_diario;

UPDATE relatorio_diario
SET qtTransacoes = 10000
WHERE qtDias >= '2025-08-25';

SELECT * FROM relatorio_diario;

