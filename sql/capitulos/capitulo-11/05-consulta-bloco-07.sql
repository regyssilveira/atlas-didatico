-- Dos Dados à Decisão | capítulo 11 | etapa 5
-- Seção: Converta dependência em horas e componente
-- Bloco SQL 7 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH necessidade AS (
    SELECT
        pedido_id,
        produto_id,
        depende_producao
    FROM resultado_alocacao
    WHERE depende_producao > 0
      AND produto_id LIKE 'AX-%'
)
SELECT
    n.pedido_id,
    n.produto_id,
    n.depende_producao,
    round(n.depende_producao * p.tempo_padrao_minuto / 60, 2)
        AS horas_padrao,
    n.depende_producao AS necessidade_cmp_047
FROM necessidade n
JOIN produtos p USING (produto_id);
-- FIM DO SQL DO LIVRO
