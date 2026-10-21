-- Dos Dados à Decisão | capítulo 11 | etapa 6
-- Seção: Converta dependência em horas e componente
-- Bloco SQL 8 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT saldo_fisico, reservado, bloqueado, disponivel
FROM estoque
WHERE mes = '2026-10' AND produto_id = 'CMP-047';
-- FIM DO SQL DO LIVRO
