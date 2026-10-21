-- Dos Dados à Decisão | capítulo 11 | etapa 3
-- Seção: Congele a informação disponível
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    count(*) FILTER (WHERE quantidade_aberta_no_corte > 0) AS itens_abertos,
    sum(quantidade_aberta_no_corte) AS unidades_abertas,
    count(*) FILTER (
        WHERE quantidade_aberta_no_corte > 0
          AND data_prometida_original <= DATE '2026-10-31'
    ) AS itens_ja_atrasados
FROM carteira_2026_10_31;
-- FIM DO SQL DO LIVRO
