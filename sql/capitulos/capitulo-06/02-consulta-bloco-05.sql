-- Dos Dados à Decisão | capítulo 6 | etapa 2
-- Seção: Verifique a trilha antes de usá-la
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    count(*) AS inspecoes,
    count(c.ordem_producao_id) AS com_consumo,
    count(*) FILTER (
        WHERE c.lote_material_id <> i.lote_material_id
    ) AS lotes_divergentes
FROM inspecoes i
LEFT JOIN consumo c USING (ordem_producao_id);
-- FIM DO SQL DO LIVRO
