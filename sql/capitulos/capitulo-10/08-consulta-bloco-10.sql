-- Dos Dados à Decisão | capítulo 10 | etapa 8
-- Seção: Teste a acusação contra o vendedor
-- Bloco SQL 10 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    CASE WHEN vendedor_id = 'VEN-027' THEN 'VEN-027'
         ELSE 'demais' END AS grupo,
    round(100.0 * avg((data_entrega > data_prometida_original)::INTEGER), 1)
        AS atraso_pct,
    count(*) AS pedidos
FROM pedidos
GROUP BY grupo;
-- FIM DO SQL DO LIVRO
