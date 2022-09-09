#!/bin/bash

function main() {
  xrandr -display :0 --output HDMI-1 --auto --rotate left
}

main
