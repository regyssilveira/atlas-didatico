-- Dos Dados à Decisão | capítulo 9 | etapa 4
-- Seção: Separe qualificação de desempenho posterior
-- Bloco SQL 5 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    fornecedor_id,
    qualificado_em,
    primeiro_recebimento,
    datediff(primeiro_recebimento, qualificado_em) AS dias_ate_primeiro_lote
FROM (
    SELECT
        f.fornecedor_id,
        CAST(f.qualificado_em AS DATE) AS qualificado_em,
        min(CAST(l.data_recebimento AS DATE)) AS primeiro_recebimento
    FROM fornecedores f
    JOIN lotes l USING (fornecedor_id)
    GROUP BY f.fornecedor_id, f.qualificado_em
);
-- FIM DO SQL DO LIVRO
