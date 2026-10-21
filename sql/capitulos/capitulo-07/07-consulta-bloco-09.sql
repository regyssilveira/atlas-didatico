-- Dos Dados à Decisão | capítulo 7 | etapa 7
-- Seção: Compare antes e depois da intervenção
-- Bloco SQL 9 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    CASE
        WHEN data < DATE '2026-07-01' THEN 'referencia_2026'
        WHEN data < DATE '2026-10-17' THEN 'deterioracao'
        WHEN data > DATE '2026-10-18' THEN 'pos_intervencao'
        ELSE 'intervencao'
    END AS periodo,
    variavel,
    round(avg(valor), 2) AS media,
    round(percentile(valor, 0.90), 2) AS p90,
    count(*) AS leituras
FROM sensores
WHERE data >= DATE '2026-01-01'
GROUP BY periodo, variavel
ORDER BY variavel, min(data);
-- FIM DO SQL DO LIVRO
