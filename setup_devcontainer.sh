#!/usr/bin/env bash
set -euo pipefail

# you can change this
PY_VERSION="3.11"
KERNEL_NAME="codespace-venv"

mkdir -p .devcontainer

cat > .devcontainer/devcontainer.json <<EOF
{
  "name": "inepekddalearningpython",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/devcontainers/features/python:1": {
      "version": "${PY_VERSION}"
    }
  },
  "postCreateCommand": "python -m venv .venv && . .venv/bin/activate && pip install -U pip && if [ -f requirements.txt ]; then pip install -r requirements.txt; fi && python -m ipykernel install --user --name ${KERNEL_NAME}",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-toolsai.jupyter"
      ],
      "settings": {
        "python.defaultInterpreterPath": "\${containerWorkspaceFolder}/.venv/bin/python",
        "jupyter.jupyterServerType": "local"
      }
    }
  }
}
EOF

echo ".venv/" >> .gitignore
git add .devcontainer/devcontainer.json .gitignore
git commit -m "Add devcontainer: auto-create venv and kernel"
echo "✅ Created .devcontainer/devcontainer.json and committed."
