-- Dos Dados à Decisão | capítulo 6 | etapa 1
-- Seção: Acompanhe a investigação: seguir o defeito sem inventar a causa
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW inspecoes AS
SELECT * FROM atlas_lab.dados.inspecoes_qualidade;

CREATE OR REPLACE TEMP VIEW consumo AS
SELECT * FROM atlas_lab.dados.consumo_material;

CREATE OR REPLACE TEMP VIEW lotes AS
SELECT * FROM atlas_lab.dados.lotes_material;

CREATE OR REPLACE TEMP VIEW ordens AS
SELECT * FROM atlas_lab.dados.ordens_producao;
-- FIM DO SQL DO LIVRO
