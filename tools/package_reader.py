"""Produção editorial: pacote sem programas externos exigidos ao leitor."""
import hashlib
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]
manifest = json.loads((ROOT / "manifest.json").read_text(encoding="utf-8"))
output = ROOT / "dist/atlas-leitor-v1.0.2.zip"
output.parent.mkdir(exist_ok=True)
with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED) as archive:
    for name, spec in manifest["files"].items():
        raw = (ROOT / "data" / name).read_bytes()
        # O manifesto original usa CRLF; produz os mesmos bytes em qualquer SO.
        canonical = raw.replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")
        if hashlib.sha256(canonical).hexdigest() != spec["sha256"]:
            raise ValueError(f"CSV divergente do manifesto: {name}")
        archive.writestr("data/" + name, canonical)
    for name in ("README.md", "LICENSE", "manifest.json", "sql/validacoes.sql"):
        archive.write(ROOT / name, name)
print(output)
