# Atlas Didático

Dataset empresarial fictício, determinístico e reproduzível usado no livro **Dos Dados à Decisão: Databricks na prática para investigar problemas reais de negócio**, de Régys Borges da Silveira.

O Atlas foi construído para praticar investigação analítica sem uma coluna de “causa raiz”. Os arquivos conectam produção, qualidade, manutenção, sensores, estoque, fornecedores, pedidos, custos e margem. O objetivo é formular perguntas, validar relações e distinguir fato, evidência, hipótese e lacuna antes de recomendar uma ação.

Página do livro: <https://livros.regys.com.br/dos-dados-a-decisao>

## Versão oficial

- dataset: Atlas 1.0;
- semente: `20260930`;
- período simulado: janeiro de 2025 a dezembro de 2026;
- licença: Apache License 2.0;
- todos os nomes, códigos, eventos e valores são fictícios.

O arquivo `manifest.json` registra a versão, a semente, a contagem de linhas e o SHA-256 de cada CSV. A versão oficial é a que passa integralmente por `validate.py`.

## Dois percursos

O livro pode ser lido sem baixar o Atlas, abrir conta ou executar SQL: os resultados essenciais estão nos capítulos. Este repositório é uma referência opcional para reproduzir as análises no Databricks.

Para a prática do leitor, baixe **atlas-leitor-v1.0.2.zip** da [release v1.0.2](https://github.com/regyssilveira/atlas-didatico/releases/tag/v1.0.2) e extraia o arquivo pelo sistema operacional. Os CSVs prontos estão na pasta `data`. Siga o capítulo 2 e o Apêndice A: importe um CSV por tabela pela interface, use catálogo e esquema de aprendizagem autorizados e execute SQL no Databricks. Não são necessários terminal, geração de dados ou Git folder. Não sobrescreva tabelas existentes.

A release `v1.0.2` atualiza documentação, SQL e empacotamento, não os dados: preserva o dataset Atlas 1.0, seus 14 CSVs e o manifesto original. O pacote do leitor preserva também as quebras de linha usadas nos hashes do manifesto. Os arquivos automáticos **Source code** do GitHub podem normalizar essas quebras; para a prática, prefira o pacote nomeado acima. As tags anteriores permanecem disponíveis por rastreabilidade.

O livro usa `atlas_lab.dados`; substitua esse par pelo catálogo e esquema disponíveis na sua conta, por exemplo `atlas.livro`, em todas as consultas. Identificadores, códigos, `mes` e `turno_id` devem permanecer STRING; datas sem horário são DATE e medidas são numéricas. Em `falhas_maquina`, preserve `inicio_falha` e `fim_falha` como TIMESTAMP: converter esses campos para DATE apaga os horários. Confira os tipos no Apêndice A antes de prosseguir.

Comece apenas por `pedidos.csv`. A conferência deve retornar 480 linhas, início em 2025-01-03, fim em 2026-12-24 e 240 pedidos em 2026. Amplie para as demais tabelas somente depois dessa primeira resposta. As outras conferências de integridade estão no Apêndice A.

## Manutenção editorial — não é requisito do leitor

Os geradores e validadores preservados no repositório servem à manutenção editorial. Não execute esses programas nem altere a semente ou os CSVs oficiais para acompanhar o livro. O leitor utiliza somente os arquivos prontos e SQL no Databricks.

## Executar no Databricks

A prática do leitor ocorre exclusivamente em SQL no Databricks, com os CSVs prontos, conforme o capítulo 2 e o Apêndice A. Use o Editor de SQL e mantenha o mesmo objeto de consulta e warehouse nas sequências com visões temporárias. Se perder a sessão, execute novamente a preparação antes da análise. Um notebook SQL é uma alternativa, não um requisito. Se faltarem acesso ou computação, peça preparação ao administrador; a leitura autônoma continua disponível.

A pasta [`databricks/`](databricks/) preserva notebooks históricos de manutenção editorial. Não são o percurso do leitor nem requisitos para acompanhar o livro.

O [`roteiro de execução e captura`](docs/databricks/roteiro-execucao-captura.md) é um documento de produção editorial, não uma etapa exigida ao leitor.

## Escopo do caso

- família central `AX`, com os produtos `AX-100`, `AX-110`, `AX-120` e `AX-130`;
- linhas `L03` e `L04`, com `AX-120` prioritariamente na `L03`;
- máquina crítica `MAQ-012`;
- componente `CMP-047` e fornecedores `FOR-018` e `FOR-052`;
- campanha `CMP-COM-2026-07-AX`, entre julho e setembro de 2026.

## Tabelas

| Arquivo | Granularidade |
|---|---|
| `produtos.csv` | um produto |
| `fornecedores.csv` | um fornecedor |
| `pedidos.csv` | um pedido |
| `itens_pedido.csv` | um produto em um pedido |
| `ordens_producao.csv` | uma ordem de produção |
| `apontamentos_producao.csv` | uma execução semanal de ordem |
| `lotes_material.csv` | um lote recebido de componente |
| `consumo_material.csv` | um lote consumido em uma ordem |
| `inspecoes_qualidade.csv` | uma inspeção de ordem |
| `estoque_mensal.csv` | um produto e local no fechamento mensal |
| `leituras_sensores_diarias.csv` | uma máquina, variável e dia |
| `falhas_maquina.csv` | uma falha registrada |
| `ordens_manutencao.csv` | uma intervenção |
| `custos_produto.csv` | um produto e mês |

## Estrutura

```text
.
├── data/               # CSVs congelados da versão oficial
├── sql/                # material técnico de manutenção editorial
├── generate.py         # gerador determinístico
├── validate.py         # valida contagens, hashes e invariantes
└── manifest.json       # identidade verificável do Atlas 1.0
```

## Limites de interpretação

O dataset contém sinais deliberadamente conectados, mas não autoriza inferência causal automática. Correlação temporal, concentração por linha, turno, produto ou fornecedor são pontos de investigação. Qualquer conclusão deve declarar granularidade, período, população, validações e evidências ausentes.

## Contribuições e versões

A versão `1.0` permanece congelada para conservar a correspondência com o livro. Correções que alterem dados, contagens ou hashes devem ser publicadas em uma nova versão e documentadas no manifesto. Issues e pull requests são bem-vindos para erros de documentação, portabilidade e validação.

## Licença e atribuição

Código, documentação e dados fictícios deste repositório são distribuídos sob a [Apache License 2.0](LICENSE). Ao reutilizar o material, preserve o aviso de licença e atribua o projeto **Atlas Didático**, de Régys Borges da Silveira.
