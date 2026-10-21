-- Dos Dados à Decisão | capítulo 8 | etapa 4
-- Seção: Construa uma aproximação de cobertura
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH demanda AS (
    SELECT
        date_format(p.data_pedido, 'yyyy-MM') AS mes,
        i.produto_id,
        sum(i.quantidade) AS quantidade_pedida,
        day(last_day(max(p.data_pedido))) AS dias_mes
    FROM pedidos p
    JOIN itens i USING (pedido_id)
    WHERE i.produto_id LIKE 'AX-%'
    GROUP BY mes, i.produto_id
)
SELECT
    e.mes,
    e.produto_id,
    e.disponivel,
    d.quantidade_pedida,
    round(e.disponivel / nullif(d.quantidade_pedida / d.dias_mes, 0), 1)
        AS cobertura_dias_aproximada
FROM estoque e
JOIN demanda d USING (mes, produto_id)
WHERE e.mes >= '2026-07'
ORDER BY e.produto_id, e.mes;
-- FIM DO SQL DO LIVRO
