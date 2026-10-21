"""Produção editorial: pacote sem programas externos exigidos ao leitor."""
import hashlib
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]
manifest = json.loads((ROOT / "manifest.json").read_text(encoding="utf-8"))
VERSION = "v1.0.4"
output = ROOT / f"dist/atlas-leitor-{VERSION}.zip"
output.parent.mkdir(exist_ok=True)


def put(archive, name, data):
    # Metadados fixos tornam o ZIP reproduzível sem depender do SO ou do relógio.
    info = zipfile.ZipInfo(name, date_time=(2026, 10, 21, 0, 0, 0))
    info.compress_type = zipfile.ZIP_DEFLATED
    info.create_system = 3
    info.external_attr = 0o100644 << 16
    archive.writestr(info, data)


with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED) as archive:
    for name, spec in manifest["files"].items():
        raw = (ROOT / "data" / name).read_bytes()
        # O manifesto original usa CRLF; produz os mesmos bytes em qualquer SO.
        canonical = raw.replace(b"\r\n", b"\n").replace(b"\n", b"\r\n")
        if hashlib.sha256(canonical).hexdigest() != spec["sha256"]:
            raise ValueError(f"CSV divergente do manifesto: {name}")
        put(archive, "data/" + name, canonical)
    names = ["README.md", "LICENSE", "manifest.json", "sql/validacoes.sql"]
    names += sorted(p.relative_to(ROOT).as_posix() for p in (ROOT / "sql/capitulos").rglob("*") if p.is_file())
    for name in names:
        raw = (ROOT / name).read_bytes().replace(b"\r\n", b"\n")
        if name == "README.md":
            # As pastas editoriais não integram o pacote; seus links apontam à tag pública.
            raw = raw.replace(b"](databricks/)", f"](https://github.com/regyssilveira/atlas-didatico/tree/{VERSION}/databricks/)".encode())
            raw = raw.replace(b"](docs/databricks/roteiro-execucao-captura.md)", f"](https://github.com/regyssilveira/atlas-didatico/blob/{VERSION}/docs/databricks/roteiro-execucao-captura.md)".encode())
        put(archive, name, raw)
print(output)
