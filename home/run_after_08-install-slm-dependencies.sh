#!/bin/bash

set -euo pipefail

echo ">> Checking SuperLocalMemory Python dependencies..."

resolve_python() {
  if command -v mise >/dev/null 2>&1; then
    pushd "$HOME" >/dev/null
    mise install python
    if python_bin="$(mise which python3 2>/dev/null)"; then
      popd >/dev/null
      printf '%s\n' "$python_bin"
      return 0
    fi
    if python_bin="$(mise which python 2>/dev/null)"; then
      popd >/dev/null
      printf '%s\n' "$python_bin"
      return 0
    fi
    popd >/dev/null
  fi

  command -v python3
}

python_bin="$(resolve_python)"

slm_deps=(
  "httpx==0.28.1"
  "numpy==2.4.4"
  "scipy==1.17.1"
  "networkx==3.6.1"
  "mcp==1.27.1"
  "python-dateutil==2.9.0.post0"
  "rank-bm25==0.2.2"
  "vadersentiment==3.3.2"
  "einops==0.8.2"
  "fastapi[all]==0.136.1"
  "uvicorn==0.46.0"
  "websockets==16.0"
  "lightgbm==4.6.0"
  "orjson==3.11.9"
  "tree-sitter==0.25.2"
  "tree-sitter-language-pack==0.13.0"
  "rustworkx==0.17.1"
  "watchdog==5.0.3"
  "psutil==7.2.2"
  "structlog==25.5.0"
  "portalocker==3.2.0"
  "sentence-transformers==5.3.0"
  "optimum==2.1.0"
  "onnxruntime==1.24.4"
  "transformers==4.57.6"
  "huggingface_hub==0.36.2"
  "torch==2.11.0"
  "scikit-learn==1.8.0"
  "sqlite-vec==0.1.9"
  "keyring>=25.0.0"
  "google-auth-oauthlib>=1.2.0"
  "google-api-python-client>=2.100.0"
  "icalendar>=6.0.0"
  "certifi"
  "packaging"
)

deps_satisfied() {
  "$python_bin" - "${slm_deps[@]}" <<'PY'
import sys
from importlib import metadata

try:
    from packaging.requirements import Requirement
    from packaging.version import Version
except Exception:
    sys.exit(1)

problems = []
for req_text in sys.argv[1:]:
    req = Requirement(req_text)
    try:
        installed = metadata.version(req.name)
    except metadata.PackageNotFoundError:
        problems.append(f"missing {req.name}{req.specifier}")
        continue

    if req.specifier and Version(installed) not in req.specifier:
        problems.append(f"{req.name}=={installed} does not satisfy {req.specifier}")

if problems:
    print("SuperLocalMemory dependency drift detected:")
    for problem in problems:
        print(f"  - {problem}")
    sys.exit(1)
PY
}

if deps_satisfied; then
  echo "SuperLocalMemory Python dependencies are already installed for $python_bin."
  exit 0
fi

echo ">> Installing SuperLocalMemory Python dependencies for $python_bin..."
"$python_bin" -m ensurepip --upgrade >/dev/null 2>&1 || true
"$python_bin" -m pip install --user --upgrade pip
"$python_bin" -m pip install \
  --user \
  --upgrade \
  --upgrade-strategy eager \
  --prefer-binary \
  --extra-index-url https://download.pytorch.org/whl/cpu \
  "${slm_deps[@]}"
