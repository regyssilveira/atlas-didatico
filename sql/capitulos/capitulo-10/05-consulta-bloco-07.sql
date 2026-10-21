-- Dos Dados à Decisão | capítulo 10 | etapa 5
-- Seção: Calcule receita e margem com a mesma população
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH economia_item AS (
    SELECT
        year(p.data_pedido) AS ano,
        i.produto_id,
        i.quantidade,
        i.preco_lista,
        i.preco_venda,
        c.custo_total,
        i.quantidade * i.preco_venda AS receita,
        i.quantidade * c.custo_total AS custo,
        i.quantidade * (i.preco_venda - c.custo_total) AS margem
    FROM pedidos p
    JOIN itens i USING (pedido_id)
    JOIN custos c
      ON c.produto_id = i.produto_id
     AND c.mes = date_format(p.data_pedido, 'yyyy-MM')
    WHERE i.produto_id LIKE 'AX-%'
)
SELECT
    ano,
    sum(quantidade) AS unidades,
    round(sum(receita), 2) AS receita,
    round(sum(custo), 2) AS custo,
    round(sum(margem), 2) AS margem,
    round(100.0 * sum(margem) / sum(receita), 2) AS margem_pct
FROM economia_item
GROUP BY ano
ORDER BY ano;
-- FIM DO SQL DO LIVRO
