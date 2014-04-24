#!/bin/bash

black='#333333'
blacker='#111111'
white='#eeeeee'
blue='#5f87af'
separator=''

format_for_colors() {
    echo "#[bg=$2, fg=$3]$1"
}

# The spaces between the colon will be added when we loop over this. We don't
# format it with a space here because the spaces cause string splittage. Learn
# to bash foo.
windows=($(tmux list-windows -F "#I:#W"))
current_index=$(tmux display-message -p '#I')

output=''
last_index=${#windows[@]}
for window in "${windows[@]}"; do
    index=${window:0:1}
    text=$(format_for_colors $window $black $white)

    if [ $index != $current_index ]; then
        left_sep=$(format_for_colors $separator $black $black)
        right_sep=$(format_for_colors $separator $black $black)

        if [ $index -eq $last_index ]; then
            right_sep=$(format_for_colors $separator $blacker $black)
        fi
    else
        text=$(format_for_colors $window $blue $white)
        left_sep=$(format_for_colors $separator $blue $black)
        right_sep=$(format_for_colors $separator $black $blue)

        if [ $index = '1' ]; then
            left_sep=$(format_for_colors $separator $blue $blue)
        fi
    fi

    text=${text/':'/' : '}
    output="$output $left_sep $text $right_sep"
done

echo -n $output
