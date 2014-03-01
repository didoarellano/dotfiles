#!/bin/bash

session='in-class--jquery-101'
term=gnome-terminal
t=tmux
emacs_light="emacs --no-window-system --eval '(dido-apply-in-class-config \"light\")'"
emacs_dark="emacs --no-window-system --eval '(dido-apply-in-class-config \"dark\")'"

# This works but switching to the in-class-projector--light profile before
# launching emacs produces shitty colors. Starting with the dark profile *then*
# switching to in-class-projector--light results in better colors.
# Starting from the in-class-projector--light and then running the tmux portion
# seems fine so WTH.
# Another problem(?) is when we detach from the tmux session the terminal
# instance also closes.

# if [[ $1 == '' ]]; then
#     $term --window-with-profile='in-class-projector--light' --command="class-init tmux"
#     exit
# fi

# has-session doesn't test for an exact match
$t list-sessions -F '#{session_name}' | grep -q "^$session$"
if [[ $? != 0 ]]; then
    $t new-session -s $session -d
    $t send-keys -t $session "$emacs_light" C-m
    $t split-window -t $session -h
    $t send-keys -t $session "$emacs_dark" C-m
fi

$t attach-session -t $session
