-- Dos Dados à Decisão | capítulo 10 | etapa 2
-- Seção: Confirme a granularidade econômica
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    count(*) AS itens,
    count(DISTINCT pedido_id || '-' || item_id) AS chaves_distintas,
    count(*) FILTER (WHERE preco_venda > preco_lista) AS acima_da_lista,
    count(*) FILTER (WHERE quantidade <= 0) AS quantidade_invalida
FROM itens;
-- FIM DO SQL DO LIVRO
