#!/bin/bash -ev

. ./setenv.sh

cat "$(which android-wait-for-emulator)"
echo y | sdkmanager 'system-images;android-10;default;armeabi-v7a' 'platforms;android-10'
android list targets
echo no | android create avd --force -n test -t android-10 --abi armeabi-v7a
emulator -avd test -no-window -memory 512 -wipe-data 2>&1 | tee emulator.log &
adb logcat 2>&1 | tee logcat.log &

# Workaround from https://code.google.com/p/android/issues/detail?id=10255#c31 to prevent the hanging of "adb shell"
while true; do 
#	echo "Pinging ADB server."
	adb -e shell echo ping || true
	sleep 10
done &

android-wait-for-emulator
