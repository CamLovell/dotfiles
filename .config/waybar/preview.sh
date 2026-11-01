#!/usr/bin/env bash
# Browse waybar styles/configs: copy into place, refresh, optionally save favorites.

set -euo pipefail

WAYBAR_DIR="${WAYBAR_DIR:-$HOME/.config/waybar}"
STYLES_DIR="$WAYBAR_DIR/style"
CONFIGS_DIR="$WAYBAR_DIR/configs"
STYLE_TARGET="$WAYBAR_DIR/style.css"
CONFIG_TARGET="$WAYBAR_DIR/config.jsonc"
STATE_FILE="$WAYBAR_DIR/.current-theme"
SAVE_FILE="$WAYBAR_DIR/saved-layouts.txt"

current_style=""
current_config=""

load_state() {
  if [[ -f "$STATE_FILE" ]]; then
    # shellcheck disable=SC1090
    source "$STATE_FILE"
  fi
}

save_state() {
  printf 'current_style=%q\ncurrent_config=%q\n' \
    "$current_style" "$current_config" >"$STATE_FILE"
}

list_styles() {
  find -L "$STYLES_DIR" -maxdepth 1 -type f -name '*.css' -printf '%f\n' | sort
}

list_configs() {
  find -L "$CONFIGS_DIR" -maxdepth 1 -type f -printf '%f\n' | sort
}

# Print index of $2 in array name $1, or -1
index_of() {
  local -n _arr=$1
  local needle=$2
  local i
  for i in "${!_arr[@]}"; do
    if [[ "${_arr[i]}" == "$needle" ]]; then
      echo "$i"
      return 0
    fi
  done
  echo -1
}

refresh_waybar() {
  pkill waybar 2>/dev/null || true
  sleep 0.2
  for _ in $(seq 1 20); do
    pgrep -x waybar >/dev/null || break
    sleep 0.1
  done
  waybar >/dev/null 2>&1 &
  disown || true
}

apply_style() {
  local name="$1"
  local src="$STYLES_DIR/$name"
  if [[ ! -f "$src" ]]; then
    echo "Style not found: $name" >&2
    return 1
  fi
  cp -f "$src" "$STYLE_TARGET"
  current_style="$name"
  save_state
  refresh_waybar
  echo "Applied style: $name"
}

apply_config() {
  local name="$1"
  local src="$CONFIGS_DIR/$name"
  if [[ ! -f "$src" ]]; then
    echo "Config not found: $name" >&2
    return 1
  fi
  cp -f "$src" "$CONFIG_TARGET"
  current_config="$name"
  save_state
  refresh_waybar
  echo "Applied config: $name"
}

# Pick an item from a list. Sets REPLY to the chosen name. Returns 1 on cancel.
pick_from_list() {
  local prompt="$1"
  local current="$2"
  shift 2
  local -a items=("$@")
  local count=${#items[@]}
  local i current_idx=-1

  if ((count == 0)); then
    echo "Nothing to choose from." >&2
    return 1
  fi

  echo
  echo "$prompt"
  echo "----------------------------------------"
  for i in "${!items[@]}"; do
    local mark=" "
    if [[ "${items[i]}" == "$current" ]]; then
      mark="*"
      current_idx=$i
    fi
    printf " %s %2d) %s\n" "$mark" "$((i + 1))" "${items[i]}"
  done
  echo "----------------------------------------"
  echo "  number | n=next | p=prev | empty=cancel"

  local choice
  read -r -p "> " choice

  case "$choice" in
    "") return 1 ;;
    n|N|next)
      if ((current_idx < 0)); then
        REPLY="${items[0]}"
      else
        REPLY="${items[$(( (current_idx + 1) % count ))]}"
      fi
      ;;
    p|P|prev)
      if ((current_idx < 0)); then
        REPLY="${items[$((count - 1))]}"
      else
        REPLY="${items[$(( (current_idx - 1 + count) % count ))]}"
      fi
      ;;
    *[!0-9]*)
      echo "Invalid choice." >&2
      return 1
      ;;
    *)
      if ((choice < 1 || choice > count)); then
        echo "Out of range." >&2
        return 1
      fi
      REPLY="${items[$((choice - 1))]}"
      ;;
  esac
}

