#!/bin/sh

# This script is used to control a USB Traffic Light from Cleware. You can buy 
# the USB Traffic Light from this shop: http://www.cleware-shop.de
# 
# The script uses the REST API and can be used for newer versions of Jenkins.
#
# Requirements:
# 
#   The Cleware USB Traffic Light comes with a control software that you can 
#   download from http://www.vanheusden.com/clewarecontrol/ 
#
#   This script can be run under Linux. You need to have "curl" installed, 
#   so the script can poll the REST API.
#
#   This script has been tested under Ubuntu and clewarecontrol 2.0
#
# @MarcelBirkner
# 

JENKINS_SERVER="http://fmw-xps:8080/job/"
JOB_NAME="my_test_job"
#JENKINS_URL=$JENKINS_SERVER$JOB_NAME
JENKINS_URL=http://localhost:8080/view/my_view
DEVICE_NO="/dev"

# Methods for controlling the device (2=blue, 1=yellow, 0=red)
lightOn() {
  clewarecontrol -c 1 -d $DEVICE_NO -as $1 1 2>&1 
}
lightOff() {
  clewarecontrol -c 1 -d $DEVICE_NO -as $1 0 2>&1 
}
allOff() {
  lightOff 0;
  lightOff 1;
  lightOff 2;
}

while true; do 
  color=`curl -silent $JENKINS_URL/api/json?pretty=true | grep color `
  echo $color
  state=`echo $color | sed 's/\"//g' | sed 's/,//g' | awk '{print $3}'` 
  echo $state;
  case $state in 
    red)          echo "---------->State: $state"; allOff; lightOn 0;;
    yellow)       echo "State: $state"; allOff; lightOn 1;;
    blue)         echo "State: $state"; allOff; lightOn 2;;
    red_anime)    echo "State: $state"; allOff; sleep 1; lightOn 0; sleep 1; lightOff 0; sleep 1; lightOn 0;;
    yellow_anime) echo "State: $state"; allOff; sleep 1; lightOn 1; sleep 1; lightOff 1; sleep 1; lightOn 1;;
    blue_anime)   echo "State: $state"; allOff; sleep 1; lightOn 2; sleep 1; lightOff 2; sleep 1; lightOn 2;;
    *)            echo "Nothing matched state: $state";;  
  esac;
  sleep 1;  
done;

