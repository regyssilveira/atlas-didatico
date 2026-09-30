# Databricks notebook source
# MAGIC %md
# MAGIC # Atlas 1.0 — investigar produção e qualidade
# MAGIC
# MAGIC As consultas avançam do resultado agregado para recortes concorrentes. Nenhuma delas, isoladamente, prova uma causa.

# COMMAND ----------

# MAGIC %md
# MAGIC ## 1. Plano, produção e aprovação por mês

# COMMAND ----------

# MAGIC %sql
# MAGIC WITH plano AS (
# MAGIC   SELECT
# MAGIC     date_trunc('month', data_planejada) AS mes,
# MAGIC     sum(quantidade_planejada) AS planejado
# MAGIC   FROM atlas.livro.ordens_producao
# MAGIC   GROUP BY 1
# MAGIC ),
# MAGIC realizado AS (
# MAGIC   SELECT
# MAGIC     date_trunc('month', data_producao) AS mes,
# MAGIC     sum(quantidade_produzida) AS produzido,
# MAGIC     sum(quantidade_aprovada) AS aprovado,
# MAGIC     sum(quantidade_refugada) AS refugado
# MAGIC   FROM atlas.livro.apontamentos_producao
# MAGIC   GROUP BY 1
# MAGIC )
# MAGIC SELECT
# MAGIC   p.mes,
# MAGIC   p.planejado,
# MAGIC   r.produzido,
# MAGIC   r.aprovado,
# MAGIC   r.refugado,
# MAGIC   round(100.0 * r.aprovado / p.planejado, 1) AS atendimento_percentual
# MAGIC FROM plano AS p
# MAGIC JOIN realizado AS r USING (mes)
# MAGIC ORDER BY p.mes;

# COMMAND ----------

# MAGIC %md
# MAGIC **Captura recomendada:** transforme o resultado anterior em um gráfico de linhas com `mes` no eixo horizontal e `planejado`, `produzido` e `aprovado` como séries. O gráfico deve mostrar a distância entre demanda planejada, execução e saída boa.

# COMMAND ----------

# MAGIC %md
# MAGIC ## 2. Refugo por linha e máquina

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   linha_id,
# MAGIC   maquina_id,
# MAGIC   sum(quantidade_produzida) AS produzido,
# MAGIC   sum(quantidade_refugada) AS refugado,
# MAGIC   round(100.0 * sum(quantidade_refugada) / sum(quantidade_produzida), 2) AS taxa_refugo
# MAGIC FROM atlas.livro.apontamentos_producao
# MAGIC GROUP BY linha_id, maquina_id
# MAGIC ORDER BY taxa_refugo DESC;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 3. Fornecedor, lote e inspeção
# MAGIC
# MAGIC A associação é observável, mas fornecedor, máquina, produto e período permanecem hipóteses concorrentes.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   l.fornecedor_id,
# MAGIC   i.maquina_id,
# MAGIC   count(DISTINCT i.inspecao_id) AS inspecoes,
# MAGIC   sum(i.quantidade_inspecionada) AS inspecionado,
# MAGIC   sum(i.quantidade_reprovada) AS reprovado,
# MAGIC   round(
# MAGIC     100.0 * sum(i.quantidade_reprovada) / sum(i.quantidade_inspecionada),
# MAGIC     2
# MAGIC   ) AS taxa_reprovacao
# MAGIC FROM atlas.livro.inspecoes_qualidade AS i
# MAGIC JOIN atlas.livro.lotes_material AS l
# MAGIC   ON l.lote_material_id = i.lote_material_id
# MAGIC GROUP BY l.fornecedor_id, i.maquina_id
# MAGIC ORDER BY taxa_reprovacao DESC;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 4. Sensores antes da falha

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   data,
# MAGIC   avg(valor) AS vibracao_media
# MAGIC FROM atlas.livro.leituras_sensores_diarias
# MAGIC WHERE maquina_id = 'MAQ-012'
# MAGIC   AND variavel = 'vibracao'
# MAGIC GROUP BY data
# MAGIC ORDER BY data;

# COMMAND ----------

# MAGIC %md
# MAGIC **Captura recomendada:** crie um gráfico de linhas para a vibração. A figura serve para formular a pergunta temporal; não deve ser apresentada como prova automática de causalidade.

