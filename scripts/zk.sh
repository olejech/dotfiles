#!/bin/bash
session_name="00-zk"

if ! tmux has-session -t="$session_name" 2>/dev/null; then
  TMUX='' tmux new-session -d -s "$session_name"
fi

tmux switch-client -t "$session_name"

if ! tmux list-panes -t "$session_name" -F "#{pane_current_command}" | grep -q "nvim"; then
  tmux send-keys -t "$session_name" "cd '$ZETTELKASTEN_PATH'; nvim" C-m
fi

tmux send-keys -t "$session_name" ":Obsidian quick_switch" C-m
