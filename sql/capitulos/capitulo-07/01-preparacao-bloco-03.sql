-- Dos Dados à Decisão | capítulo 7 | etapa 1
-- Seção: Acompanhe a investigação: analisar sem olhar o futuro
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW sensores AS
SELECT * FROM atlas_lab.dados.leituras_sensores_diarias;

CREATE OR REPLACE TEMP VIEW falhas AS
SELECT * FROM atlas_lab.dados.falhas_maquina;

CREATE OR REPLACE TEMP VIEW manutencao AS
SELECT * FROM atlas_lab.dados.ordens_manutencao;
-- FIM DO SQL DO LIVRO
