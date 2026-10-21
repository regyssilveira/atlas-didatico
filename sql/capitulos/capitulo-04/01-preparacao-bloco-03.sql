-- Dos Dados à Decisão | capítulo 4 | etapa 1
-- Seção: Acompanhe a investigação: transformar suspeitas em testes
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW pedidos AS
SELECT * FROM atlas_lab.dados.pedidos;

CREATE OR REPLACE TEMP VIEW itens AS
SELECT * FROM atlas_lab.dados.itens_pedido;

CREATE OR REPLACE TEMP VIEW ordens AS
SELECT * FROM atlas_lab.dados.ordens_producao;

CREATE OR REPLACE TEMP VIEW apontamentos AS
SELECT * FROM atlas_lab.dados.apontamentos_producao;
-- FIM DO SQL DO LIVRO
