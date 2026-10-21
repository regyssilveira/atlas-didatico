-- Dos Dados à Decisão | capítulo 10 | etapa 3
-- Seção: Confirme a granularidade econômica
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    count(*) AS itens,
    count(c.produto_id) AS com_custo,
    count(*) - count(c.produto_id) AS sem_custo
FROM pedidos p
JOIN itens i USING (pedido_id)
LEFT JOIN custos c
  ON c.produto_id = i.produto_id
 AND c.mes = date_format(p.data_pedido, 'yyyy-MM');
-- FIM DO SQL DO LIVRO
