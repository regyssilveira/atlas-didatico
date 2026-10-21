-- Dos Dados à Decisão | capítulo 6 | etapa 6
-- Seção: Desça ao lote, mas carregue o volume
-- Bloco SQL 9 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    l.fornecedor_id,
    i.lote_material_id,
    sum(i.quantidade_reprovada) AS refugo,
    sum(i.quantidade_inspecionada) AS inspecionada,
    round(100.0 * sum(i.quantidade_reprovada)
          / sum(i.quantidade_inspecionada), 2) AS refugo_pct,
    count(*) AS ordens
FROM inspecoes i
JOIN lotes l USING (lote_material_id)
WHERE i.data_inspecao >= DATE '2026-08-01'
GROUP BY l.fornecedor_id, i.lote_material_id
HAVING sum(i.quantidade_inspecionada) >= 100
ORDER BY refugo_pct DESC;
-- FIM DO SQL DO LIVRO
