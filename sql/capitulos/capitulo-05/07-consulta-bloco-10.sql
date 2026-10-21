-- Dos Dados à Decisão | capítulo 5 | etapa 7
-- Seção: Peças por hora e o efeito do mix
-- Bloco SQL 10 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    a.turno_id,
    round(sum(a.quantidade_aprovada * p.tempo_padrao_minuto) / 60, 1)
        AS horas_padrao_entregues,
    round(sum(a.minutos_operacao) / 60, 1) AS horas_operacao
FROM apontamentos a
JOIN ordens o USING (ordem_producao_id)
JOIN produtos p USING (produto_id)
WHERE o.linha_id = 'L03'
  AND o.data_planejada >= DATE '2026-07-01'
GROUP BY a.turno_id
ORDER BY a.turno_id;
-- FIM DO SQL DO LIVRO
