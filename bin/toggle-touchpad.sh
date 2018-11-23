#!/bin/bash

state=$(synclient -l | awk '/TouchpadOff/ {print $3}')
new_state=$([ $state == 0 ] && echo 1 || echo 0)
synclient TouchpadOff=$new_state
