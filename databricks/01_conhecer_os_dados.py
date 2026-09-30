# Databricks notebook source
# MAGIC %md
# MAGIC # Atlas 1.0 — reconhecer antes de analisar
# MAGIC
# MAGIC O primeiro contato não procura uma causa. Ele confirma localização, granularidade, período e significado dos dados disponíveis.

# COMMAND ----------

# MAGIC %md
# MAGIC ## 1. Inventário do esquema
# MAGIC
# MAGIC Observe no painel **Catalog** a hierarquia `atlas` → `livro` → tabelas. Depois execute a célula.

# COMMAND ----------

# MAGIC %sql
# MAGIC SHOW TABLES IN atlas.livro;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 2. Contrato de uma tabela
# MAGIC
# MAGIC `ordens_producao` possui uma linha por ordem planejada. A descrição física ajuda a conferir tipos, localização e formato.

# COMMAND ----------

# MAGIC %sql
# MAGIC DESCRIBE TABLE EXTENDED atlas.livro.ordens_producao;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 3. Período, volume e chaves

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   count(*) AS linhas,
# MAGIC   count(DISTINCT ordem_producao_id) AS ordens_distintas,
# MAGIC   min(data_planejada) AS primeira_data,
# MAGIC   max(data_planejada) AS ultima_data
# MAGIC FROM atlas.livro.ordens_producao;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 4. Amostra legível
# MAGIC
# MAGIC Uma amostra serve para reconhecer valores e formatos; não substitui distribuições, reconciliações ou testes de qualidade.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   ordem_producao_id,
# MAGIC   produto_id,
# MAGIC   linha_id,
# MAGIC   data_planejada,
# MAGIC   quantidade_planejada,
# MAGIC   status
# MAGIC FROM atlas.livro.ordens_producao
# MAGIC ORDER BY data_planejada, ordem_producao_id
# MAGIC LIMIT 20;

# COMMAND ----------

# MAGIC %md
# MAGIC ## 5. Relações disponíveis
# MAGIC
# MAGIC A consulta mostra como uma ordem planejada se conecta aos apontamentos executados sem supor que a junção seja sempre um para um.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT
# MAGIC   o.ordem_producao_id,
# MAGIC   count(a.apontamento_id) AS apontamentos,
# MAGIC   sum(a.quantidade_produzida) AS produzido,
# MAGIC   sum(a.quantidade_aprovada) AS aprovado,
# MAGIC   sum(a.quantidade_refugada) AS refugado
# MAGIC FROM atlas.livro.ordens_producao AS o
# MAGIC LEFT JOIN atlas.livro.apontamentos_producao AS a
# MAGIC   ON a.ordem_producao_id = o.ordem_producao_id
# MAGIC GROUP BY o.ordem_producao_id
# MAGIC ORDER BY o.ordem_producao_id
# MAGIC LIMIT 20;

