-- Dos Dados à Decisão | capítulo 9 | etapa 1
-- Seção: Acompanhe a investigação: avaliar somente o que foi observado
-- Bloco SQL 2 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW fornecedores AS
SELECT * FROM atlas_lab.dados.fornecedores;

CREATE OR REPLACE TEMP VIEW lotes AS
SELECT * FROM atlas_lab.dados.lotes_material;

CREATE OR REPLACE TEMP VIEW inspecoes AS
SELECT * FROM atlas_lab.dados.inspecoes_qualidade;
-- FIM DO SQL DO LIVRO
