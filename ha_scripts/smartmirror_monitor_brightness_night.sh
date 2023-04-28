#!/bin/bash

# Setting brightness and contrast of monitor by using ddccontrol command (https://github.com/ddccontrol/ddccontrol)
function main() {
  # Set brightness (0x10) to 10% and contrast (0x12) to 10% at night time
  # You might need to modify the monitor id (/dev/i2c-20) to your monitor id
  ddccontrol -r 0x10 -w 10 dev:/dev/i2c-20 && ddccontrol -r 0x12 -w 10 dev:/dev/i2c-20
}

main
