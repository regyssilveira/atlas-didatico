-- Dos Dados à Decisão | capítulo 5 | etapa 6
-- Seção: Peças por hora e o efeito do mix
-- Bloco SQL 9 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    o.produto_id,
    a.turno_id,
    sum(a.quantidade_aprovada) AS aprovadas,
    round(60.0 * sum(a.quantidade_aprovada)
          / sum(a.minutos_operacao), 2) AS pecas_por_hora,
    round(100.0 * sum(a.quantidade_refugada)
          / sum(a.quantidade_produzida), 2) AS refugo_pct
FROM apontamentos a
JOIN ordens o USING (ordem_producao_id)
WHERE o.linha_id = 'L03'
  AND o.data_planejada >= DATE '2026-07-01'
GROUP BY o.produto_id, a.turno_id
ORDER BY o.produto_id, a.turno_id;
-- FIM DO SQL DO LIVRO
