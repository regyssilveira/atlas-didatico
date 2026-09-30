# Roteiro de execução e captura no Databricks

Este roteiro prepara o Atlas 1.0 e produz seis capturas úteis ao livro **Dos Dados à Decisão**. As instruções evitam depender da posição exata de botões e preservam apenas elementos estruturais da interface.

## Antes de começar

- use o workspace criado exclusivamente para o livro;
- mantenha somente dados fictícios do Atlas;
- prefira tema claro e zoom do navegador em 100%;
- feche Genie Code, notificações, menus de conta e painéis que exibam e-mail;
- não mostre a URL completa do workspace;
- não inclua chaves, tokens, IDs da conta ou mensagens pessoais;
- use a release `v1.0.0` e a semente `20260930`.

## 1. Clonar o repositório público

1. No workspace, abra **Workspace**.
2. Escolha a opção de criar ou adicionar uma **Git folder**.
3. Informe `https://github.com/regyssilveira/atlas-didatico`.
4. Selecione a branch `main`.
5. Abra a pasta `databricks`.

Se Git folders não estiver disponível, importe individualmente os quatro arquivos `.py` da pasta `databricks`. O comentário `Databricks notebook source` faz com que sejam reconhecidos como notebooks.

## 2. Executar a preparação

1. Abra `00_preparar_atlas`.
2. Conecte o notebook ao compute serverless oferecido pelo workspace.
3. Execute todas as células.
4. Aguarde a mensagem `Atlas 1.0 pronto: 14 tabelas publicadas em atlas.livro.`
5. Se `CREATE CATALOG` não for autorizado, substitua `CATALOGO = "atlas"` pelo catálogo padrão exibido no workspace e execute novamente.

Não continue se a conferência final não apresentar exatamente 14 tabelas.

## 3. Executar os demais notebooks

Execute, na ordem:

1. `01_conhecer_os_dados`;
2. `02_investigar_producao_qualidade`;
3. `03_da_analise_a_decisao`.

Uma célula pode iniciar o compute automaticamente. Aguarde o resultado antes de executar a seguinte para que as capturas mostrem estados completos.

## 4. Padrão das capturas

- formato PNG;
- resolução nativa da tela, sem redimensionamento durante a captura;
- janela maximizada;
- tema claro;
- zoom do navegador em 100%;
- cursor fora da área importante;
- nenhum menu flutuante sem função didática;
- nomes `atlas`, `livro` e códigos fictícios visíveis;
- e-mail, avatar, URL e identificadores reais fora do enquadramento;
- uma única intenção didática por imagem.

Salve os arquivos com os nomes indicados em `docs/databricks/capturas/`. Essa pasta não precisa ser criada antes; ela pode ser adicionada quando as imagens estiverem prontas.

## 5. As seis capturas

### Captura 1 — orientação do workspace

**Estado:** página inicial do Databricks com a navegação lateral expandida.

**Enquadrar:** `Workspace`, `Catalog`, `Jobs & Pipelines`, `Compute` e `SQL Editor`.

**Excluir:** barra superior com e-mail, seletor de workspace e URL do navegador.

**Arquivo:** `01-workspace-orientacao.png`

**Uso previsto:** Capítulo 2, ao apresentar o Databricks como ambiente de investigação.

### Captura 2 — anatomia do notebook

**Estado:** notebook `01_conhecer_os_dados`, com uma célula SQL e seu resultado visíveis.

**Enquadrar:** título do notebook, seletor de compute, linguagem da célula, comando, botão de execução e resultado.

**Excluir:** conta do usuário e painéis de IA.

**Arquivo:** `02-notebook-anatomia.png`

**Uso previsto:** Capítulo 2, junto à primeira execução orientada.

### Captura 3 — catálogo, esquema e tabela

**Estado:** Catalog Explorer aberto em `atlas.livro.ordens_producao`.

**Enquadrar:** árvore `atlas` → `livro`, nome da tabela e lista inicial de colunas.

**Excluir:** identificadores administrativos e abas de permissões.

**Arquivo:** `03-catalogo-hierarquia.png`

**Uso previsto:** Capítulo 3, ao explicar catálogo, esquema, tabela, colunas e granularidade.

### Captura 4 — resultado tabular verificável

**Estado:** resultado da célula “Período, volume e chaves” do notebook `01_conhecer_os_dados`.

**Enquadrar:** consulta e uma única linha de resultado com contagem, ordens distintas e datas mínima e máxima.

**Arquivo:** `04-validacao-periodo-chaves.png`

**Uso previsto:** Capítulo 4, como exemplo de validação antes da análise.

### Captura 5 — plano, produção e aprovação

**Estado:** primeira consulta do notebook `02_investigar_producao_qualidade`, convertida em gráfico de linhas.

**Configuração visual:** `mes` no eixo horizontal; `planejado`, `produzido` e `aprovado` como séries; título “Plano, produção e aprovação por mês”.

**Arquivo:** `05-producao-plano-realizado.png`

**Uso previsto:** Capítulo 5, para mostrar a passagem da pergunta ao padrão temporal.

### Captura 6 — receita e margem

**Estado:** primeira consulta do notebook `03_da_analise_a_decisao`, filtrada para a família `AX`.

**Configuração visual:** um gráfico para receita e outro para margem percentual, ou um painel que não misture escalas incompatíveis.

**Arquivo:** `06-receita-margem-ax.png`

**Uso previsto:** Capítulo 10, ao demonstrar por que faturamento e rentabilidade precisam ser reconciliados.

## 6. Conferência antes de enviar as imagens

Para cada PNG, confirme:

- a intenção didática pode ser descrita em uma frase;
- o texto permanece legível no tamanho de página 16 × 23 cm;
- nenhuma informação pessoal ou identificador real aparece;
- nenhum resultado está cortado;
- a interface não é apresentada como prova da conclusão;
- a legenda poderá continuar correta mesmo se um botão mudar de posição.

## 7. Entrega das capturas

Coloque os seis PNGs em `docs/databricks/capturas/` ou anexe-os à conversa. Depois disso, as imagens serão recortadas, anotadas, copiadas para os ativos do livro e inseridas nos capítulos correspondentes com legenda, texto alternativo e aviso de versão da interface.

## Legenda editorial padrão

> Interface do Databricks consultada em setembro de 2026. A disposição dos controles pode variar conforme a edição, a nuvem, as permissões e as atualizações da plataforma. Dados fictícios do Atlas 1.0.
