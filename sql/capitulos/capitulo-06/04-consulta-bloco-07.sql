-- Dos Dados à Decisão | capítulo 6 | etapa 4
-- Seção: Comece pelo tempo, não pelo fornecedor
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    l.fornecedor_id,
    sum(i.quantidade_reprovada) AS refugo,
    sum(i.quantidade_inspecionada) AS inspecionada,
    round(100.0 * sum(i.quantidade_reprovada)
          / sum(i.quantidade_inspecionada), 2) AS refugo_pct,
    count(DISTINCT i.lote_material_id) AS lotes
FROM inspecoes i
JOIN lotes l USING (lote_material_id)
WHERE i.data_inspecao >= DATE '2026-08-01'
GROUP BY l.fornecedor_id
ORDER BY refugo_pct DESC;
-- FIM DO SQL DO LIVRO
