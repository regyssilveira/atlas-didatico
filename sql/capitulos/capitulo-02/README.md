# Capítulo 2

Capítulo 2 - Databricks sem complicação

## Preparação

Leia o capítulo no livro para a pergunta, a interpretação e os limites. Os arquivos abaixo só evitam a transcrição; não substituem as explicações.

Tabelas a importar no mesmo catálogo/esquema: `pedidos`.

No Editor de SQL, crie uma consulta só para este capítulo. Mantenha o mesmo objeto de consulta e warehouse. Ajuste atlas_lab.dados para seu par autorizado em todos os arquivos; não crie outro catálogo para imitar o exemplo. Não use tabelas corporativas nem sobrescreva dados.

A primeira etapa marcada como preparação cria os nomes curtos usados depois. Se não houver preparação, o SQL usa nomes completos. Cada arquivo pode ter mais de uma instrução: execute o comando inteiro até o ponto e vírgula, incluindo o SELECT de uma definição de visão.

## Ordem de execução

| Etapa | Arquivo | Finalidade |
|---:|---|---|
| 1 | [01-consulta-bloco-01.sql](01-consulta-bloco-01.sql) | Consulta / conferência. 5. Observe três pedidos |
| 2 | [02-consulta-bloco-02.sql](02-consulta-bloco-02.sql) | Consulta / conferência. 6. Conte a lista inteira |
| 3 | [03-consulta-bloco-03.sql](03-consulta-bloco-03.sql) | Consulta / conferência. 7. Faça uma pergunta com um recorte |
| 4 | [04-preparacao-bloco-06.sql](04-preparacao-bloco-06.sql) | Preparação / definição de visão. Prática opcional com os dados do caso |

Execute o próximo arquivo somente depois de conferir o anterior. Não concatene os arquivos para rodar tudo de uma vez.

## Conferência e limites

Primeiras respostas: três pedidos na amostra; 480 no total; 240 em 2026. No perfil final, 480 linhas e pedidos, de 03/01/2025 a 24/12/2026.

Compare as demais saídas com os quadros e comentários da seção correspondente no livro. Uma divergência pede conferir carga, tipos, versão, prefixos e ordem; não altere o SQL só para forçar o resultado.

## Retomada e cuidados

As únicas definições publicadas aqui são visões temporárias; nenhuma etapa insere, apaga ou atualiza linhas nas tabelas importadas. Use uma consulta exclusiva para não substituir visões de outro trabalho. Após perda de sessão, reexecute as preparações deste capítulo na ordem, inclusive visões derivadas, antes da análise que depende delas.

## Blocos do livro que não devem ser executados com os CSVs

Estes blocos foram excluídos intencionalmente, sem remover seu conteúdo do livro:

- Bloco 4: SQL: formular uma pergunta para os dados — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
- Bloco 5: Investigue os dados: antes de confiar na primeira tabela — fontes empresariais ou pré-requisitos não fornecidos pelos CSVs.
