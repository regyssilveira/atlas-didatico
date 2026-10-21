-- Dos Dados à Decisão | capítulo 7 | etapa 5
-- Seção: Congele uma data de observação
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH base AS (
    SELECT avg(valor) AS media, stddev_samp(valor) AS desvio
    FROM sensores
    WHERE variavel = 'vibracao'
      AND data >= DATE '2025-01-01'
      AND data <  DATE '2026-01-01'
), historico_disponivel AS (
    SELECT s.*
    FROM sensores s
    WHERE s.variavel = 'vibracao'
      AND s.data <= DATE '2026-10-10'
)
SELECT
    h.data,
    h.valor,
    round((h.valor - b.media) / nullif(b.desvio, 0), 2) AS desvios_da_base
FROM historico_disponivel h
CROSS JOIN base b
WHERE h.data >= DATE '2026-09-01'
ORDER BY h.data;
-- FIM DO SQL DO LIVRO
