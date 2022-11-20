#!/bin/bash


#installs ubuntu software needed for all tools
sudo apt-get install adb default-jdk git python3.8 openjdk-8-jdk python3-dev python3-venv python3-pip build-essential libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev wkhtmltopdf  

#installs python modules
pip3 install frida-tools
pip3 install objection
pip3 install mobsfscan

#installs dex2jar and jadx and puts them in the proper place
https://github.com/MobSF/Mobile-Security-Framework-MobSF.git && cd Mobile-Security-Framework-MobSF
./setup.sh
cd ~
git clone https://github.com/pxb1988/dex2jar.git && cd dex2jar
./gradlew  distZip
mv dex-tools/build/distributions/dex-tools-2.2-SNAPSHOT.zip ~/mobsfscan_auto
cd ~
git clone https://github.com/skylot/jadx.git
cd jadx
./gradlew dist
cd ~
mv jadx/ mobsfscan_auto/
cd mobsfscan/

#creates paths for tools
./create_PATHS
echo $PATH
