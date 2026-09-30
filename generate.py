from __future__ import annotations

import argparse
import csv
import hashlib
import json
import math
import random
from calendar import monthrange
from datetime import date, timedelta
from pathlib import Path

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data"
OFFICIAL_SEED = 20260930

PRODUCTS = {
    "AX-100": {"family": "AX", "minutes": 3.2, "price": 890.0, "line": "L04"},
    "AX-110": {"family": "AX", "minutes": 3.8, "price": 1040.0, "line": "L04"},
    "AX-120": {"family": "AX", "minutes": 5.4, "price": 1390.0, "line": "L03"},
    "AX-130": {"family": "AX", "minutes": 4.6, "price": 1210.0, "line": "L03"},
    "BZ-200": {"family": "BZ", "minutes": 2.9, "price": 730.0, "line": "L04"},
    "CMP-047": {"family": "COMP", "minutes": 0.0, "price": 42.0, "line": ""},
}


def months(start: date, end: date):
    current = date(start.year, start.month, 1)
    while current <= end:
        yield current
        current = date(current.year + (current.month == 12), 1 if current.month == 12 else current.month + 1, 1)


def daterange(start: date, end: date, step: int = 1):
    current = start
    while current <= end:
        yield current
        current += timedelta(days=step)


def write(name: str, rows: list[dict]):
    DATA.mkdir(parents=True, exist_ok=True)
    path = DATA / name
    fields = list(rows[0]) if rows else []
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)
    print(f"{name}: {len(rows)}")


def clamp(value: float, low: float, high: float) -> float:
    return max(low, min(high, value))


