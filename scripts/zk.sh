#!/bin/bash
session_name="zk"

# 1. First you check if a tmux session exists with a given name.
tmux has-session -t=$session_name 2> /dev/null

# 2. Create the session if it doesn't exist.
if [[ $? -ne 0 ]]; then
  TMUX='' tmux new-session -d -s "$session_name"
fi

tmux switch-client -t "$session_name" \; send-keys -t "$session_name" "cd $ZETTELKASTEN_PATH; nvim" C-m
tmux send-keys -t "$session_name" ":FzfLua files cwd=Base" C-m


