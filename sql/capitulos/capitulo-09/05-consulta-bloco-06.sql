-- Dos Dados à Decisão | capítulo 9 | etapa 5
-- Seção: Relacione preço e qualidade sem atribuição integral
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH desempenho AS (
    SELECT
        l.fornecedor_id,
        sum(i.quantidade_inspecionada) AS unidades_expostas,
        sum(i.quantidade_reprovada) AS unidades_reprovadas,
        count(DISTINCT l.lote_material_id) AS lotes_expostos
    FROM lotes l
    JOIN inspecoes i USING (lote_material_id)
    WHERE i.data_inspecao >= DATE '2026-08-01'
    GROUP BY l.fornecedor_id
), preco AS (
    SELECT
        fornecedor_id,
        sum(quantidade_recebida * preco_unitario)
            / sum(quantidade_recebida) AS preco_ponderado
    FROM lotes
    GROUP BY fornecedor_id
)
SELECT
    d.fornecedor_id,
    round(p.preco_ponderado, 2) AS preco_ponderado,
    d.lotes_expostos,
    d.unidades_expostas,
    d.unidades_reprovadas,
    round(100.0 * d.unidades_reprovadas / d.unidades_expostas, 2)
        AS refugo_associado_pct
FROM desempenho d
JOIN preco p USING (fornecedor_id)
ORDER BY d.fornecedor_id;
-- FIM DO SQL DO LIVRO
