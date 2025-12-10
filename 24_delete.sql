DELETE FROM relatorio_diario
WHERE strftime('%w', substr(qtDias, 1,10))='0';
SELECT * FROM relatorio_diario;