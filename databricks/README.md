# Atlas 1.0 no Databricks

Esta pasta contém notebooks em formato de fonte reconhecido pelo Databricks. Eles usam apenas dados fictícios da release pública `v1.0.0`.

## Material histórico de manutenção editorial

Estes notebooks não são o percurso do leitor iniciante. Para praticar o livro, use os CSVs prontos e SQL no Databricks conforme o [README principal](../README.md), o capítulo 2 e o Apêndice A. Não é necessário executar os notebooks desta pasta.

### Ordem do pacote editorial histórico

1. `00_preparar_atlas.py` — cria catálogo, esquema, volume e 14 tabelas;
2. `01_conhecer_os_dados.py` — inventário, contrato, período e relações;
3. `02_investigar_producao_qualidade.py` — produção, qualidade e sensores;
4. `03_da_analise_a_decisao.py` — receita, margem e registro da decisão.

Consulte [`../docs/databricks/roteiro-execucao-captura.md`](../docs/databricks/roteiro-execucao-captura.md) para clonar o repositório, executar os notebooks e produzir as capturas editoriais.

Os notebooks criam objetos sob `atlas.livro`. Não execute o notebook de preparação em um ambiente no qual esses nomes já sejam usados por dados reais.
