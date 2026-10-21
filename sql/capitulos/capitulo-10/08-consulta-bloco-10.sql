-- Dos Dados à Decisão | capítulo 10 | etapa 8
-- Seção: Teste a acusação contra o vendedor
-- Bloco SQL 10 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    CASE WHEN p.vendedor_id = 'VEN-027' THEN 'VEN-027'
         ELSE 'demais' END AS grupo,
    CASE WHEN i.produto_id LIKE 'AX-%' THEN 'AX'
         ELSE 'outras' END AS familia,
    round(100.0 * avg(
        (p.data_entrega > p.data_prometida_original)::INTEGER
    ), 1)
        AS atraso_pct,
    count(*) AS pedidos
FROM pedidos p
JOIN itens i USING (pedido_id)
GROUP BY grupo, familia
ORDER BY grupo, familia;
-- FIM DO SQL DO LIVRO
