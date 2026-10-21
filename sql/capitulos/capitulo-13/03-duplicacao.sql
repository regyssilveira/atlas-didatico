-- Dos Dados à Decisão | capítulo 13 | etapa 3
-- Seção: Teste a consulta por mutação controlada
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Não use Executar tudo no roteiro do capítulo 13. Confira o estado antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW custos_teste AS
SELECT * FROM atlas_lab.dados.custos_produto
UNION ALL
SELECT * FROM atlas_lab.dados.custos_produto
WHERE produto_id = 'AX-100' AND mes = '2026-01';
-- FIM DO SQL DO LIVRO
