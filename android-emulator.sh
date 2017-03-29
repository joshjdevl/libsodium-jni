#!/bin/bash -ev

. ./setenv.sh

ANDROID_API="${ANDROID_API:-android-10}"
ANDROID_ABI="${ANDROID_ABI:-armeabi-v7a}"

cat "$(which android-wait-for-emulator)"
while true; do echo y; sleep 3; done | sdkmanager "system-images;${ANDROID_API};default;${ANDROID_ABI}" "platforms;${ANDROID_API}"
android list targets
echo no | android create avd --force -n test -k "system-images;${ANDROID_API};default;${ANDROID_ABI}" --abi "${ANDROID_ABI}"
emulator -avd test -no-window -no-accel -memory 512 -wipe-data 2>&1 | tee emulator.log &
adb logcat 2>&1 | tee logcat.log &

if [ "$ANDROID_API" = "android-10" ] && [ "$ANDROID_ABI" = "armeabi-v7a" ]; then
	sleep 240 # android-wait-for-emulator hangs for ANDROID_API=android-10 ANDROID_ABI=armeabi-v7a, so we wait and hope the emulator has started during that time.
else
	android-wait-for-emulator
fi

# Replace /dev/random by /dev/urandom in order to make accessing /dev/random not block during testing.
# This is only to augment the synthetic testing environment.
# Do not use this in production, as that this makes the perceived randomness actually non-random. 
adb -e shell 'rm /dev/random; ln -s /dev/urandom /dev/random' || true # This may fail for Android-25, but it is not needed for Android-25

