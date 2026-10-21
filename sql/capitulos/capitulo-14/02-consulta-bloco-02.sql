-- Dos Dados à Decisão | capítulo 14 | etapa 2
-- Seção: Portão 3 — atravesse a produção
-- Bloco SQL 2 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    date_trunc('month', o.data_planejada) AS mes,
    o.linha_id,
    sum(o.quantidade_planejada) AS planejada,
    sum(a.quantidade_aprovada) AS aprovada,
    sum(a.quantidade_refugada) AS refugo,
    sum(a.minutos_parada) AS minutos_parada
FROM atlas_lab.dados.ordens_producao o
JOIN atlas_lab.dados.apontamentos_producao a
  USING (ordem_producao_id)
WHERE o.produto_id LIKE 'AX-%'
GROUP BY mes, o.linha_id
ORDER BY mes, o.linha_id;
-- FIM DO SQL DO LIVRO
