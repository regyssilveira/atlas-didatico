# Capítulo 10

Capítulo 10 - Vender mais significa ganhar mais?

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `custos_produto`, `itens_pedido`, `pedidos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-preparacao-bloco-03.sql](01-preparacao-bloco-03.sql) | Preparação / definição de visão. Acompanhe a investigação: reconciliar crescimento e margem |
| 2 | [02-consulta-bloco-04.sql](02-consulta-bloco-04.sql) | Consulta / conferência. Confirme a granularidade econômica |
| 3 | [03-consulta-bloco-05.sql](03-consulta-bloco-05.sql) | Consulta / conferência. Confirme a granularidade econômica |
| 4 | [04-consulta-bloco-06.sql](04-consulta-bloco-06.sql) | Consulta / conferência. Confirme custo único por produto e mês |
| 5 | [05-consulta-bloco-07.sql](05-consulta-bloco-07.sql) | Consulta / conferência. Calcule receita e margem com a mesma população |
| 6 | [06-consulta-bloco-08.sql](06-consulta-bloco-08.sql) | Consulta / conferência. Localize desconto, custo e mix |
| 7 | [07-consulta-bloco-09.sql](07-consulta-bloco-09.sql) | Consulta / conferência. Localize desconto, custo e mix |
| 8 | [08-consulta-bloco-10.sql](08-consulta-bloco-10.sql) | Consulta / conferência. Teste a acusação contra o vendedor |
| 9 | [09-consulta-bloco-11.sql](09-consulta-bloco-11.sql) | Consulta / conferência. Teste a acusação contra o vendedor |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

Antes da margem: a etapa 3 deve mostrar 480 itens, 480 com custo e zero sem custo, sem aumentar o total anterior à junção. A etapa 4 verifica custo único por produto/mês: nenhuma linha deve retornar. Qualquer par repetido bloqueia a margem; investigue sem escolher ou fazer média de custos arbitrariamente. Depois de aprovadas as conferências, a etapa 5 calcula AX: receita aproximada de R$ 8,04 milhões para R$ 8,93 milhões e margem percentual de 28,16% para 24,25%.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 1: Desconto não é sinônimo de perda — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 2: A pista falsa do vendedor — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
