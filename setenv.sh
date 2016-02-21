#!/bin/bash

if uname -a | grep -q -i darwin; then
    echo "do nothing"
else
    export NDK_ROOT=/installs/android-ndk-r10e
    export PATH=/installs/android-toolchain/bin:${NDK_ROOT}:$PATH
    export PATH=${NDK_ROOT}:$PATH
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    export ANDROID_NDK_HOME=${NDK_ROOT}
fi

