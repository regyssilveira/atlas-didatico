from __future__ import annotations

import csv
import hashlib
import json
import statistics
from collections import defaultdict
from datetime import date
from pathlib import Path

DATA = Path(__file__).resolve().parent / "data"


def read(name: str) -> list[dict[str, str]]:
    path = DATA / name
    if not path.exists():
        raise SystemExit(f"Ausente: {path}. Execute generate.py primeiro.")
    with path.open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def ratio(part: float, whole: float) -> float:
    return part / whole if whole else 0.0


def require(condition: bool, message: str):
    if not condition:
        raise AssertionError(message)
    print(f"OK: {message}")


def main():
    manifest_path = DATA.parent / "manifest.json"
    require(manifest_path.exists(), "manifesto da versão Atlas 1.0 existe")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    require(manifest.get("version") == "1.0" and manifest.get("seed") == 20260930, "versão e semente oficiais estão congeladas")
    for filename, expected in manifest["files"].items():
        path = DATA / filename
        require(path.exists() and hashlib.sha256(path.read_bytes()).hexdigest() == expected["sha256"], f"integridade de {filename}")

    orders = read("pedidos.csv")
    items = read("itens_pedido.csv")
    logs = read("apontamentos_producao.csv")
    lots = read("lotes_material.csv")
    consumption = read("consumo_material.csv")
    inspections = read("inspecoes_qualidade.csv")
    stock = read("estoque_mensal.csv")
    sensors = read("leituras_sensores_diarias.csv")
    costs = read("custos_produto.csv")
    production_orders = read("ordens_producao.csv")

    item_by_order = {row["pedido_id"]: row for row in items}
    lot_by_id = {row["lote_material_id"]: row for row in lots}
    lot_by_order = {row["ordem_producao_id"]: row["lote_material_id"] for row in consumption}

    demand: dict[tuple[int, str], float] = defaultdict(float)
    delay_by_seller: dict[str, list[int]] = defaultdict(list)
    delay_by_seller_ax: dict[str, list[int]] = defaultdict(list)
    revenue: dict[tuple[int, str], float] = defaultdict(float)
    for order in orders:
        item = item_by_order[order["pedido_id"]]
        year = date.fromisoformat(order["data_pedido"]).year
        family = "AX" if item["produto_id"].startswith("AX") else "BZ"
        qty = float(item["quantidade"])
        demand[(year, family)] += qty
        revenue[(year, family)] += qty * float(item["preco_venda"])
        late = int(order["data_entrega"] > order["data_prometida_original"])
        delay_by_seller[order["vendedor_id"]].append(late)
        if family == "AX":
            delay_by_seller_ax[order["vendedor_id"]].append(late)

    ax_growth = ratio(demand[(2026, "AX")], demand[(2025, "AX")]) - 1
    require(0.10 < ax_growth < 0.30, f"demanda AX cresce de forma plausível ({ax_growth:.1%})")

    product_by_production_order = {row["ordem_producao_id"]: row["produto_id"] for row in production_orders}
    planned = 0.0
    for row in production_orders:
        if row["data_planejada"].startswith("2026") and row["produto_id"].startswith("AX"):
            planned += float(row["quantidade_planejada"])
    ax_produced = sum(
        float(row["quantidade_aprovada"])
        for row in logs
        if row["data_producao"].startswith("2026")
        and product_by_production_order[row["ordem_producao_id"]].startswith("AX")
    )
    require(ax_produced < planned, "produção boa AX fica abaixo do plano de 2026")

    quality: dict[str, list[float]] = defaultdict(list)
    machine_quality: dict[str, list[float]] = defaultdict(list)
    for row in inspections:
        if row["data_inspecao"] < "2026-08-01":
            continue
        lot = lot_by_id[row["lote_material_id"]]
        rate = ratio(float(row["quantidade_reprovada"]), float(row["quantidade_inspecionada"]))
        quality[lot["fornecedor_id"]].append(rate)
        machine_quality[row["maquina_id"]].append(rate)
    require(statistics.mean(quality["FOR-052"]) > statistics.mean(quality["FOR-018"]), "FOR-052 possui associação média com mais refugo")
    require(statistics.mean(machine_quality["MAQ-012"]) > statistics.mean(machine_quality["MAQ-021"]), "MAQ-012 também participa da concentração de refugo")

    vibration_pre = [float(r["valor"]) for r in sensors if r["variavel"] == "vibracao" and "2026-09-01" <= r["data"] < "2026-10-17"]
    vibration_base = [float(r["valor"]) for r in sensors if r["variavel"] == "vibracao" and "2025-01-01" <= r["data"] < "2026-01-01"]
    vibration_post = [float(r["valor"]) for r in sensors if r["variavel"] == "vibracao" and "2026-10-19" <= r["data"] < "2026-12-01"]
    require(statistics.mean(vibration_pre) > statistics.mean(vibration_base) + 1.0, "vibração sobe antes da falha de outubro")
    require(statistics.mean(vibration_post) < statistics.mean(vibration_pre), "vibração recua após a intervenção")

    total_value_aug = sum(float(r["valor_estoque"]) for r in stock if r["mes"] == "2026-08")
    total_value_nov = sum(float(r["valor_estoque"]) for r in stock if r["mes"] == "2026-11")
    ax_available_aug = sum(float(r["disponivel"]) for r in stock if r["mes"] == "2026-08" and r["produto_id"].startswith("AX"))
    ax_available_nov = sum(float(r["disponivel"]) for r in stock if r["mes"] == "2026-11" and r["produto_id"].startswith("AX"))
    require(total_value_nov > total_value_aug * 0.65, "valor total de estoque permanece elevado")
    require(ax_available_nov < ax_available_aug, "disponibilidade AX cai apesar do estoque total")

    cost_by_year: dict[int, list[float]] = defaultdict(list)
    for row in costs:
        if row["produto_id"].startswith("AX"):
            cost_by_year[int(row["mes"][:4])].append(float(row["custo_total"]))
    require(statistics.mean(cost_by_year[2026]) > statistics.mean(cost_by_year[2025]), "custo unitário AX aumenta em 2026")
    require(revenue[(2026, "AX")] > revenue[(2025, "AX")], "faturamento AX cresce")

    cost_by_product_month = {(row["produto_id"], row["mes"]): float(row["custo_total"]) for row in costs}
    margin: dict[int, list[float]] = defaultdict(list)
    for order in orders:
        item = item_by_order[order["pedido_id"]]
        product = item["produto_id"]
        if not product.startswith("AX"):
            continue
        month = order["data_pedido"][:7]
        selling_price = float(item["preco_venda"])
        margin[date.fromisoformat(order["data_pedido"]).year].append(
            ratio(selling_price - cost_by_product_month[(product, month)], selling_price)
        )
    require(statistics.mean(margin[2026]) < statistics.mean(margin[2025]), "margem percentual AX recua mesmo com maior faturamento")

    raw_027 = statistics.mean(delay_by_seller["VEN-027"])
    ax_027 = statistics.mean(delay_by_seller_ax["VEN-027"])
    other_ax = [v for seller, values in delay_by_seller_ax.items() if seller != "VEN-027" for v in values]
    require(raw_027 >= statistics.mean([v for seller, values in delay_by_seller.items() if seller != "VEN-027" for v in values]), "VEN-027 parece pior na taxa bruta")
    require(abs(ax_027 - statistics.mean(other_ax)) < 0.20, "efeito de VEN-027 diminui ao controlar a família AX")

    require(all("causa" not in key.lower() for row in inspections for key in row), "nenhuma tabela de qualidade contém coluna de causa raiz")
    print("\nAtlas 1.0: todas as relações narrativas essenciais foram validadas.")


if __name__ == "__main__":
    main()
