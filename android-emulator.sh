#!/bin/bash -ev

. ./setenv.sh

ANDROID_API="${ANDROID_API:-android-10}"
ANDROID_ABI="${ANDROID_ABI:-armeabi-v7a}"

cat "$(which android-wait-for-emulator)"
echo y | sdkmanager "system-images;${ANDROID_API};default;${ANDROID_ABI}" "platforms;${ANDROID_API}"
android list targets
echo no | android create avd --force -n test -t "${ANDROID_API}" --abi "${ANDROID_ABI}"
emulator -avd test -no-window -no-accel -memory 512 -wipe-data 2>&1 | tee emulator.log &
adb logcat 2>&1 | tee logcat.log &

# Workaround from https://code.google.com/p/android/issues/detail?id=10255#c31 to prevent the hanging of "adb shell"
while true; do 
#	echo "Pinging ADB server."
	adb -e shell echo ping || true
	sleep 10
done &

android-wait-for-emulator

# Replace /dev/random by /dev/urandom in order to make accessing /dev/random not block during testing.
# This is only to augment the synthetic testing environment.
# Do not use this in production, as that this makes the perceived randomness actually non-random. 
adb -e shell 'rm /dev/random; ln -s /dev/urandom /dev/random' || true # This may fail for Android-25, but it is not needed for Android-25

