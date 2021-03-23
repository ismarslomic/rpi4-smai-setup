#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function installOpenCV() {
  # see https://github.com/cyysky/OpenCV-Raspberry-Pi-4-Package-for-Python

  target="/home/pi/opencv"
  mkdir -p $target
  wget https://github.com/cyysky/OpenCV-Raspberry-Pi-4-Package-for-Python/raw/master/opencv_4.5.0-1_armhf.deb -P $target
  sudo dpkg -i $target/opencv_4.5.0-1_armhf.deb || true # This will fail because of missing deps, using || true to continue
  sudo apt-get -f install -y                            # Auto install dependency package
  sudo dpkg -i $target/opencv_4.5.0-1_armhf.deb         # Now start install
  export LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1.2.0

  e_success "Installing OpenCV completed"
}

function installDlib() {
  pip3 install dlib

  e_success "Installing dlib lib completed"
}

function installFaceRecognition() {
  pip3 install face_recognition

  e_success "Installing face_recognition lib completed"
}

function installImutils() {
  pip3 install imutils

  e_success "Installing imutils lib completed"
}

function installNumpy() {
  pip3 install numpy

  e_success "Installing numpy lib completed"
}

# see https://github.com/nischi/MMM-Face-Reco-DNN
function main() {
  e_header "Installing dependencies for Magic Mirror module: MMM-Face-Reco-DNN"

  installOpenCV
  installDlib
  installFaceRecognition
  installImutils
  installNumpy

  e_success "Installing dependencies for MMM-Face-Reco-DNN module completed"
}

main
