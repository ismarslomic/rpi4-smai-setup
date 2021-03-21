# Rpi 4 Smart Mirror AI setup scripts
Scripts for automating Raspberry Pi 4 configuration and [MagicMirror²](https://magicmirror.builders/)
setup on Rpi for creating Smart Mirror touchscreen with face recognition.

I created these scripts since it took me quite a lot of effort to find a relevant documentation of 
what needs to be setup for complete solution. This is of course spread over many places on the 
web and includes many manual steps which is time-consuming and error prone. Since I like to keep my 
infrastructure and software configuration as a code in version control system I ended up with 
this repo. 

This makes also re-installation much easier when you need to start from the scratch and hopefully
makes it easier for getting started for new peeps.

This solution is based on fantastic and inspiring work from 
Eben Kouao which you can read more about at 
[Smart Mirror Touchscreen (with FaceID) Tutorial – Raspberry Pi 4](https://smartbuilds.io/smart-mirror-touchscreen-raspberry-pi/)

## Software features
- Touchscreen interaction (requires hardware, see below)
- Face recognition (requires hardware, see below) with personalised content
  
## What is automated
- [MagicMirror²](https://magicmirror.builders/) installation
- [MagicMirror²](https://magicmirror.builders/) module 
  [MMM-Face-Multi-User-Recognition-SMAI](https://github.com/jimbydude/MMM-Face-Multi-User-Recognition-SMAI) 
  installation for multi-user face recognition and personalised content
- [MagicMirror²](https://magicmirror.builders/) module [MMM-Face-Reco-DNN](https://github.com/nischi/MMM-Face-Reco-DNN)
  installation with required libs for face recognition with Open CV and Deep Neural Network
- [MagicMirror²](https://magicmirror.builders/) module [MMM-SmartTouch](https://github.com/EbenKouao/MMM-SmartTouch)
  installation for controlling MagicMirror² using a touchscreen
- [PM2](https://pm2.io/) installation for auto starting [MagicMirror²](https://magicmirror.builders/) on boot
- Rpi configuration
  - Disable Screen Blanking to avoid screen going black when no interaction
  - Setup WiFi (SSID and password)
  - Enable Rpi Camera Module
  - Enable SSH for easier management of Rpi from other machines
  - Set timezone (default to Europe/Oslo)
  - Set OS locale (default to Norwegian Bokmål)
  - Set Keyboard layout (default to Norwegian)
  - Disable boot splash screen at boot
  - Set boot to Desktop and auto login `pi`-user
- Create bash aliases to make CLI commands easier in Rpi
- Install [vim](https://www.vim.org/) and [xclip](https://github.com/astrand/xclip) packages

## Hardware requirements
I have only tested with following hardware, but it might work with
your spec as well.
- [Raspberry Pi 4 Model B, 4GB RAM](https://www.komplett.no/product/1133779/datautstyr/pc-komponenter/hovedkort/integrert-cpu/raspberry-pi-4-model-b-4gb-ram)
- [Raspberry Pi 4 Power supply](https://www.komplett.no/product/1133588/datautstyr/pc-komponenter/hovedkort/tilbehoer/raspberry-pi-4-stroemadapter-usb-c)
- [Raspberry Camera Module v2](https://www.kjell.com/no/produkter/data/raspberry-pi/raspberry-pi-kameramodul-v2-p88053)  
- [ICY Box](https://www.komplett.no/product/1140767/datautstyr/pc-komponenter/hovedkort/tilbehoer/icy-box-clear-acrylic-and-frameless-case) including fan and heat sinks
- [Micro HDMI cable](https://www.kjell.com/no/produkter/lyd-og-bilde/kabler-og-adaptere/hdmi/micro-hdmi/micro-hdmi-kabel-high-speed-2-m-p98652)
- [ViewSonic 32" LED VX3276-2K-mhd](https://www.komplett.no/product/1018397)
- TODO: touchscreen
- TODO: two-way mirror
- TODO: frame

## Preconditions
- Fresh installation of _Raspberry Pi OS with Desktop_ (Buster) installed (tip: use [Raspberry Pi Imager](https://www.raspberrypi.org/software/))
- You are logged in as default user `pi` in Rpi
- Raspberry Pi Camera Module v2 connected
- [OpenWeather API key](https://home.openweathermap.org/api_keys) in order to use the default 
  modules [currentweather](https://docs.magicmirror.builders/modules/currentweather.html)
  and [weatherforecast](https://docs.magicmirror.builders/modules/weatherforecast.html)

## Installation
Open Terminal in Rpi and execute these commands
````shell
git clone https://github.com/ismarslomic/rpi4-smai-setup.git /home/pi/rpi4-smai-setup

cd /home/pi/rpi4-smai-setup

./setup.sh
````
The [setup.sh](./setup.sh) script is suitable for initial setup on fresh Raspberry Pi OS and makes 
sure to run all necessary scripts (in sub-folders).

If you later want to do the adjustments you should avoid doing those directly in MagicMirror folder
or in general on Rpi OS, but rather adjust existing scripts or add new one to make sure that all
setup is automated and version controlled.

## Controlling MagicMirror² via PM2
With your MagicMirror running via PM2, you have some handy tools at hand:
#### Restarting your MagicMirror²
````shell
pm2 restart mm
````
#### Stopping your MagicMirror²
````shell
pm2 stop mm
````
#### Show the MagicMirror² logs
````shell
pm2 logs mm
````
#### Show the MagicMirror² process information
````shell
pm2 show mm
````

## Connect to your Rpi from other machine
### Find IP address of Rpi
`````shell
hostname -I
`````

### Connect through ssh
`````shell
ssh pi@<IP address>
`````