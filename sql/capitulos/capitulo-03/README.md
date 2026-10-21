# Capítulo 3

Capítulo 3 - Os primeiros dados da Atlas

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `itens_pedido`, `leituras_sensores_diarias`, `pedidos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-preparacao-bloco-03.sql](01-preparacao-bloco-03.sql) | Preparação / definição de visão. Acompanhe a investigação: reconhecer antes de analisar |
| 2 | [02-consulta-bloco-04.sql](02-consulta-bloco-04.sql) | Consulta / conferência. Acompanhe a investigação: reconhecer antes de analisar |
| 3 | [03-consulta-bloco-05.sql](03-consulta-bloco-05.sql) | Consulta / conferência. Acompanhe a investigação: reconhecer antes de analisar |
| 4 | [04-consulta-bloco-06.sql](04-consulta-bloco-06.sql) | Consulta / conferência. Reconciliação entre fontes |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

Pedidos e itens têm 480 linhas; itens abrangem cinco produtos. Cada variável de sensor tem 522 leituras. As duas verificações de itens/pedidos sem correspondência retornam zero linhas.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 1: Granularidade: o que uma linha representa — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 2: A primeira aterrissagem da Atlas — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 7: Investigue os dados: o produto desaparecido — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
