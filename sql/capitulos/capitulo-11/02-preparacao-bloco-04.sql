-- Dos Dados à Decisão | capítulo 11 | etapa 2
-- Seção: Congele a informação disponível
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW carteira_2026_10_31 AS
SELECT
    p.pedido_id,
    i.item_id,
    i.produto_id,
    i.quantidade,
    p.data_pedido,
    p.data_prometida_original,
    CASE
        WHEN p.data_entrega <= DATE '2026-10-31' THEN p.data_entrega
        ELSE NULL
    END AS data_entrega_no_corte,
    p.vendedor_id,
    CASE
        WHEN p.data_entrega <= DATE '2026-10-31' THEN 0
        ELSE i.quantidade
    END AS quantidade_aberta_no_corte
FROM pedidos p
JOIN itens i USING (pedido_id)
WHERE p.data_pedido <= DATE '2026-10-31';
-- FIM DO SQL DO LIVRO
