#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function changeSwapSize() {
  e_note "Changing swap size"

  CONFIG="/etc/dphys-swapfile"
  # If a line containing "start_x" exists
  if grep -Fq "CONF_SWAPSIZE" $CONFIG; then
    # Replace the line
    e_note "Modifying CONF_SWAPSIZE"
    sudo sed -i "s/CONF_SWAPSIZE=100/CONF_SWAPSIZE=1024/g" $CONFIG
  else
    # Create the definition
    e_note "CONF_SWAPSIZE not defined. Creating definition"
    sudo echo "CONF_SWAPSIZE=1024" | sudo tee -a $CONFIG
  fi

  sudo /etc/init.d/dphys-swapfile restart
}

function revertBackSwapSize() {
  e_note "Reverting swap size"

  CONFIG="/etc/dphys-swapfile"
  sudo sed -i "s/CONF_SWAPSIZE=1024/CONF_SWAPSIZE=100/g" $CONFIG

  sudo /etc/init.d/dphys-swapfile restart
}

function installLibs() {
  e_note "Installing required libraries"
  sudo apt-get install -y build-essential \
    cmake \
    gfortran \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libboost-all-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
    python3-pip \
    zip \
    python3-picamera

  sudo pip3 install --upgrade picamera[array]
}

function installDlib() {
  e_note "Installing Dlib"
  git clone -b 'v19.6' --single-branch https://github.com/davisking/dlib.git ~/dlib
  sudo python3 ~/dlib/setup.py install --compiler-flags "-mfpu=neon"
}

function installOpenCvAndFaceRecognition() {
  e_note "Installing OpenCv and Face recognition"

  pip3 install numpy --upgrade
  pip3 install scikit-image --upgrade

  sudo apt-get install -y python3-scipy \
    libjasper-dev \
    libqtgui4 \
    python3-pyqt5 \
    libqt4-test

  pip3 install opencv-python==3.4.6.27
  pip3 install face_recognition --upgrade
}

function installFaceRecognitionSmai() {
  e_note "Installing MMM-Face-Recognition-SMAI"

  git clone https://github.com/EbenKouao/MMM-Face-Recognition-SMAI.git ~/MagicMirror/modules/MMM-Face-Recognition-SMAI
  (cd ~/MagicMirror/modules/MMM-Face-Recognition-SMAI && npm install)
}

function main() {
  e_header "Installing Magic Mirror module: MMM-Face-Recognition-SMAI"

  installLibs
  changeSwapSize
  installDlib
  installOpenCvAndFaceRecognition
  installFaceRecognitionSmai
  revertBackSwapSize

  e_success "Installing MMM-Face-Recognition-SMAI module completed"
}

main
