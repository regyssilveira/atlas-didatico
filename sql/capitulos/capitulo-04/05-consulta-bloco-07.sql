-- Dos Dados à Decisão | capítulo 4 | etapa 5
-- Seção: Reconciliação produtiva
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    COUNT(*) AS apontamentos,
    COUNT(*) FILTER (
        WHERE quantidade_aprovada IS NULL
           OR quantidade_refugada IS NULL
           OR quantidade_produzida IS NULL
           OR quantidade_aprovada + quantidade_refugada
              <> quantidade_produzida
    ) AS sem_reconciliacao,
    COUNT(*) FILTER (
        WHERE quantidade_produzida > quantidade_planejada
    ) AS acima_do_plano
FROM apontamentos a
JOIN ordens o USING (ordem_producao_id);
-- FIM DO SQL DO LIVRO
