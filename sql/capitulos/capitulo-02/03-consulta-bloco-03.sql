-- Dos Dados à Decisão | capítulo 2 | etapa 3
-- Seção: 7. Faça uma pergunta com um recorte
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT count(*) AS pedidos_em_2026
FROM atlas_lab.dados.pedidos
WHERE data_pedido >= DATE '2026-01-01'
  AND data_pedido < DATE '2027-01-01';
-- FIM DO SQL DO LIVRO
