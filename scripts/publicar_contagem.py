#!/usr/bin/env python3
"""Publica arquivos de uma contagem na pasta do GitHub Pages."""

from __future__ import annotations

import argparse
import json
import re
import shutil
from datetime import date
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BASE_DIR = ROOT / "downloads" / "contagens"
MANIFEST = BASE_DIR / "manifest.json"


def slugify(value: str) -> str:
    value = value.lower().strip()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    return value.strip("-") or "contagem"


def load_manifest() -> dict:
    if not MANIFEST.exists():
        return {"atualizadoEm": "", "contagens": []}
    with MANIFEST.open("r", encoding="utf-8") as fh:
        return json.load(fh)


def copy_file(source: str | None, dest_dir: Path, prefix: str) -> str | None:
    if not source:
        return None
    src = Path(source).expanduser().resolve()
    if not src.exists():
        raise FileNotFoundError(src)
    dest = dest_dir / f"{prefix}{src.suffix.lower()}"
    shutil.copy2(src, dest)
    return dest.relative_to(ROOT / "downloads").as_posix()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Copia Excel/ZIP/PDF para downloads/contagens e atualiza o manifest."
    )
    parser.add_argument("--titulo", required=True, help="Titulo exibido na pagina.")
    parser.add_argument("--operador", required=True, help="Nome do operador.")
    parser.add_argument("--matricula", default="", help="Matricula do operador.")
    parser.add_argument("--data", required=True, help="Data da contagem no formato AAAA-MM-DD.")
    parser.add_argument("--turno", default="", help="Turno ou periodo da contagem.")
    parser.add_argument("--observacao", default="", help="Observacao exibida no card.")
    parser.add_argument("--total-materiais", type=int, default=0)
    parser.add_argument("--alertas", type=int, default=0)
    parser.add_argument("--bloqueios", type=int, default=0)
    parser.add_argument("--excel", help="Caminho do arquivo .xlsx exportado pelo app.")
    parser.add_argument("--zip", dest="zip_file", help="Caminho do pacote .zip exportado pelo app.")
    parser.add_argument("--pdf", help="Caminho do relatorio .pdf exportado pelo app.")
    args = parser.parse_args()

    if not any([args.excel, args.zip_file, args.pdf]):
        raise SystemExit("Informe ao menos um arquivo: --excel, --zip ou --pdf.")

    folder_name = f"{args.data}_{slugify(args.operador)}"
    dest_dir = BASE_DIR / folder_name
    dest_dir.mkdir(parents=True, exist_ok=True)

    arquivos = {
        "excel": copy_file(args.excel, dest_dir, "contagem"),
        "zip": copy_file(args.zip_file, dest_dir, "auditoria"),
        "pdf": copy_file(args.pdf, dest_dir, "relatorio"),
    }
    arquivos = {key: value for key, value in arquivos.items() if value}

    item = {
        "titulo": args.titulo,
        "operador": args.operador,
        "matricula": args.matricula,
        "data": args.data,
        "turno": args.turno,
        "totalMateriais": args.total_materiais,
        "alertas": args.alertas,
        "bloqueios": args.bloqueios,
        "arquivos": arquivos,
        "observacao": args.observacao,
    }

    manifest = load_manifest()
    contagens = manifest.get("contagens")
    if not isinstance(contagens, list):
        contagens = []

    contagens = [
        existing
        for existing in contagens
        if not (
            existing.get("data") == args.data
            and existing.get("operador", "").lower() == args.operador.lower()
        )
    ]
    contagens.insert(0, item)

    manifest["atualizadoEm"] = date.today().isoformat()
    manifest["contagens"] = contagens

    with MANIFEST.open("w", encoding="utf-8") as fh:
        json.dump(manifest, fh, ensure_ascii=False, indent=2)
        fh.write("\n")

    print(f"Contagem publicada em: {dest_dir.relative_to(ROOT)}")
    print(f"Manifest atualizado: {MANIFEST.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
