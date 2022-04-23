#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function installOpenCV() {
  pip3 install opencv-python --upgrade

  e_success "Installing OpenCV completed"
}

function installDlib() {
  pip3 install dlib --upgrade

  e_success "Installing dlib lib completed"
}

function installFaceRecognition() {
  pip3 install face_recognition --upgrade

  e_success "Installing face_recognition lib completed"
}

function installImutils() {
  pip3 install imutils --upgrade

  e_success "Installing imutils lib completed"
}

function installNumpy() {
  pip3 install numpy --upgrade

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
