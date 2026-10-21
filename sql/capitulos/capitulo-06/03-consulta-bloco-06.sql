-- Dos Dados à Decisão | capítulo 6 | etapa 3
-- Seção: Comece pelo tempo, não pelo fornecedor
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    date_trunc('month', data_inspecao) AS mes,
    sum(quantidade_reprovada) AS refugo,
    sum(quantidade_inspecionada) AS inspecionada,
    round(100.0 * sum(quantidade_reprovada)
          / sum(quantidade_inspecionada), 2) AS refugo_pct
FROM inspecoes
GROUP BY mes
ORDER BY mes;
-- FIM DO SQL DO LIVRO
