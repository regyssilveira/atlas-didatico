-- Dos Dados à Decisão | capítulo 4 | etapa 2
-- Seção: Unicidade e completude
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT pedido_id, item_id, COUNT(*) AS ocorrencias
FROM itens
GROUP BY pedido_id, item_id
HAVING COUNT(*) > 1;
-- FIM DO SQL DO LIVRO
