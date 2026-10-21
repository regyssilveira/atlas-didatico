-- Dos Dados à Decisão | capítulo 10 | etapa 5
-- Seção: Localize desconto, custo e mix
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    date_format(p.data_pedido, 'yyyy-MM') AS mes,
    i.produto_id,
    sum(i.quantidade) AS unidades,
    round(100.0 * (1 - sum(i.quantidade * i.preco_venda)
        / sum(i.quantidade * i.preco_lista)), 2) AS desconto_ponderado_pct,
    round(avg(c.custo_total), 2) AS custo_unitario,
    round(100.0 * sum(i.quantidade * (i.preco_venda - c.custo_total))
        / sum(i.quantidade * i.preco_venda), 2) AS margem_pct
FROM pedidos p
JOIN itens i USING (pedido_id)
JOIN custos c
  ON c.produto_id = i.produto_id
 AND c.mes = date_format(p.data_pedido, 'yyyy-MM')
WHERE i.produto_id LIKE 'AX-%'
GROUP BY date_format(p.data_pedido, 'yyyy-MM'), i.produto_id
ORDER BY mes, i.produto_id;
-- FIM DO SQL DO LIVRO
