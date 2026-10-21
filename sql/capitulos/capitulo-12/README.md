# Capítulo 12

Capítulo 12 - Da análise ao acompanhamento

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `apontamentos_producao`, `estoque_mensal`, `leituras_sensores_diarias`, `pedidos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-consulta-bloco-01.sql](01-consulta-bloco-01.sql) | Consulta / conferência. Passo 2 — calcule atualidade por fonte |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

A data de referência é fixa: 05/01/2027. Compare as quatro fontes conforme a periodicidade, não com a data em que você lê o livro. O arquivo não cria Job, dashboard ou alerta.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 2: Passo 4 — separe cálculo, publicação e alerta — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
