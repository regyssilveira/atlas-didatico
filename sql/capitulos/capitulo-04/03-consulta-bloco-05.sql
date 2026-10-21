-- Dos Dados à Decisão | capítulo 4 | etapa 3
-- Seção: Unicidade e completude
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    COUNT(*) AS pedidos,
    COUNT(*) FILTER (WHERE data_prometida_original IS NULL) AS sem_promessa,
    COUNT(*) FILTER (WHERE data_entrega IS NULL) AS sem_entrega,
    COUNT(*) FILTER (WHERE cliente_id IS NULL) AS sem_cliente
FROM pedidos;
-- FIM DO SQL DO LIVRO
