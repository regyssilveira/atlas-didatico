"""Conferência editorial dos SQLs distribuídos; não executa consultas."""
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1] / "sql/capitulos"
manifest = json.loads((ROOT / "manifesto-sql.json").read_text(encoding="utf-8"))
expected = {"README.md", "manifesto-sql.json"}
for chapter in manifest["chapters"]:
    expected.add(f"capitulo-{chapter['chapter']:02d}/README.md")
    assert chapter["files"], "capítulo sem SQL"
for record in manifest["files"]:
    expected.add(record["file"])
    text = (ROOT / record["file"]).read_text(encoding="utf-8")
    body = text.split("-- INÍCIO DO SQL DO LIVRO\n", 1)[1].split("-- FIM DO SQL DO LIVRO", 1)[0].strip()
    assert hashlib.sha256(body.encode()).hexdigest() == record["sha256"], record["file"]
    assert not re.search(r"(?im)^\s*(INSERT|UPDATE|DELETE|DROP|MERGE|TRUNCATE)\b", body), record["file"]
actual = {p.relative_to(ROOT).as_posix() for p in ROOT.rglob("*") if p.is_file()}
assert actual == expected, "arquivos faltantes ou não registrados"
for file in ROOT.rglob("*.md"):
    for target in re.findall(r"\]\(([^)]+)\)", file.read_text(encoding="utf-8")):
        assert (file.parent / target).is_file(), target
print(f"SQL do leitor: {len(manifest['files'])} arquivos, 13 capítulos, hashes e links íntegros; sem execução Databricks.")
