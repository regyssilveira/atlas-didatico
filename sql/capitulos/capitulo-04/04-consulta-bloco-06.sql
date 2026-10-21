-- Dos Dados à Decisão | capítulo 4 | etapa 4
-- Seção: Validade e consistência temporal
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    CASE
        WHEN data_prometida_original < data_pedido THEN 'promessa_antes_pedido'
        WHEN data_entrega < data_pedido THEN 'entrega_antes_pedido'
        WHEN data_prometida_atual < data_prometida_original THEN 'promessa_antecipada'
        ELSE 'sequencia_plausivel'
    END AS teste,
    COUNT(*) AS pedidos
FROM pedidos
GROUP BY teste
ORDER BY pedidos DESC;
-- FIM DO SQL DO LIVRO
