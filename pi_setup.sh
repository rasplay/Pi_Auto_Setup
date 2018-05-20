#!/usr/bin/env bash

sudo apt-get autoremove --purge realvnc*
sudo apt-get install xrdp
sudo apt-get -y update && sudo apt-get upgrade -y

# X11 hangul Install
sudo apt-get -y install fcitx-hangul

# X11 D2Coding-Font Install and Setting
#wget https://github.com/naver/d2codingfont/releases/download/VER1.21/D2Coding-1.2.zip
wget https://github.com/naver/d2codingfont/releases/download/VER1.3.1/D2Coding-Ver1.3.1-20180115.zip
sudo mkdir /usr/share/fonts/truetype/D2Coding
#sudo unzip D2Coding-1.2.zip -d /usr/share/fonts/truetype/D2Coding/
sudo unzip D2Coding-Ver1.3.1-20180115.zip -d /usr/share/fonts/truetype/D2Coding/
rm *.zip
sudo rm -rf /usr/share/fonts/truetype/D2Coding/__MACOSX
sudo fc-cache -f -v

# Keyboard Setting Change on the korea
sudo sed -i '
  s/XKBMODEL=.*/XKBMODEL="pc105"/
  s/XKBLAYOUT=.*/XKBLAYOUT="kr"/
  s/XKBVARIANT=.*/XKBVARIANT="kr104"/
  s/XKBOPTIONS=.*/XKBOPTIONS="terminate:ctrl_alt_bksp"/' /etc/default/keyboard


# locale Setting Change on the korea
sudo tee /etc/default/locale <<-EOF
#  File generated by update-locale
LANG=ko_KR.UTF-8
EOF

sudo tee /etc/locale.gen <<-EOF
# This file lists locales that you wish to have built. You can find a list
# of valid supported locales at /usr/share/i18n/SUPPORTED, and you can add
# user defined locales to /usr/local/share/i18n/SUPPORTED. If you change
# this file, you need to rerun locale-gen.
#
ko_KR.UTF-8 UTF-8
EOF

sudo locale-gen

# Seoul locale-time Setting
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# HDMI 1080p Monitor Setting  through RaspberryPi
sudo sed -i '
  s/#hdmi_group=1.*/hdmi_group=2/
  s/#hdmi_mode=1.*/hdmi_mode=58/
  s/#hdmi_drive=2.*/hdmi_drive=2/' /boot/config.txt

# SSH Enable
sudo /etc/init.d/ssh start

# raspberrypi firm-ware update
sudo rpi-update

sudo reboot
