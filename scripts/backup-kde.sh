#!/usr/bin/env bash
set -euo pipefail

# backup-kde.sh - Safe, curated KDE Plasma configuration backup script
#
# Purpose: Copy selected KDE config files from ~/.config to repo's dotfiles/kde
# Safety: Explicit allowlist only, rejects secret-prone files, never modifies source
# Role: Snapshot/reference only - does NOT conflict with plasma-manager

# === Configuration ===

# Curated allowlist - full snapshot scope
ALLOWLIST=(
	# Core desktop
	"kdeglobals"
	"kglobalshortcutsrc"
	"kwinrc"
	"plasmashellrc"
	"plasma-org.kde.plasma.desktop-appletsrc"
	"plasmarc"
	# Machine/system specific
	"kwinoutputconfig.json"
	"kcminputrc"
	"plasmanotifyrc"
	# App rc files
	"konsolerc"
	"dolphinrc"
	"krunnerrc"
	"katerc"
)

# Secret-prone patterns to reject (safety guard)
SECRET_PATTERNS=(
	"kwallet*"
	"*.key"
	"*.pem"
	"*.gpg"
	"*password*"
	"*credentials*"
	"*token*"
	"*.secret"
)

# === Defaults ===
DRY_RUN=false
SOURCE_DIR="${HOME}/.config"
TARGET_DIR="" # Will be computed from script location

# === Functions ===

show_help() {
	cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Safe KDE Plasma configuration backup script.
Copies curated allowlisted files from source to target directory.

OPTIONS:
  --dry-run           Print actions without copying files
  --source <dir>      Source directory (default: \$HOME/.config)
  --target <dir>      Target directory (default: repo dotfiles/kde)
  -h, --help          Show this help message

EXAMPLES:
  $(basename "$0") --dry-run
  $(basename "$0") --source "\$HOME/.config" --target "/tmp/kde-backup-test"

SAFETY:
  - Only copies explicitly allowlisted files
  - Rejects secret-prone files (kwallet*, *.key, *password*, etc.)
  - Never modifies source directory
  - Never deletes files from target directory
  - Skips missing files with warnings

EOF
}

is_secret_prone() {
	local filename="$1"
	local basename_only
	basename_only=$(basename "$filename")

	for pattern in "${SECRET_PATTERNS[@]}"; do
		# Use bash pattern matching
		if [[ "$basename_only" == $pattern ]]; then
			return 0 # Is secret-prone
		fi
	done
	return 1 # Not secret-prone
}

resolve_target_dir() {
	# Resolve deterministically from script location: scripts/../dotfiles/kde
	local script_dir
	script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
	local repo_root
	repo_root=$(cd "$script_dir/.." && pwd)
	echo "$repo_root/dotfiles/kde"
}

# === Parse Arguments ===

while [[ $# -gt 0 ]]; do
	case "$1" in
	--dry-run)
		DRY_RUN=true
		shift
		;;
	--source)
		SOURCE_DIR="$2"
		shift 2
		;;
	--target)
		TARGET_DIR="$2"
		shift 2
		;;
	-h | --help)
		show_help
		exit 0
		;;
	*)
		echo "Error: Unknown option: $1" >&2
		echo "Use --help for usage information" >&2
		exit 1
		;;
	esac
done

# === Main Logic ===

# Set target directory if not provided
if [[ -z "$TARGET_DIR" ]]; then
	TARGET_DIR=$(resolve_target_dir)
fi

# Verify source exists
if [[ ! -d "$SOURCE_DIR" ]]; then
	echo "Error: Source directory does not exist: $SOURCE_DIR" >&2
	exit 1
fi

# Ensure target directory exists (unless dry-run)
if [[ "$DRY_RUN" == false ]]; then
	if [[ ! -d "$TARGET_DIR" ]]; then
		mkdir -p "$TARGET_DIR"
	fi
fi

echo "KDE Plasma Backup Script"
echo "========================"
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"
echo "Mode: $([ "$DRY_RUN" == true ] && echo "DRY-RUN" || echo "LIVE")"
echo ""

# Process allowlisted files
files_copied=0
files_skipped=0
files_rejected=0

for file in "${ALLOWLIST[@]}"; do
	source_path="$SOURCE_DIR/$file"
	target_path="$TARGET_DIR/$file"

	# Safety guard: reject secret-prone files
	if is_secret_prone "$file"; then
		echo "[REJECT] $file (matches secret-prone pattern)"
		files_rejected=$((files_rejected + 1))
		continue
	fi

	# Check if source file exists
	if [[ ! -f "$source_path" ]]; then
		echo "[SKIP] $file (not found in source)"
		files_skipped=$((files_skipped + 1))
		continue
	fi

	# Copy file
	if [[ "$DRY_RUN" == true ]]; then
		echo "[COPY] $file"
		files_copied=$((files_copied + 1))
	else
		cp "$source_path" "$target_path"
		echo "[COPY] $file"
		files_copied=$((files_copied + 1))
	fi
done

echo ""
echo "Summary:"
echo "--------"
echo "Copied: $files_copied"
echo "Skipped: $files_skipped"
echo "Rejected: $files_rejected"

if [[ "$DRY_RUN" == true ]]; then
	echo ""
	echo "(Dry-run mode: no files were actually copied)"
fi

exit 0
