-- Dos Dados à Decisão | capítulo 7 | etapa 2
-- Seção: Verifique a frequência observada
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    variavel,
    min(data) AS inicio,
    max(data) AS fim,
    count(*) AS leituras,
    count(DISTINCT data) AS dias,
    count(DISTINCT unidade) AS unidades
FROM sensores
WHERE maquina_id = 'MAQ-012'
GROUP BY variavel
ORDER BY variavel;
-- FIM DO SQL DO LIVRO