def main(seed: int):
    rng = random.Random(seed)
    start, end = date(2025, 1, 1), date(2026, 12, 31)

    products = [
        {"produto_id": code, "descricao": f"Produto fictício {code}", "familia_id": meta["family"],
         "tipo_produto": "componente" if code.startswith("CMP") else "acabado",
         "unidade_medida": "PC", "tempo_padrao_minuto": meta["minutes"], "preco_referencia": meta["price"]}
        for code, meta in PRODUCTS.items()
    ]
    suppliers = [
        {"fornecedor_id": "FOR-018", "nome": "Vedatec Industrial", "qualificado_em": "2020-03-01"},
        {"fornecedor_id": "FOR-052", "nome": "Noroeste Componentes", "qualificado_em": "2026-05-15"},
    ]

    lots: list[dict] = []
    risky_lots: set[str] = set()
    lot_by_month: dict[str, list[str]] = {}
    lot_counter = 1
    for month in months(start, end):
        key = month.strftime("%Y-%m")
        lot_by_month[key] = []
        count = 2 if month < date(2026, 6, 1) else 4
        for idx in range(count):
            if month < date(2026, 6, 1):
                supplier = "FOR-018"
            else:
                share_new = min(0.35 + max(0, month.month - 6) * 0.045, 0.70)
                supplier = "FOR-052" if (idx / count) < share_new else "FOR-018"
            lot_id = f"LOT-{lot_counter:04d}"
            risky = supplier == "FOR-052" and month >= date(2026, 8, 1) and rng.random() < 0.46
            if risky:
                risky_lots.add(lot_id)
            lots.append({"lote_material_id": lot_id, "componente_id": "CMP-047", "fornecedor_id": supplier,
                         "data_recebimento": (month + timedelta(days=5 + idx * 5)).isoformat(),
                         "quantidade_recebida": 2500 + rng.randint(-250, 350),
                         "preco_unitario": round(39.2 if supplier == "FOR-052" else 42.0, 2)})
            lot_by_month[key].append(lot_id)
            lot_counter += 1

    lots_by_id = {row["lote_material_id"]: row for row in lots}
    orders: list[dict] = []
    items: list[dict] = []
    production_orders: list[dict] = []
    production_logs: list[dict] = []
    consumption: list[dict] = []
    inspections: list[dict] = []
    costs: list[dict] = []
    order_id = prod_id = 1

    for month in months(start, end):
        campaign = date(2026, 7, 1) <= month <= date(2026, 9, 1)
        month_key = month.strftime("%Y-%m")
        for code, meta in PRODUCTS.items():
            if meta["family"] == "COMP":
                continue
            base = 150 if meta["family"] == "AX" else 120
            seasonal = 1 + 0.08 * math.sin(month.month / 12 * math.tau)
            growth = 1.10 if month.year == 2026 and meta["family"] == "AX" else 1.0
            if campaign and meta["family"] == "AX":
                growth = {"AX-100": 1.32, "AX-110": 1.35, "AX-120": 1.42, "AX-130": 1.37}[code]
            elif month > date(2026, 9, 1) and meta["family"] == "AX":
                growth = 1.20
            demand = int(base * seasonal * growth + rng.randint(-10, 12))
            splits = 4
            for week in range(splits):
                qty = max(10, demand // splits + rng.randint(-5, 5))
                requested = month + timedelta(days=week * 7 + 2)
                promised = requested + timedelta(days=18)
                seller = "VEN-027" if code in {"AX-120", "AX-130"} and rng.random() < 0.62 else f"VEN-{rng.randint(1,12):03d}"
                current_order = f"PED-{order_id:06d}"
                discount = rng.uniform(0.015, 0.05)
                if campaign and meta["family"] == "AX":
                    discount += {"AX-100": 0.06, "AX-110": 0.075, "AX-120": 0.10, "AX-130": 0.085}[code]
                orders.append({"pedido_id": current_order, "cliente_id": f"CLI-{rng.randint(1,80):04d}",
                               "vendedor_id": seller, "data_pedido": requested.isoformat(),
                               "data_prometida_original": promised.isoformat(), "data_prometida_atual": promised.isoformat(),
                               "status": "atendido", "campanha_id": "CMP-COM-2026-07-AX" if campaign and meta["family"] == "AX" else ""})
                items.append({"pedido_id": current_order, "item_id": 1, "produto_id": code, "quantidade": qty,
                              "preco_lista": meta["price"], "desconto_percentual": round(discount, 4),
                              "preco_venda": round(meta["price"] * (1 - discount), 2)})

                line = meta["line"]
                machine = "MAQ-012" if line == "L03" else "MAQ-021"
                current_prod = f"OP-{prod_id:06d}"
                pressure = month >= date(2026, 7, 1) and meta["family"] == "AX"
                planned = qty
                stop_loss = rng.uniform(0.01, 0.04) + (0.045 if pressure and line == "L03" else 0)
                speed_loss = rng.uniform(0.005, 0.025) + (0.025 if pressure else 0)
                selected_lot = rng.choice(lot_by_month[month_key])
                lot = lots_by_id[selected_lot]
                scrap_rate = rng.uniform(0.008, 0.018)
                if selected_lot in risky_lots:
                    scrap_rate += 0.035
                if pressure and machine == "MAQ-012" and month <= date(2026, 10, 1):
                    scrap_rate += 0.018
                produced = max(0, round(planned * (1 - stop_loss - speed_loss)))
                scrap = max(0, round(produced * scrap_rate))
                approved = produced - scrap
                delivery_delay = 0
                if meta["family"] == "AX" and month >= date(2026, 8, 1):
                    delivery_delay = max(0, round((planned - approved) / max(planned, 1) * 35 + rng.uniform(-1, 3)))
                delivery = promised + timedelta(days=delivery_delay)
                orders[-1]["data_entrega"] = delivery.isoformat()
                orders[-1]["status"] = "atrasado" if delivery > promised else "atendido"

                production_orders.append({"ordem_producao_id": current_prod, "produto_id": code, "linha_id": line,
                                          "data_planejada": requested.isoformat(), "quantidade_planejada": planned,
                                          "status": "concluida"})
                production_logs.append({"apontamento_id": f"APT-{prod_id:06d}", "ordem_producao_id": current_prod,
                                        "data_producao": (requested + timedelta(days=10)).isoformat(), "linha_id": line,
                                        "maquina_id": machine, "turno_id": "T3" if code == "AX-120" and rng.random() < 0.62 else rng.choice(["T1", "T2", "T3"]),
                                        "quantidade_produzida": produced, "quantidade_aprovada": approved,
                                        "quantidade_refugada": scrap, "minutos_operacao": round(produced * meta["minutes"], 1),
                                        "minutos_parada": round(planned * meta["minutes"] * stop_loss, 1)})
                consumption.append({"ordem_producao_id": current_prod, "componente_id": "CMP-047",
                                    "lote_material_id": selected_lot, "quantidade_consumida": produced})
                inspections.append({"inspecao_id": f"INSP-{prod_id:06d}", "ordem_producao_id": current_prod,
                                    "produto_id": code, "maquina_id": machine, "lote_material_id": selected_lot,
                                    "data_inspecao": (requested + timedelta(days=10)).isoformat(),
                                    "tipo_defeito": "falha_vedacao" if scrap else "sem_defeito",
                                    "quantidade_inspecionada": produced, "quantidade_aprovada": approved,
                                    "quantidade_reprovada": scrap})
                order_id += 1
                prod_id += 1

            material_cost = meta["price"] * (0.46 if meta["family"] == "AX" else 0.42)
            pressure_cost = 1.0 + (0.07 if month >= date(2026, 8, 1) and meta["family"] == "AX" else 0)
            costs.append({"produto_id": code, "mes": month_key, "custo_material": round(material_cost * pressure_cost, 2),
                          "custo_producao": round(meta["price"] * 0.20 * pressure_cost, 2),
                          "custo_embalagem": round(meta["price"] * 0.035, 2),
                          "custo_total": round(meta["price"] * (0.695 * pressure_cost), 2)})

    stock: list[dict] = []
    for month in months(start, end):
        month_key = month.strftime("%Y-%m")
        for code, meta in PRODUCTS.items():
            if code == "CMP-047":
                qty = 5200 if month < date(2026, 8, 1) else max(600, 3200 - (month.month - 8) * 450)
                blocked = 0 if month < date(2026, 8, 1) else 350 + rng.randint(0, 220)
            elif meta["family"] == "AX":
                qty = 520 if month < date(2026, 8, 1) else max(45, 380 - (month.month - 8) * 65)
                blocked = rng.randint(0, 18)
            else:
                qty, blocked = 2100 + rng.randint(-120, 150), 0
            reserved = round(qty * (0.12 if meta["family"] == "AX" else 0.03))
            stock.append({"mes": month_key, "produto_id": code, "local_id": "FAB-MG", "saldo_fisico": qty,
                          "reservado": reserved, "bloqueado": blocked, "disponivel": max(0, qty - reserved - blocked),
                          "valor_estoque": round(qty * (meta["price"] * 0.70 if meta["family"] != "COMP" else 40.0), 2)})

    sensor_rows: list[dict] = []
    deterioration_start = date(2026, 7, 1)
    correction = date(2026, 10, 18)
    for day in daterange(start, end):
        if day.weekday() >= 5:
            continue
        age = max(0, (day - deterioration_start).days)
        deterioration = min(age / 105, 1.0) if deterioration_start <= day < correction else 0.18 if day >= correction else 0
        vibration = 2.1 + deterioration * 2.8 + rng.gauss(0, 0.28)
        temperature = 58 + deterioration * 9.5 + rng.gauss(0, 1.4)
        micro = max(0, round(1.5 + deterioration * 8 + rng.gauss(0, 1.5)))
        for variable, value, unit in [("vibracao", vibration, "mm/s"), ("temperatura", temperature, "C"), ("microparadas", micro, "qtd")]:
            sensor_rows.append({"data": day.isoformat(), "maquina_id": "MAQ-012", "variavel": variable,
                                "valor": round(value, 3), "unidade": unit})

    failures = [
        {"falha_id": "FAL-001", "maquina_id": "MAQ-012", "inicio_falha": "2025-05-12T09:20:00", "fim_falha": "2025-05-12T13:40:00"},
        {"falha_id": "FAL-002", "maquina_id": "MAQ-012", "inicio_falha": "2026-08-26T15:10:00", "fim_falha": "2026-08-26T18:05:00"},
        {"falha_id": "FAL-003", "maquina_id": "MAQ-012", "inicio_falha": "2026-10-17T06:35:00", "fim_falha": "2026-10-18T15:20:00"},
    ]
    maintenance = [
        {"ordem_manutencao_id": "OM-001", "maquina_id": "MAQ-012", "tipo": "preventiva", "data_planejada": "2026-02-15", "inicio_real": "2026-03-03", "fim_real": "2026-03-03", "status": "adiada"},
        {"ordem_manutencao_id": "OM-002", "maquina_id": "MAQ-012", "tipo": "preventiva", "data_planejada": "2026-04-08", "inicio_real": "2026-04-27", "fim_real": "2026-04-27", "status": "adiada"},
        {"ordem_manutencao_id": "OM-003", "maquina_id": "MAQ-012", "tipo": "corretiva", "data_planejada": "2026-10-17", "inicio_real": "2026-10-17", "fim_real": "2026-10-18", "status": "concluida"},
    ]

    for filename, rows in [
        ("produtos.csv", products), ("fornecedores.csv", suppliers), ("pedidos.csv", orders),
        ("itens_pedido.csv", items), ("ordens_producao.csv", production_orders),
        ("apontamentos_producao.csv", production_logs), ("lotes_material.csv", lots),
        ("consumo_material.csv", consumption), ("inspecoes_qualidade.csv", inspections),
        ("estoque_mensal.csv", stock), ("leituras_sensores_diarias.csv", sensor_rows),
        ("falhas_maquina.csv", failures), ("ordens_manutencao.csv", maintenance), ("custos_produto.csv", costs),
    ]:
        write(filename, rows)

    files = {}
    for path in sorted(DATA.glob("*.csv")):
        with path.open(encoding="utf-8", newline="") as handle:
            row_count = sum(1 for _ in csv.DictReader(handle))
        files[path.name] = {
            "rows": row_count,
            "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
        }
    manifest = {"dataset": "Atlas", "version": "1.0", "seed": seed, "files": files}
    (ROOT / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print("manifest.json: atualizado")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--seed", type=int, default=OFFICIAL_SEED)
    args = parser.parse_args()
    main(args.seed)
