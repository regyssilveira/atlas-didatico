-- Dos Dados à Decisão | capítulo 5 | etapa 2
-- Seção: Acompanhe a investigação: do plano à perda observável
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    COUNT(*) AS ordens,
    COUNT(a.ordem_producao_id) AS ordens_com_apontamento,
    COUNT(*) - COUNT(a.ordem_producao_id) AS ordens_sem_apontamento
FROM ordens o
LEFT JOIN apontamentos a USING (ordem_producao_id);
-- FIM DO SQL DO LIVRO
