#!/bin/bash -ev

. ./setenv.sh

cat "$(which android-wait-for-emulator)"
echo y | sdkmanager 'system-images;android-10;default;armeabi-v7a' 'platforms;android-10'
android list targets
echo no | android create avd --force -n test -t android-10 --abi armeabi-v7a
emulator -avd test -no-window -memory 512 -wipe-data 2>&1 | tee emulator.log &
adb logcat 2>&1 | tee logcat.log &
bash -x "$(which android-wait-for-emulator)"
android-wait-for-emulator
