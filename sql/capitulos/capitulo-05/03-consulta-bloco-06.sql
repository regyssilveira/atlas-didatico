-- Dos Dados à Decisão | capítulo 5 | etapa 3
-- Seção: A distância anual e sua decomposição
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    year(o.data_planejada) AS ano,
    sum(o.quantidade_planejada) AS planejada,
    sum(a.quantidade_produzida) AS produzida,
    sum(a.quantidade_aprovada) AS aprovada,
    sum(a.quantidade_refugada) AS refugada,
    round(100.0 * sum(a.quantidade_aprovada)
          / sum(o.quantidade_planejada), 1) AS atendimento_plano_pct
FROM ordens o
JOIN apontamentos a USING (ordem_producao_id)
WHERE o.produto_id LIKE 'AX-%'
GROUP BY ano
ORDER BY ano;
-- FIM DO SQL DO LIVRO
