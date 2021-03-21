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