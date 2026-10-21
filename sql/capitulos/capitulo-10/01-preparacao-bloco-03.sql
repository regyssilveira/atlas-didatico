-- Dos Dados à Decisão | capítulo 10 | etapa 1
-- Seção: Acompanhe a investigação: reconciliar crescimento e margem
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW pedidos AS
SELECT * FROM atlas_lab.dados.pedidos;

CREATE OR REPLACE TEMP VIEW itens AS
SELECT * FROM atlas_lab.dados.itens_pedido;

CREATE OR REPLACE TEMP VIEW custos AS
SELECT * FROM atlas_lab.dados.custos_produto;
-- FIM DO SQL DO LIVRO
