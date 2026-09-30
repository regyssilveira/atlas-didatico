# Databricks notebook source
# MAGIC %md
# MAGIC # Atlas 1.0 — preparação do ambiente
# MAGIC
# MAGIC Este notebook cria um catálogo didático, baixa os arquivos públicos da versão `v1.0.0`, grava-os em um volume governado e publica 14 tabelas Delta.
# MAGIC
# MAGIC **Execute todas as células na ordem.** O processo é idempotente: uma nova execução atualiza os arquivos e substitui as tabelas com a mesma versão oficial.

# COMMAND ----------

CATALOGO = "atlas"
ESQUEMA = "livro"
VOLUME = "fontes"
VERSAO = "v1.0.0"
BASE_URL = (
    "https://raw.githubusercontent.com/"
    "regyssilveira/atlas-didatico/v1.0.0/data"
)

ARQUIVOS = [
    "apontamentos_producao.csv",
    "consumo_material.csv",
    "custos_produto.csv",
    "estoque_mensal.csv",
    "falhas_maquina.csv",
    "fornecedores.csv",
    "inspecoes_qualidade.csv",
    "itens_pedido.csv",
    "leituras_sensores_diarias.csv",
    "lotes_material.csv",
    "ordens_manutencao.csv",
    "ordens_producao.csv",
    "pedidos.csv",
    "produtos.csv",
]

print(f"Preparando Atlas 1.0 a partir da versão pública {VERSAO}.")

# COMMAND ----------

# MAGIC %md
# MAGIC ## 1. Criar catálogo, esquema e volume
# MAGIC
# MAGIC O namespace de três níveis será `atlas.livro.<tabela>`. O volume `atlas.livro.fontes` preserva os CSVs que deram origem às tabelas.

# COMMAND ----------

spark.sql(f"CREATE CATALOG IF NOT EXISTS {CATALOGO}")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS {CATALOGO}.{ESQUEMA}")
spark.sql(f"CREATE VOLUME IF NOT EXISTS {CATALOGO}.{ESQUEMA}.{VOLUME}")

volume_path = f"/Volumes/{CATALOGO}/{ESQUEMA}/{VOLUME}"
print(f"Volume pronto: {volume_path}")

# COMMAND ----------

# MAGIC %md
# MAGIC ## 2. Baixar os CSVs congelados
# MAGIC
# MAGIC Nenhum dado empresarial é enviado ao Databricks. Todos os registros são fictícios e vêm do repositório público do Atlas Didático.

# COMMAND ----------

from pathlib import Path
from urllib.request import urlopen

destino = Path(volume_path)
destino.mkdir(parents=True, exist_ok=True)

for arquivo in ARQUIVOS:
    url = f"{BASE_URL}/{arquivo}"
    conteudo = urlopen(url, timeout=60).read()
    caminho = destino / arquivo
    caminho.write_bytes(conteudo)
    print(f"{arquivo}: {len(conteudo):,} bytes")

# COMMAND ----------

# MAGIC %md
# MAGIC ## 3. Publicar as tabelas Delta
# MAGIC
# MAGIC A inferência de esquema é usada apenas para a experiência didática. Em produção, declare tipos e regras de evolução explicitamente.

# COMMAND ----------

from pathlib import Path

resumo = []
for arquivo in ARQUIVOS:
    tabela = Path(arquivo).stem
    origem = f"{volume_path}/{arquivo}"
    destino_tabela = f"{CATALOGO}.{ESQUEMA}.{tabela}"
    dataframe = (
        spark.read.option("header", True)
        .option("inferSchema", True)
        .csv(origem)
    )
    dataframe.write.mode("overwrite").option("overwriteSchema", True).saveAsTable(destino_tabela)
    resumo.append((tabela, dataframe.count()))

display(spark.createDataFrame(resumo, ["tabela", "linhas"]).orderBy("tabela"))

# COMMAND ----------

# MAGIC %md
# MAGIC ## 4. Conferência final
# MAGIC
# MAGIC O ambiente está pronto quando a consulta abaixo apresenta 14 tabelas no esquema `atlas.livro`.

# COMMAND ----------

# MAGIC %sql
# MAGIC SHOW TABLES IN atlas.livro;

# COMMAND ----------

quantidade_tabelas = spark.sql("SHOW TABLES IN atlas.livro").count()
assert quantidade_tabelas == 14, f"Esperadas 14 tabelas; encontradas {quantidade_tabelas}."
print("Atlas 1.0 pronto: 14 tabelas publicadas em atlas.livro.")

