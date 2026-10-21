-- Dos Dados à Decisão | capítulo 11 | etapa 4
-- Seção: Aloque o acabado sem duplicar saldo
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
CREATE OR REPLACE TEMP VIEW resultado_alocacao AS
WITH abertos AS (
    SELECT *,
        sum(quantidade_aberta_no_corte) OVER (
            PARTITION BY produto_id
            ORDER BY data_prometida_original, data_pedido,
                     pedido_id, item_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS demanda_anterior
    FROM carteira_2026_10_31
    WHERE quantidade_aberta_no_corte > 0
), posicao AS (
    SELECT produto_id, sum(disponivel) AS disponivel
    FROM estoque
    WHERE mes = '2026-10'
    GROUP BY produto_id
)
SELECT
    a.pedido_id,
    a.item_id,
    a.produto_id,
    a.data_prometida_original,
    a.quantidade_aberta_no_corte,
    coalesce(p.disponivel, 0) AS disponivel_produto,
    greatest(0, least(
        a.quantidade_aberta_no_corte,
        coalesce(p.disponivel, 0)
          - coalesce(a.demanda_anterior, 0)
    )) AS alocavel_estoque,
    a.quantidade_aberta_no_corte - greatest(0, least(
        a.quantidade_aberta_no_corte,
        coalesce(p.disponivel, 0)
          - coalesce(a.demanda_anterior, 0)
    )) AS depende_producao
FROM abertos a
LEFT JOIN posicao p USING (produto_id)
ORDER BY a.produto_id, a.data_prometida_original,
         a.pedido_id, a.item_id;

SELECT * FROM resultado_alocacao
ORDER BY produto_id, data_prometida_original,
         pedido_id, item_id;
-- FIM DO SQL DO LIVRO
