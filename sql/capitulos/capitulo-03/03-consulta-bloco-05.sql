-- Dos Dados à Decisão | capítulo 3 | etapa 3
-- Seção: Acompanhe a investigação: reconhecer antes de analisar
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    variavel,
    unidade,
    COUNT(*) AS leituras,
    MIN(data) AS inicio,
    MAX(data) AS fim
FROM sensores
GROUP BY variavel, unidade
ORDER BY variavel;
-- FIM DO SQL DO LIVRO
