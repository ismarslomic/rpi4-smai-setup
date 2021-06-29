#!/bin/bash

function main() {
  vcgencmd measure_temp | tail -c 7 | head -c 4
}

main
