#!/usr/bin/env bash
set -euo pipefail

# ===========================================
# Tmux Left Status - All Sessions (Powerline Arrow Style)
# ===========================================

current_session_id="${1:-}"

# Colors
inactive_bg="#45475a"
inactive_fg="#cdd6f4"
active_bg="#89b4fa"
active_fg="#1e1e2e"
status_bg="default"

# Powerline arrow separator
separator=$'\xee\x82\xb0'

# Trim numeric prefix from session name (e.g., "1-Home" -> "Home")
trim_label() {
  local value="$1"
  if [[ "$value" =~ ^[0-9]+-(.*)$ ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
  else
    printf '%s' "$value"
  fi
}

# Get all sessions (sorted by name, which starts with number prefix)
sessions=$(tmux list-sessions -F '#{session_name}::#{session_id}::#{session_name}' 2>/dev/null | sort -t'-' -k1 -n || true)
if [[ -z "$sessions" ]]; then
  exit 0
fi

rendered=""
prev_bg=""
first=1

while IFS= read -r entry; do
  [[ -z "$entry" ]] && continue
  # Parse: index::session_id::name
  session_id="${entry#*::}"
  session_id="${session_id%%::*}"
  name="${entry##*::}"
  [[ -z "$session_id" ]] && continue

  # Trim numeric prefix for display
  display_name=$(trim_label "$name")

  # Check if this is the current session
  if [[ "$session_id" == "$current_session_id" ]]; then
    segment_bg="$active_bg"
    segment_fg="$active_fg"
  else
    segment_bg="$inactive_bg"
    segment_fg="$inactive_fg"
  fi

  # Truncate long names
  if (( ${#display_name} > 15 )); then
    display_name="${display_name:0:14}…"
  fi

  # Render powerline style (connected arrows)
  if [[ $first -eq 1 ]]; then
    # First segment: no left cap, just start with content
    rendered+="#[fg=${segment_fg},bg=${segment_bg},bold] ${display_name} "
    first=0
  else
    # Arrow from previous segment to current
    rendered+="#[fg=${prev_bg},bg=${segment_bg}]${separator}"
    rendered+="#[fg=${segment_fg},bg=${segment_bg},bold] ${display_name} "
  fi

  prev_bg="$segment_bg"

done <<< "$sessions"

# Final arrow to status background
if [[ -n "$prev_bg" ]]; then
  rendered+="#[fg=${prev_bg},bg=${status_bg}]${separator}#[default]"
fi

printf '%s' "$rendered"
