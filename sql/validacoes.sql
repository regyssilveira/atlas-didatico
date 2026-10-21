-- Atlas 1.0 — consultas de validação em Databricks SQL
-- Importe os CSVs em atlas_lab.dados conforme o Apêndice A.
-- Use o mesmo objeto de consulta e warehouse no Editor de SQL.
-- Se a sessão for perdida, reexecute a preparação abaixo.
-- Substitua atlas_lab.dados pelo seu catálogo e esquema autorizados.

CREATE OR REPLACE TEMP VIEW pedidos AS SELECT * FROM atlas_lab.dados.pedidos;
CREATE OR REPLACE TEMP VIEW itens AS SELECT * FROM atlas_lab.dados.itens_pedido;
CREATE OR REPLACE TEMP VIEW ordens AS SELECT * FROM atlas_lab.dados.ordens_producao;
CREATE OR REPLACE TEMP VIEW apontamentos AS SELECT * FROM atlas_lab.dados.apontamentos_producao;
CREATE OR REPLACE TEMP VIEW lotes AS SELECT * FROM atlas_lab.dados.lotes_material;
CREATE OR REPLACE TEMP VIEW inspecoes AS SELECT * FROM atlas_lab.dados.inspecoes_qualidade;
CREATE OR REPLACE TEMP VIEW estoque AS SELECT * FROM atlas_lab.dados.estoque_mensal;
CREATE OR REPLACE TEMP VIEW sensores AS SELECT * FROM atlas_lab.dados.leituras_sensores_diarias;
CREATE OR REPLACE TEMP VIEW custos AS SELECT * FROM atlas_lab.dados.custos_produto;

-- 1. Demanda: a família AX cresce, mas de maneira desigual entre produtos.
SELECT year(p.data_pedido) AS ano, i.produto_id, sum(i.quantidade) AS unidades
FROM pedidos p JOIN itens i USING (pedido_id)
WHERE i.produto_id LIKE 'AX-%'
GROUP BY ALL ORDER BY produto_id, ano;

-- 2. Capacidade efetiva: o aprovado fica abaixo do planejado.
SELECT year(o.data_planejada) AS ano,
       sum(o.quantidade_planejada) AS planejado,
       sum(a.quantidade_aprovada) AS aprovado,
       round(100 * sum(a.quantidade_aprovada) / sum(o.quantidade_planejada), 1) AS atendimento_pct
FROM ordens o JOIN apontamentos a USING (ordem_producao_id)
WHERE o.produto_id LIKE 'AX-%'
GROUP BY ALL ORDER BY ano;

-- 3. Qualidade: fornecedor e máquina têm associações simultâneas com o refugo.
SELECT l.fornecedor_id, i.maquina_id,
       round(100 * sum(i.quantidade_reprovada) / sum(i.quantidade_inspecionada), 2) AS refugo_pct,
       count(*) AS inspecoes
FROM inspecoes i JOIN lotes l USING (lote_material_id)
WHERE i.data_inspecao >= DATE '2026-08-01'
GROUP BY ALL ORDER BY refugo_pct DESC;

-- 4. Sensores: deterioração antes da falha e recuo após a intervenção.
SELECT CASE
         WHEN data < DATE '2026-07-01' THEN 'base'
         WHEN data < DATE '2026-10-17' THEN 'deterioracao'
         ELSE 'pos_intervencao'
       END AS periodo,
       round(avg(valor), 2) AS vibracao_media
FROM sensores
WHERE variavel = 'vibracao' AND data >= DATE '2026-01-01'
GROUP BY ALL ORDER BY min(data);

-- 5. Estoque: valor agregado alto pode coexistir com baixa disponibilidade AX.
SELECT mes,
       round(sum(valor_estoque), 2) AS valor_total,
       sum(disponivel) FILTER (WHERE produto_id LIKE 'AX-%') AS disponivel_ax
FROM estoque
WHERE mes IN ('2026-08', '2026-11')
GROUP BY ALL ORDER BY mes;

-- 6. Receita e margem: crescimento comercial não garante rentabilidade.
SELECT year(p.data_pedido) AS ano,
       round(sum(i.quantidade * i.preco_venda), 2) AS receita,
       round(100 * sum(i.quantidade * (i.preco_venda - c.custo_total))
             / sum(i.quantidade * i.preco_venda), 2) AS margem_pct
FROM pedidos p
JOIN itens i USING (pedido_id)
JOIN custos c ON c.produto_id = i.produto_id
             AND c.mes = date_format(p.data_pedido, 'yyyy-MM')
WHERE i.produto_id LIKE 'AX-%'
GROUP BY ALL ORDER BY ano;

-- 7. Confundimento: compare VEN-027 no total e dentro da família AX.
SELECT CASE WHEN p.vendedor_id = 'VEN-027' THEN 'VEN-027' ELSE 'demais' END AS grupo,
       CASE WHEN i.produto_id LIKE 'AX-%' THEN 'AX' ELSE 'outras' END AS familia,
       round(100 * avg((p.data_entrega > p.data_prometida_original)::INTEGER), 1) AS atraso_pct,
       count(*) AS pedidos
FROM pedidos p JOIN itens i USING (pedido_id)
GROUP BY ALL ORDER BY grupo, familia;
