-- Dos Dados à Decisão | capítulo 8 | etapa 2
-- Seção: Reconcilie a disponibilidade publicada
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    count(*) AS linhas,
    count(*) FILTER (
        WHERE disponivel <> greatest(
            0, saldo_fisico - reservado - bloqueado
        )
    ) AS divergencias,
    count(*) FILTER (WHERE saldo_fisico < 0) AS saldos_negativos
FROM estoque;
-- FIM DO SQL DO LIVRO
