# aliases
alias ll="ls -alG"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

function temperature(){
  vcgencmd measure_temp
}

function photo(){
  DATE=$(date +"%Y-%m-%d_%H%M")
  FILE_NAME=/home/pi/Pictures/$DATE.jpg
  raspistill -o $FILE_NAME
  echo "Stored to $FILE_NAME"
}

function monitorOff(){
  vcgencmd display_power 0
}

function monitorOn(){
  vcgencmd display_power 1
}

function monitorStatus(){
  vcgencmd display_power
}

function monitorStatusBinary(){
  STATUS="(vcgencmd display_power | tail -c 2 | head -c 1)"
  if [ $(STATUS) = 1 ]; then
    echo 0
    exit 0
  else
    echo -1
    exit 0
  fi
}

function docker-prune(){
  sudo docker image prune --all -f
}

function docker-pull-up(){
  sudo docker compose pull && sudo docker compose up -d
}

function update(){
  { echo -e "\e[30;48;5;248mUpdate Packages\e[0m"; } 2> /dev/null
  sudo apt update

  { echo -e "\n\e[30;48;5;248mFull Upgrade Packages\e[0m"; } 2> /dev/null
  sudo apt full-upgrade -y

  { echo -e "\n\e[30;48;5;248mRemove Dependency Packages That Are No Longer Needed\e[0m"; } 2> /dev/null
  sudo apt --purge autoremove -y

  { echo -e "\n\e[30;48;5;248mClean apt Cache\e[0m"; } 2> /dev/null
  sudo apt clean -y

  { echo -e "\n\e[30;48;5;248mUpdate Static Motd - Dynamic Folder File /etc/update-motd.d/20-update\e[0m"; } 2> /dev/null
  sudo run-parts /etc/update-motd-static.d

  { echo -e "\n\e[30;48;5;248mCheck if reboot is required\e[0m"; } 2> /dev/null
  sudo /etc/update-motd.d/25-reboot-required
}
