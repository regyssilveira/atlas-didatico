-- Dos Dados à Decisão | capítulo 5 | etapa 1
-- Seção: Acompanhe a investigação: do plano à perda observável
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW ordens AS
SELECT * FROM atlas_lab.dados.ordens_producao;

CREATE OR REPLACE TEMP VIEW apontamentos AS
SELECT * FROM atlas_lab.dados.apontamentos_producao;

CREATE OR REPLACE TEMP VIEW produtos AS
SELECT * FROM atlas_lab.dados.produtos;
-- FIM DO SQL DO LIVRO
