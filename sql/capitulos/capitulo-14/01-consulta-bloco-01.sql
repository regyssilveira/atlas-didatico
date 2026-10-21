-- Dos Dados à Decisão | capítulo 14 | etapa 1
-- Seção: Portão 1 — prove o paradoxo
-- Bloco SQL 1 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH base AS (
    SELECT
        year(p.data_pedido) AS ano,
        CASE WHEN i.produto_id LIKE 'AX-%' THEN 'AX' ELSE 'outras' END AS familia,
        i.quantidade,
        i.preco_venda,
        c.custo_total,
        (p.data_entrega > p.data_prometida_original)::INTEGER AS atrasado
    FROM atlas_lab.dados.pedidos p
    JOIN atlas_lab.dados.itens_pedido i USING (pedido_id)
    JOIN atlas_lab.dados.custos_produto c
      ON c.produto_id = i.produto_id
     AND c.mes = date_format(p.data_pedido, 'yyyy-MM')
)
SELECT
    ano,
    familia,
    sum(quantidade) AS unidades,
    round(sum(quantidade * preco_venda), 2) AS receita,
    round(100.0 * sum(quantidade * (preco_venda - custo_total))
          / sum(quantidade * preco_venda), 2) AS margem_pct,
    round(100.0 * avg(atrasado), 1) AS atraso_pct
FROM base
GROUP BY ano, familia
ORDER BY familia, ano;
-- FIM DO SQL DO LIVRO
