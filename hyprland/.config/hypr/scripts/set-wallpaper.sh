#!/usr/bin/env bash
set -euo pipefail
PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:${PATH:-}"

REAL_HOME="${HOME:-}"
if [ -z "$REAL_HOME" ] || [ ! -d "$REAL_HOME" ]; then
  REAL_HOME="$(getent passwd "$(id -u)" | cut -d: -f6)"
fi

WALL_DIR="${WALL_DIR:-$REAL_HOME/.config/backgrounds}"
WALL_DIR="$(readlink -f "$WALL_DIR" 2>/dev/null || printf '%s' "$WALL_DIR")"
DEFAULT_IMG="${DEFAULT_IMG:-$(find -L "$WALL_DIR" -maxdepth 1 -type f 2>/dev/null | head -n 1)}"
STATE_FILE="${WALL_STATE_FILE:-$REAL_HOME/.cache/hypr/last-wallpaper}"

if [ "${1:-}" != "" ]; then
  IMG="$1"
elif [ -f "$STATE_FILE" ]; then
  IMG="$(head -n 1 "$STATE_FILE")"
else
  IMG="$DEFAULT_IMG"
fi

if [ -z "${IMG:-}" ]; then
  exit 0
fi

HYPRCTL="${HYPRCTL_BIN:-/usr/bin/hyprctl}"
PGREP_BIN="${PGREP_BIN:-/usr/bin/pgrep}"

if [ ! -f "$IMG" ]; then
  echo "Wallpaper not found: $IMG" >&2
  exit 1
fi

if [ ! -x "$HYPRCTL" ]; then
  echo "hyprctl not found at $HYPRCTL" >&2
  exit 1
fi

# Wait a bit for hyprpaper + monitors to be ready.
for _ in $(seq 1 30); do
  "$PGREP_BIN" -x hyprpaper >/dev/null 2>&1 || true
  MONS="$("$HYPRCTL" monitors 2>/dev/null | awk '/^Monitor /{print $2}')"
  if [ -n "$MONS" ]; then
    break
  fi
  sleep 0.2
done

MONS="$("$HYPRCTL" monitors 2>/dev/null | awk '/^Monitor /{print $2}')"
if [ -z "$MONS" ]; then
  exit 0
fi

APPLIED=0
for M in $MONS; do
  if "$HYPRCTL" hyprpaper wallpaper "$M,$IMG" >/dev/null 2>&1; then
    APPLIED=1
  fi
done

# Fallback broadcast to any monitor.
if "$HYPRCTL" hyprpaper wallpaper ",$IMG" >/dev/null 2>&1; then
  APPLIED=1
fi

if [ "$APPLIED" -eq 1 ]; then
  mkdir -p "$(dirname "$STATE_FILE")"
  printf '%s\n' "$IMG" > "$STATE_FILE"
fi
