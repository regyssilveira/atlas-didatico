# Capítulo 7

Capítulo 7 - Havia sinais antes da falha?

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `falhas_maquina`, `leituras_sensores_diarias`, `ordens_manutencao`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-preparacao-bloco-03.sql](01-preparacao-bloco-03.sql) | Preparação / definição de visão. Acompanhe a investigação: analisar sem olhar o futuro |
| 2 | [02-consulta-bloco-04.sql](02-consulta-bloco-04.sql) | Consulta / conferência. Verifique a frequência observada |
| 3 | [03-consulta-bloco-05.sql](03-consulta-bloco-05.sql) | Consulta / conferência. Construa a linha de base sem contaminar o passado |
| 4 | [04-consulta-bloco-06.sql](04-consulta-bloco-06.sql) | Consulta / conferência. Construa a linha de base sem contaminar o passado |
| 5 | [05-consulta-bloco-07.sql](05-consulta-bloco-07.sql) | Consulta / conferência. Congele uma data de observação |
| 6 | [06-consulta-bloco-08.sql](06-consulta-bloco-08.sql) | Consulta / conferência. Congele uma data de observação |
| 7 | [07-consulta-bloco-09.sql](07-consulta-bloco-09.sql) | Consulta / conferência. Compare antes e depois da intervenção |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

Cada variável tem uma observação por dia de segunda a sexta, sem calendário de feriados. Compare linha de base, deterioração e período posterior à intervenção. Não use o futuro no corte de 10 de outubro.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 1: Janelas antes e depois dos eventos — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 2: MTBF e MTTR sem ilusão de precisão — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
