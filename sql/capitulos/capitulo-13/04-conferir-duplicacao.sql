-- Dos Dados à Decisão | capítulo 13 | etapa 4
-- Seção: Teste a consulta por mutação controlada
-- Bloco SQL 2 do capítulo; preserve a ordem do README.
-- Databricks SQL. Ajuste atlas_lab.dados para seu catálogo/esquema.
-- Mesma consulta e warehouse; retome preparações após perder sessão.
-- Não use Executar tudo no roteiro do capítulo 13. Confira o estado antes de avançar.
-- INÍCIO DO SQL DO LIVRO
SELECT count(*) AS linhas_teste
FROM custos_teste;

SELECT count(*) AS pares_repetidos
FROM (
  SELECT produto_id, mes
  FROM custos_teste
  GROUP BY produto_id, mes
  HAVING count(*) > 1
) repetidos;

SELECT count(*) AS itens_sem_custo
FROM atlas_lab.dados.itens_pedido i
JOIN atlas_lab.dados.pedidos p USING (pedido_id)
LEFT JOIN custos_teste c
  ON c.produto_id = i.produto_id
 AND c.mes = date_format(p.data_pedido, 'yyyy-MM')
WHERE c.produto_id IS NULL;
-- FIM DO SQL DO LIVRO
