-- Dos Dados à Decisão | capítulo 2 | etapa 4
-- Seção: Prática opcional com os dados do caso
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW pedidos AS
SELECT * FROM atlas_lab.dados.pedidos;

SELECT
    COUNT(*) AS linhas,
    COUNT(DISTINCT pedido_id) AS pedidos,
    MIN(data_pedido) AS inicio,
    MAX(data_pedido) AS fim
FROM pedidos;
-- FIM DO SQL DO LIVRO
