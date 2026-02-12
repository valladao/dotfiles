#!/usr/bin/env bash
set -euo pipefail
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:${PATH:-}"

REAL_HOME="${HOME:-}"
if [ -z "$REAL_HOME" ] || [ ! -d "$REAL_HOME" ]; then
  REAL_HOME="$(getent passwd "$(id -u)" | cut -d: -f6)"
fi
WALL_DIR="${WALL_DIR:-$REAL_HOME/.config/backgrounds}"
WALL_DIR="$(readlink -f "$WALL_DIR" 2>/dev/null || printf '%s' "$WALL_DIR")"

mapfile -d '' WALLS < <(find -L "$WALL_DIR" -maxdepth 1 -type f -print0 2>/dev/null)
if [ "${#WALLS[@]}" -eq 0 ]; then
  exit 0
fi
WALLPAPER="${WALLS[RANDOM % ${#WALLS[@]}]}"

# Ensure hyprpaper is running.
if ! pgrep -x hyprpaper >/dev/null 2>&1; then
  hyprpaper >/dev/null 2>&1 &
  sleep 0.4
fi

"$REAL_HOME/.config/hypr/scripts/set-wallpaper.sh" "$WALLPAPER"
