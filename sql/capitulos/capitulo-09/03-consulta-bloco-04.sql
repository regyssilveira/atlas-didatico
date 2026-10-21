-- Dos Dados à Decisão | capítulo 9 | etapa 3
-- Seção: Faça primeiro um inventário da evidência
-- Bloco SQL 4 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    fornecedor_id,
    round(sum(quantidade_recebida * preco_unitario)
          / sum(quantidade_recebida), 2) AS preco_medio_ponderado,
    sum(quantidade_recebida) AS quantidade
FROM lotes
GROUP BY fornecedor_id;
-- FIM DO SQL DO LIVRO