cycle() {
  # cycle style|config next|prev
  local kind=$1
  local dir=$2
  local -a items
  local current name idx count

  if [[ "$kind" == style ]]; then
    mapfile -t items < <(list_styles)
    current=$current_style
  else
    mapfile -t items < <(list_configs)
    current=$current_config
  fi

  count=${#items[@]}
  if ((count == 0)); then
    echo "No ${kind}s found."
    return 1
  fi

  idx=$(index_of items "$current")
  if [[ "$dir" == next ]]; then
    if ((idx < 0)); then
      name="${items[0]}"
    else
      name="${items[$(( (idx + 1) % count ))]}"
    fi
  else
    if ((idx < 0)); then
      name="${items[$((count - 1))]}"
    else
      name="${items[$(( (idx - 1 + count) % count ))]}"
    fi
  fi

  if [[ "$kind" == style ]]; then
    apply_style "$name"
  else
    apply_config "$name"
  fi
}

save_current() {
  if [[ -z "$current_style" || -z "$current_config" ]]; then
    echo "Need both a style and a config tracked before saving."
    echo "  style:  ${current_style:-"(unset)"}"
    echo "  config: ${current_config:-"(unset)"}"
    return 1
  fi
  # Ignore placeholder strings from first-run detection
  if [[ "$current_style" == "(unknown)" || "$current_config" == "(unknown)" ]]; then
    echo "Pick a style and config first so names are known."
    return 1
  fi
  printf 'style: %s\nconfig: %s\n\n' "$current_style" "$current_config" >>"$SAVE_FILE"
  echo "Appended to $SAVE_FILE"
  echo "  style: $current_style"
  echo "  config: $current_config"
}

show_status() {
  echo
  echo "========================================"
  echo " Waybar theme preview"
  echo "========================================"
  echo " Style:  ${current_style:-"(unset)"}"
  echo " Config: ${current_config:-"(unset)"}"
  echo " Save →  $SAVE_FILE"
  echo "========================================"
}

change_style() {
  mapfile -t styles < <(list_styles)
  if pick_from_list "Choose a style" "$current_style" "${styles[@]}"; then
    apply_style "$REPLY"
  else
    echo "Cancelled."
  fi
}

change_config() {
  mapfile -t configs < <(list_configs)
  if pick_from_list "Choose a config" "$current_config" "${configs[@]}"; then
    apply_config "$REPLY"
  else
    echo "Cancelled."
  fi
}

main_menu() {
  load_state

  if [[ ! -d "$STYLES_DIR" ]]; then
    echo "Missing styles dir: $STYLES_DIR" >&2
    exit 1
  fi
  if [[ ! -d "$CONFIGS_DIR" ]]; then
    echo "Missing configs dir: $CONFIGS_DIR" >&2
    exit 1
  fi

  while true; do
    show_status
    cat <<EOF
 1) Change style
 2) Change config
 3) Next style
 4) Prev style
 5) Next config
 6) Prev config
 7) Save current layout
 8) Quit
EOF
    local opt
    read -r -p "> " opt
    case "$opt" in
      1) change_style ;;
      2) change_config ;;
      3) cycle style next ;;
      4) cycle style prev ;;
      5) cycle config next ;;
      6) cycle config prev ;;
      7) save_current ;;
      8|q|Q) echo "Done."; exit 0 ;;
      *) echo "Unknown option." ;;
    esac
  done
}

case "${1:-}" in
  style)
    load_state
    apply_style "${2:?usage: $0 style <filename.css>}"
    ;;
  config)
    load_state
    apply_config "${2:?usage: $0 config <name>}"
    ;;
  save)
    load_state
    save_current
    ;;
  ""|menu)
    main_menu
    ;;
  -h|--help)
    cat <<EOF
Usage: $(basename "$0") [menu|style <file>|config <name>|save]

Copies from:
  $STYLES_DIR/*.css  →  $STYLE_TARGET
  $CONFIGS_DIR/*     →  $CONFIG_TARGET
then restarts waybar.

Menu options let you change style/config, step next/prev, or append the
current pair of names to:
  $SAVE_FILE
EOF
    ;;
  *)
    echo "Unknown command: $1 (try --help)" >&2
    exit 1
    ;;
esac
