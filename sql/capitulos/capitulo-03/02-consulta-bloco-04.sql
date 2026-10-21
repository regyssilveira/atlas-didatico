-- Dos Dados à Decisão | capítulo 3 | etapa 2
-- Seção: Acompanhe a investigação: reconhecer antes de analisar
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    COUNT(*) AS linhas,
    COUNT(DISTINCT pedido_id) AS pedidos,
    MIN(data_pedido) AS primeira_data,
    MAX(data_pedido) AS ultima_data
FROM pedidos;

SELECT
    COUNT(*) AS linhas,
    COUNT(DISTINCT pedido_id) AS pedidos,
    COUNT(DISTINCT produto_id) AS produtos
FROM itens;
-- FIM DO SQL DO LIVRO
