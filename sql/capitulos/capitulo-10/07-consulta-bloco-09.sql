-- Dos Dados à Decisão | capítulo 10 | etapa 7
-- Seção: Localize desconto, custo e mix
-- Bloco SQL 9 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    mes,
    produto_id,
    unidades,
    round(100.0 * unidades / sum(unidades) OVER (PARTITION BY mes), 1)
        AS participacao_pct
FROM (
    SELECT
        date_format(p.data_pedido, 'yyyy-MM') AS mes,
        i.produto_id,
        sum(i.quantidade) AS unidades
    FROM pedidos p
    JOIN itens i USING (pedido_id)
    WHERE i.produto_id LIKE 'AX-%'
    GROUP BY mes, i.produto_id
)
ORDER BY mes, produto_id;
-- FIM DO SQL DO LIVRO
