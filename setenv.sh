#!/bin/bash

export GRADLE_OPTS=-Dorg.gradle.native=false
export NDK_VERSION=r12b

if uname -a | grep -q -i darwin; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export ANDROID_NDK=/usr/local/opt/android-ndk
    export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
    export ANDROID_SDK=/usr/local/opt/android-sdk
    export ANDROID_HOME=/usr/local/opt/android-sdk
else
    export GRADLE_VERSION=2.14.1
    export NDK_TOOLCHAIN_PLATFORM=android-14
    export NDK_TOOLCHAIN_ARCHITECTURE=arm
    export NDK_ROOT=`pwd`/installs/android-ndk-${NDK_VERSION}
    export PATH=`pwd`/installs/gradle-${GRADLE_VERSION}/bin:`pwd`/installs/android-sdk-linux/tools:`pwd`/installs/android-toolchain/bin:${NDK_ROOT}:$PATH
    export PATH=${NDK_ROOT}:$PATH
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    export ANDROID_NDK_HOME=${NDK_ROOT}
    export ANDROID_HOME=`pwd`/installs/android-sdk-linux
fi

