# Capítulo 11

Capítulo 11 - Quando produção, estoque e comercial conversam

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `estoque_mensal`, `itens_pedido`, `ordens_producao`, `pedidos`, `produtos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-preparacao-bloco-03.sql](01-preparacao-bloco-03.sql) | Preparação / definição de visão. Acompanhe a investigação: uma carteira reconstruída no tempo |
| 2 | [02-preparacao-bloco-04.sql](02-preparacao-bloco-04.sql) | Preparação / definição de visão. Congele a informação disponível |
| 3 | [03-consulta-bloco-05.sql](03-consulta-bloco-05.sql) | Consulta / conferência. Congele a informação disponível |
| 4 | [04-preparacao-bloco-06.sql](04-preparacao-bloco-06.sql) | Preparação / definição de visão. Aloque o acabado sem duplicar saldo |
| 5 | [05-consulta-bloco-07.sql](05-consulta-bloco-07.sql) | Consulta / conferência. Converta dependência em horas e componente |
| 6 | [06-consulta-bloco-08.sql](06-consulta-bloco-08.sql) | Consulta / conferência. Converta dependência em horas e componente |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

No corte de 31/10/2026: 13 itens abertos, 489 unidades e três itens já atrasados. As 489 unidades encontram acabado disponível; dependência de produção é zero. A consulta de necessidade de produção deve retornar vazia.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 1: A granularidade do compromisso — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 2: Uma regra de classificação compreensível — fragmento ou configuração ilustrativa.
- Bloco 9: Classifique por fatores observáveis — fragmento ou configuração ilustrativa.
