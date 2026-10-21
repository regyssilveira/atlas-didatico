-- Dos Dados à Decisão | capítulo 9 | etapa 2
-- Seção: Faça primeiro um inventário da evidência
-- Bloco SQL 3 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    f.fornecedor_id,
    f.nome,
    f.qualificado_em,
    min(l.data_recebimento) AS primeiro_recebimento,
    max(l.data_recebimento) AS ultimo_recebimento,
    count(*) AS lotes,
    sum(l.quantidade_recebida) AS quantidade_recebida,
    round(avg(l.preco_unitario), 2) AS preco_medio_simples
FROM fornecedores f
JOIN lotes l USING (fornecedor_id)
GROUP BY f.fornecedor_id, f.nome, f.qualificado_em
ORDER BY f.fornecedor_id;
-- FIM DO SQL DO LIVRO
