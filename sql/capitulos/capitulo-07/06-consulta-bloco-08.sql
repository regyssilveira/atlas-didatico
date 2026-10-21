-- Dos Dados à Decisão | capítulo 7 | etapa 6
-- Seção: Congele uma data de observação
-- Bloco SQL 8 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT *
FROM falhas
WHERE maquina_id = 'MAQ-012'
ORDER BY inicio_falha;
-- FIM DO SQL DO LIVRO
