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

## Uso rápido

Requisitos: Python 3.10 ou superior. O gerador e o validador usam apenas a biblioteca padrão.

```powershell
python generate.py
python validate.py
```

Os CSVs são gravados em `data/`. Outra semente pode ser informada com `--seed`, mas somente `20260930` representa a edição 1.0 usada no livro.

Para executar as consultas locais de validação, instale o [DuckDB](https://duckdb.org/) e rode, a partir da raiz do repositório:

```powershell
duckdb < sql/validacoes.sql
```

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
├── sql/                # consultas de validação em DuckDB SQL
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
