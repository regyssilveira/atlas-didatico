-- Dos Dados à Decisão | capítulo 12 | etapa 1
-- Seção: Passo 2 — calcule atualidade por fonte
-- Bloco SQL 1 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
WITH atualidade AS (
    SELECT 'pedidos' AS fonte, max(data_pedido) AS ultimo_evento
    FROM atlas_lab.dados.pedidos
    UNION ALL
    SELECT 'producao', max(data_producao)
    FROM atlas_lab.dados.apontamentos_producao
    UNION ALL
    SELECT 'estoque', max(last_day(to_date(substr(CAST(mes AS STRING), 1, 7) || '-01')))
    FROM atlas_lab.dados.estoque_mensal
    UNION ALL
    SELECT 'sensores', max(data)
    FROM atlas_lab.dados.leituras_sensores_diarias
)
SELECT
    fonte,
    ultimo_evento,
    datediff(DATE '2027-01-05', ultimo_evento) AS dias_desde_evento
FROM atualidade
ORDER BY fonte;
-- FIM DO SQL DO LIVRO
