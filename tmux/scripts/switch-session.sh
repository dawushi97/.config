#!/usr/bin/env bash
set -euo pipefail

# Switch to next/previous session by session_name order (numeric prefix)
# Usage: switch-session.sh [next|prev]

direction="${1:-next}"
current_session=$(tmux display-message -p '#{session_id}')

# Get all session IDs sorted by session_name numeric prefix (e.g., "1-Home", "2-Work")
# This ensures switch order matches status bar display order
sessions=($(tmux list-sessions -F '#{session_name}::#{session_id}' | sort -t'-' -k1 -n | cut -d':' -f3))

# Find current index
current_idx=-1
for i in "${!sessions[@]}"; do
  if [[ "${sessions[$i]}" == "$current_session" ]]; then
    current_idx=$i
    break
  fi
done

if [[ $current_idx -eq -1 ]]; then
  exit 1
fi

# Calculate target index
total=${#sessions[@]}
if [[ "$direction" == "next" ]]; then
  target_idx=$(( (current_idx + 1) % total ))
else
  target_idx=$(( (current_idx - 1 + total) % total ))
fi

# Switch to target session
tmux switch-client -t "${sessions[$target_idx]}"
