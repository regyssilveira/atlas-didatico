-- Dos Dados à Decisão | capítulo 3 | etapa 4
-- Seção: Reconciliação entre fontes
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT i.pedido_id
FROM itens i
LEFT JOIN pedidos p USING (pedido_id)
WHERE p.pedido_id IS NULL;

SELECT p.pedido_id
FROM pedidos p
LEFT JOIN itens i USING (pedido_id)
WHERE i.pedido_id IS NULL;
-- FIM DO SQL DO LIVRO
