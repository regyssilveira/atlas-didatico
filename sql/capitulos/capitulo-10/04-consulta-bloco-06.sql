-- Dos Dados à Decisão | capítulo 10 | etapa 4
-- Seção: Confirme custo único por produto e mês
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    produto_id,
    mes,
    count(*) AS ocorrencias
FROM custos
GROUP BY produto_id, mes
HAVING count(*) > 1
ORDER BY produto_id, mes;
-- FIM DO SQL DO LIVRO
