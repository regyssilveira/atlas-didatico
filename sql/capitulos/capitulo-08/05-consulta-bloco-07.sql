-- Dos Dados à Decisão | capítulo 8 | etapa 5
-- Seção: Separe bloqueio de falta física
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    mes,
    produto_id,
    saldo_fisico,
    reservado,
    bloqueado,
    disponivel,
    round(100.0 * bloqueado / nullif(saldo_fisico, 0), 1) AS bloqueado_pct
FROM estoque
WHERE produto_id IN ('CMP-047', 'AX-120')
  AND mes >= '2026-07'
ORDER BY produto_id, mes;
-- FIM DO SQL DO LIVRO
