#!/bin/bash

i3dir=~/.i3
main_config=$i3dir/config
base_config=$i3dir/i3-config-base.conf
laptop_config=$i3dir/i3-config-laptop.conf
docked_laptop_config=$i3dir/i3-config-docked-laptop.conf
dual_head_config=$i3dir/i3-config-dual-head.conf
class_config=$i3dir/i3-config-class.conf

# Default to "dual" argument
mode=${1:-dual}
mode_config=$dual_head_config
if [[ $mode == 'laptop' ]]; then
    mode_config=$laptop_config
fi
if [[ $mode == 'docked' ]]; then
    mode_config=$docked_laptop_config
fi
if [[ $mode == 'class' ]]; then
    mode_config=$class_config
fi

in_array () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

workspaces=$(i3-msg -t get_workspaces)

# We just need the workspace numbers
workspace_nums=($(echo $workspaces | jq '.[].num'))

# Last column of config is xrandr dispay output (HDMI1, LVDS1)
workspace_outputs=($(sed '/^$/d' $mode_config | awk '{print $4}'))

# Remember workspace we were called in. We'll restore this later.
focused_workspace=$(echo $workspaces | jq 'map(select(.focused == true))' | jq '.[].num')

# We use a `for' loop with a loop counter instead of a `for in' because we use
# the counter as workspace numbers (once we increment it by 1) for the xrandr
# display outputs in $workspace_outputs.
for ((i = 0; i <= "${#workspace_outputs[@]}"; i++))
do
    workspace_num=$(($i + 1))
    workspace_output=${workspace_outputs[$i]}
    if in_array $workspace_num "${workspace_nums[@]}"; then
        # $workspace_num exists, switch to it so we can move it.
        i3-msg workspace $workspace_num
        i3-msg move workspace to output $workspace_output
    fi
done

# Restore the focused workspace
i3-msg workspace $focused_workspace

# Create config file with desired workspace output mapping then reload i3
rm --force $main_config
cat $base_config $mode_config > $main_config
i3-msg reload
