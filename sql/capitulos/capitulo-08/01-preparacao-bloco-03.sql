-- Dos Dados à Decisão | capítulo 8 | etapa 1
-- Seção: Acompanhe a investigação: desmontar o paradoxo do estoque
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW estoque AS
SELECT * FROM atlas_lab.dados.estoque_mensal;

CREATE OR REPLACE TEMP VIEW produtos AS
SELECT * FROM atlas_lab.dados.produtos;

CREATE OR REPLACE TEMP VIEW pedidos AS
SELECT * FROM atlas_lab.dados.pedidos;

CREATE OR REPLACE TEMP VIEW itens AS
SELECT * FROM atlas_lab.dados.itens_pedido;
-- FIM DO SQL DO LIVRO
