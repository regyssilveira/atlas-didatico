-- Dos Dados à Decisão | capítulo 7 | etapa 4
-- Seção: Construa a linha de base sem contaminar o passado
-- Bloco SQL 6 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Confira o resultado e os limites do capítulo antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT
    data,
    valor AS vibracao,
    avg(valor) OVER (
        ORDER BY data
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS media_movel_20,
    max(valor) OVER (
        ORDER BY data
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS maximo_20
FROM sensores
WHERE maquina_id = 'MAQ-012'
  AND variavel = 'vibracao'
ORDER BY data;
-- FIM DO SQL DO LIVRO
