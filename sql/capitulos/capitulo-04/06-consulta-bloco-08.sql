-- Dos Dados à Decisão | capítulo 4 | etapa 6
-- Seção: Um placar que não esconde o denominador
-- Bloco SQL 8 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH testes AS (
    SELECT
        'preco_venda_positivo' AS regra,
        COUNT(*) AS avaliados,
        COUNT(*) FILTER (
            WHERE preco_venda IS NULL OR preco_venda <= 0
        ) AS falhas
    FROM itens
    UNION ALL
    SELECT
        'desconto_entre_zero_e_um',
        COUNT(*),
        COUNT(*) FILTER (
            WHERE desconto_percentual IS NULL
               OR desconto_percentual < 0
               OR desconto_percentual > 1
        )
    FROM itens
)
SELECT
    regra,
    avaliados,
    falhas,
    ROUND(100.0 * falhas / NULLIF(avaliados, 0), 2) AS falha_pct
FROM testes;
-- FIM DO SQL DO LIVRO
