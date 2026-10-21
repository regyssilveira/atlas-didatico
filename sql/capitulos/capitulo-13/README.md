# Capítulo 13

Capítulo 13 - IA: quando os dados começam a trabalhar por você

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `custos_produto`, `itens_pedido`, `pedidos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-referencia.sql](01-referencia.sql) | Criar referência intacta. |
| 2 | [02-conferir-referencia.sql](02-conferir-referencia.sql) | Esperado: 120 / 0 / 0. |
| 3 | [03-duplicacao.sql](03-duplicacao.sql) | Introduzir somente a duplicação de janeiro. |
| 4 | [04-conferir-duplicacao.sql](04-conferir-duplicacao.sql) | Esperado: 121 / 1 / 0. Bloquear margem. |
| 5 | [05-ausencia.sql](05-ausencia.sql) | Partir da fonte intacta e excluir fevereiro da visão. |
| 6 | [06-conferir-ausencia.sql](06-conferir-ausencia.sql) | Esperado: 119 / 0 / 4. Bloquear margem. |
| 7 | [07-restauracao.sql](07-restauracao.sql) | Restaurar visão e confirmar 120 linhas na fonte. |
| 8 | [08-conferir-restauracao.sql](08-conferir-restauracao.sql) | Esperado: 120 / 0 / 0. |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

Referência 120/0/0; duplicação 121/1/0; ausência 119/0/4; restauração 120/0/0, na ordem linhas, pares repetidos e itens sem custo. Fonte original: 120 linhas. Não calcule a margem nos estados reprovados.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

As etapas 2, 4, 6 e 8 repetem exatamente os mesmos três diagnósticos, mas em estados diferentes. A etapa 3 introduz duplicação; a 5 parte da fonte intacta e introduz ausência; a 7 restaura a visão e conta a fonte. Não acumule as alterações. Sem IA, execute o mesmo teste; o painel assistido não é requisito.

Para retomar, execute 01-referencia.sql e depois somente o estado desejado: 03-duplicacao.sql ou 05-ausencia.sql, seguido da conferência correspondente. Não reexecute todas as alterações anteriores. Termine por 07-restauracao.sql e 08-conferir-restauracao.sql. Para adaptar a consulta de margem, siga as três substituições explicadas no capítulo 13; o original está na etapa 5 do capítulo 10.
