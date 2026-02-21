#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
SUGGESTED_PLASMA_NIX="/tmp/plasma-live.nix"

echo "KDE Hybrid Sync"
echo "==============="
echo "Repo: $REPO_ROOT"
echo ""

echo "1) Preview snapshot changes"
bash "$SCRIPT_DIR/backup-kde.sh" --dry-run
echo ""

echo "2) Capture live KDE snapshot"
bash "$SCRIPT_DIR/backup-kde.sh"
echo ""

echo "3) KDE snapshot diff"
git -C "$REPO_ROOT" diff --stat -- dotfiles/kde || true
echo ""

echo "4) Generate declarative suggestions"
echo "   Writing: $SUGGESTED_PLASMA_NIX"
nix run github:nix-community/plasma-manager >"$SUGGESTED_PLASMA_NIX"
echo ""

echo "Done."
echo "Next steps:"
echo "- Review snapshot: git diff -- dotfiles/kde"
echo "- Review suggestions: less $SUGGESTED_PLASMA_NIX"
echo "- Promote stable settings into modules/home-manager/plasma.nix"
echo "- Validate: nix build .#homeConfigurations.tctinh.activationPackage"
echo "- Apply: sudo nixos-rebuild switch --flake .#nixos"
