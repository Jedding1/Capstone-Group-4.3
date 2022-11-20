#!/bin/bash

echo "Please run frida server on your device first before running this script."
echo "---------------------------------------------------------"
echo "                                                         "

#scans package names
adb shell pm list packages
echo "   "
echo "---------------------------------------------------------"
echo "What package would you like to examine? "
echo "---------------------------------------------------------"
read packagename

#prints package path
adb shell pm path $packagename
echo "---------------------------------------------------------"
echo "please enter package path to base.apk file"
echo "---------------------------------------------------------"
read packagepath

#pulls package and unzips it, 
#I would like to have it keep its name with the mv command and not have to use *.apk
adb pull $packagepath
mv *.apk base.zip
mkdir base
unzip base.zip -d base/

#runs dex2jar
cd base/
for i in $(ls *.dex)
do
d2j-dex2jar.sh ./$i
done

#runs jadx
for i in $(ls *.jar)
do
jadx ./$i -d ./
done
mobsfscan path base/ --json -o apk.json
