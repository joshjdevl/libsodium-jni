#!/bin/sh

cd jni
./installswig.sh

export JAVA_HOME=/usr/bin/
./compile.sh

export PATH=$PATH:$ANDROID_NDK_HOME
ndk-build
