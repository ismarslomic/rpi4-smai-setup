#!/bin/bash

function main() {
    export DISPLAY=:0
    xrandr --output HDMI-1 --auto
}

main
