-- Dos Dados à Decisão | capítulo 2 | etapa 1
-- Seção: 5. Observe três pedidos
-- Bloco SQL 1 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT pedido_id, data_pedido, status
FROM atlas_lab.dados.pedidos
ORDER BY pedido_id
LIMIT 3;
-- FIM DO SQL DO LIVRO
