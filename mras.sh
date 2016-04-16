#!/bin/bash
# MRas
# author : Mostafa Asadi
# url    : http://ma73.ir
# Email  : mostafaasadi73@gmail.com
#
# requirement : ssh
# chmod +x mras.sh
# ./mras.sh

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.


first_function (){
echo -e "\n\n"
read -p "             Enter raspberry pi IP : " ip
read -p "             Enter raspberry pi user (Defualt:pi) : " user
option1_function
}

option1_function (){
echo -e "\n\t\tchose option : "
echo -e "\t\t\t[1]  ssh to Pi "
echo -e "\t\t\t[2]  Monitor Pi "
echo -e "\t\t\t[3]  Config and contorol "
echo -e "\t\t\t[4]  help and version \n"
read -p "                              option number : " option
}

option2_function (){
  echo -e "\n\n\t\tchose option : "
  echo -e "\t\t\t[1] os version "
  echo -e "\t\t\t[2] cpu info "
  echo -e "\t\t\t[3] memory info "
  echo -e "\t\t\t[4] partitions info "
  echo -e "\t\t\t[5] CPU temperature "
  echo -e "\t\t\t[6] DC voltage "
  echo -e "\t\t\t[7] usb hardware "
  echo -e "\t\t\t[8] Networking \n"
}
hv_function (){
  echo -e "\n\t\t\tMRas v0.1 "
  echo -e "\n\t\t\t\tA bash script to manage and monitor Raspberry Pi over ssh"
  echo -e "\t\t\t\tIt's just a personal tutorial project for fun ! "
  echo -e "\n\t\t\t License"
  echo -e "\t\t\t\t This program is free software ; you can redistribute it and/or modify it
  \t\t\t\t under the terms of the GNU General Public License as published by the Free Software Foundation"
  echo -e "\t\t\t\t\t https://github.com/mostafaasadi/mras\n\n"

}
clear screen
ip=`cat .iplog.txt`
user=`cat .userlog.txt`

clear screen
if [ -z "$ip" ];then
  first_function
else
  echo -e "\n\t\t\t Do you going to conect to $user@$ip ? (y/n) : \t\t\t\t"
  read -p "                               >> " renew
    if [ "$renew" == "y" ];then
      option1_function
    else
      first_function
    fi
fi

echo "$ip" > .iplog.txt
echo "$user" > .userlog.txt

if [ "$option" == "1" ];then
  clear screen
  ssh $user@$ip
 elif [ "$option" == "2" ];then
  option2_function
  read -p "                              option number : " option2
  case "$option2" in
    1)
    clear screen
    ssh $user@$ip 'cat /proc/version'
    ;;
    2)
    clear screen
    ssh $user@$ip 'cat /proc/cpuinfo'
    ;;
    3)
    clear screen
    ssh $user@$ip 'free -o -h'
    ;;
    4)
    clear screen
    ssh $user@$ip 'cat /proc/partitions'
    ;;
    5)
    clear screen
    ssh $user@$ip 'vcgencmd measure_temp'
    ;;
    6)
    clear screen
    ssh $user@$ip 'vcgencmd measure_volts'
    ;;
    7)
    clear screen
    ssh $user@$ip 'lsusb'
    ;;
    8)
    clear screen
    ssh $user@$ip 'ip a'
    ;;
    *)
    echo -e "\n\t\t\t Wrong option ! "
    exit
     ;;
esac
 elif [ "$option" == "3" ];then
   echo -e "\n\n\t\tchose option : "
   echo -e "\t\t\t[1] Pi config "
   echo -e "\t\t\t[2] shutdown Pi "
   echo -e "\t\t\t[3] restart Pi "
   read -p "                              option number : " option3
   if [ "$option3" == "1" ];then
     clear screen
     ssh $user@$ip 'sudo raspi-config'
   elif [[ "$option3" == "2" ]];then
     clear screen
     ssh $user@$ip 'sudo shutdown -h'
   elif [[ "$option3" == "3" ]];then
     clear screen
     ssh $user@$ip 'sudo shutdown -r now'
   fi
 elif [ "$option" == "4" ];then
   hv_function
fi
