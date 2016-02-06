#!/bin/sh

cd android-ndk-r10d
export ANDROID_NDK_HOME=`pwd`

cd ..
cd libsodium
./autogen.sh
./dist-build/android-arm.sh
./dist-build/android-armv7-a.sh
./dist-build/android-mips32.sh
./dist-build/android-x86.sh
