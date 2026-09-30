# Databricks notebook source
# MAGIC %md
# MAGIC # Atlas 1.0 — da análise à decisão
# MAGIC
# MAGIC O último notebook conecta vendas, custo e margem e encerra com um registro explícito de evidência, limite e próxima medição.

# COMMAND ----------

# MAGIC %md
# MAGIC ## 1. Receita e custo por produto e mês

# COMMAND ----------

# MAGIC %sql
# MAGIC WITH vendas AS (
# MAGIC   SELECT
# MAGIC     date_trunc('month', p.data_pedido) AS mes,
# MAGIC     i.produto_id,
# MAGIC     sum(i.quantidade) AS quantidade,
# MAGIC     sum(i.quantidade * i.preco_venda) AS receita
# MAGIC   FROM atlas.livro.pedidos AS p
# MAGIC   JOIN atlas.livro.itens_pedido AS i USING (pedido_id)
# MAGIC   GROUP BY 1, 2
# MAGIC )
# MAGIC SELECT
# MAGIC   v.mes,
# MAGIC   pr.familia_id,
# MAGIC   sum(v.receita) AS receita,
# MAGIC   sum(v.quantidade * c.custo_total) AS custo,
# MAGIC   sum(v.receita - v.quantidade * c.custo_total) AS margem,
# MAGIC   round(
# MAGIC     100.0 * sum(v.receita - v.quantidade * c.custo_total) / sum(v.receita),
# MAGIC     2
# MAGIC   ) AS margem_percentual
# MAGIC FROM vendas AS v
# MAGIC JOIN atlas.livro.custos_produto AS c
# MAGIC   ON c.produto_id = v.produto_id
# MAGIC  AND c.mes = v.mes
# MAGIC JOIN atlas.livro.produtos AS pr
# MAGIC   ON pr.produto_id = v.produto_id
# MAGIC GROUP BY v.mes, pr.familia_id
# MAGIC ORDER BY v.mes, pr.familia_id;

# COMMAND ----------

# MAGIC %md
# MAGIC **Captura recomendada:** filtre `familia_id = 'AX'` e construa uma linha para `receita` e outra para `margem_percentual` em eixos ou gráficos separados. O contraste mostra por que vender mais não implica preservar rentabilidade.

# COMMAND ----------

# MAGIC %md
# MAGIC ## 2. Registro da decisão
# MAGIC
# MAGIC A tabela abaixo não é uma conclusão automática. Ela registra o que a equipe precisaria declarar antes de transformar a análise em ação.

# COMMAND ----------

registro = [
    (
        "Produção aprovada abaixo do plano",
        "Diferença mensal reproduzível entre planejado e aprovado",
        "Associação não identifica sozinha a causa",
        "Investigar conjuntamente mix, máquina, material e turno",
        "Atendimento do plano e taxa de refugo nas quatro semanas seguintes",
    )
]

display(
    spark.createDataFrame(
        registro,
        ["fato", "evidencia", "limite", "acao_proposta", "nova_medicao"],
    )
)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Encerramento
# MAGIC
# MAGIC Uma entrega completa contém a consulta, as validações executadas, a interpretação proporcional, os limites da evidência e a decisão que pode ser revista por uma nova medição.

