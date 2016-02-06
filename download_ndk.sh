#!/bin/sh
ARCH=$(uname -m)
echo $ARCH
if [$ARCH -ne "x86_64"]; then
  $ARCH = "x86"
fi
wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-$ARCH.bin
chmod a+x android-ndk-r10d-linux-$ARCH.bin
./android-ndk-r10d-linux-$ARCH.bin
