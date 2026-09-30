-- Atlas 1.0 — consultas de validação em DuckDB
-- Execute a partir de examples/atlas_1_0.

CREATE OR REPLACE VIEW pedidos AS SELECT * FROM read_csv_auto('data/pedidos.csv');
CREATE OR REPLACE VIEW itens AS SELECT * FROM read_csv_auto('data/itens_pedido.csv');
CREATE OR REPLACE VIEW ordens AS SELECT * FROM read_csv_auto('data/ordens_producao.csv');
CREATE OR REPLACE VIEW apontamentos AS SELECT * FROM read_csv_auto('data/apontamentos_producao.csv');
CREATE OR REPLACE VIEW lotes AS SELECT * FROM read_csv_auto('data/lotes_material.csv');
CREATE OR REPLACE VIEW inspecoes AS SELECT * FROM read_csv_auto('data/inspecoes_qualidade.csv');
CREATE OR REPLACE VIEW estoque AS SELECT * FROM read_csv_auto('data/estoque_mensal.csv');
CREATE OR REPLACE VIEW sensores AS SELECT * FROM read_csv_auto('data/leituras_sensores_diarias.csv');
CREATE OR REPLACE VIEW custos AS SELECT * FROM read_csv_auto('data/custos_produto.csv');

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
             AND c.mes = strftime(p.data_pedido, '%Y-%m')
WHERE i.produto_id LIKE 'AX-%'
GROUP BY ALL ORDER BY ano;

-- 7. Confundimento: compare VEN-027 no total e dentro da família AX.
SELECT CASE WHEN p.vendedor_id = 'VEN-027' THEN 'VEN-027' ELSE 'demais' END AS grupo,
       CASE WHEN i.produto_id LIKE 'AX-%' THEN 'AX' ELSE 'outras' END AS familia,
       round(100 * avg((p.data_entrega > p.data_prometida_original)::INTEGER), 1) AS atraso_pct,
       count(*) AS pedidos
FROM pedidos p JOIN itens i USING (pedido_id)
GROUP BY ALL ORDER BY grupo, familia;
