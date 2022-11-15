#!/bin/bash
#installs python modules
pip3 install frida-tools
pip3 install objection
pip3 install mobsfscan
#installs ubuntu software neede for phone and dex2jar
sudo apt-get install adb default-jdk
#installs dex2jar and jadx and puts them in the proper place
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
