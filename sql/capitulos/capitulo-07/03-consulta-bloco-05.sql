-- Dos Dados à Decisão | capítulo 7 | etapa 3
-- Seção: Construa a linha de base sem contaminar o passado
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    variavel,
    round(avg(valor), 3) AS media_base,
    round(stddev_samp(valor), 3) AS desvio_base,
    round(percentile(valor, 0.95), 3) AS p95_base
FROM sensores
WHERE data >= DATE '2025-01-01'
  AND data <  DATE '2026-01-01'
GROUP BY variavel;
-- FIM DO SQL DO LIVRO
