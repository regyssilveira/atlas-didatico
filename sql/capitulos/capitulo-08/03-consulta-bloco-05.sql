-- Dos Dados à Decisão | capítulo 8 | etapa 3
-- Seção: Compare valor total e disponibilidade útil
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    mes,
    round(sum(valor_estoque), 2) AS valor_total,
    sum(disponivel) FILTER (
        WHERE produto_id LIKE 'AX-%'
    ) AS disponivel_ax,
    sum(disponivel) FILTER (
        WHERE produto_id = 'CMP-047'
    ) AS disponivel_componente
FROM estoque
WHERE mes IN ('2026-08', '2026-09', '2026-10', '2026-11')
GROUP BY mes
ORDER BY mes;
-- FIM DO SQL DO LIVRO
