#!/bin/bash
# Create 3-pane layout: 1 left, 2 right (top/bottom)
# All panes use the current working directory
# Usage: layout-1left-2right.sh [window_name]

# Get current working directory
CWD=$(pwd)

# Rename window if name provided
if [ -n "$1" ]; then
    tmux rename-window "$1"
fi

# Split horizontally (create right pane)
tmux split-window -h -c "$CWD"

# Split the right pane vertically (top/bottom)
tmux split-window -v -c "$CWD"

# Move focus back to left pane
tmux select-pane -L
