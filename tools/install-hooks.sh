#!/usr/bin/env bash
#
# Instala los hooks de git de NutriPlato (solo enlace simbólico, sin copias).
#
# Uso:
#   ./tools/install-hooks.sh
#
set -euo pipefail
cd "$(dirname "$0")/.."

HOOKS_DIR="tools/git-hooks"
GIT_HOOKS=".git/hooks"

if [ ! -d "$GIT_HOOKS" ]; then
  echo "ERROR: $GIT_HOOKS no existe. ¿Es este un repositorio git?" >&2
  exit 1
fi

installed=0
for hook in "$HOOKS_DIR"/*; do
  [ -f "$hook" ] || continue
  name=$(basename "$hook")
  chmod +x "$hook"
  ln -sf "../../$hook" "$GIT_HOOKS/$name"
  installed=$((installed + 1))
  echo "  Instalado: $name"
done

echo "Listo ($installed hooks activos)."
