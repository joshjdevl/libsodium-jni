#!/bin/bash

export GRADLE_OPTS="-Dorg.gradle.native=false -Dorg.gradle.daemon=true"
export NDK_VERSION=r13b
export ANDROID_SDK_VERSION=r24.4.1

if uname -a | grep -q -i darwin; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export ANDROID_NDK=/usr/local/opt/android-ndk
    export ANDROID_NDK_HOME=/usr/local/opt/android-ndk
    export ANDROID_SDK=/usr/local/opt/android-sdk
    export ANDROID_HOME=/usr/local/opt/android-sdk
else
    export MAVEN_VERSION=3.3.9
    export GRADLE_VERSION=3.3
    export NDK_TOOLCHAIN_PLATFORM=14
    export NDK_TOOLCHAIN_ARCHITECTURE=arm
    export NDK_ROOT=`pwd`/installs/android-ndk-${NDK_VERSION}
    export PATH=${NDK_ROOT}:$PATH
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    export ANDROID_NDK_HOME=${NDK_ROOT}
    export ANDROID_HOME=`pwd`/installs/android-sdk-linux
    export ANDROID_SDK=`pwd`/installs/android-sdk-linux
    export PATH=$ANDROID_SDK/tools:$ANDROID_SDK/tools/bin:$ANDROID_SDK/platform-tools:`pwd`/installs/apache-maven-${MAVEN_VERSION}:`pwd`/installs/gradle-${GRADLE_VERSION}/bin:`pwd`/installs/android-sdk-linux/tools:`pwd`/installs/android-toolchain/bin:${NDK_ROOT}:$PATH
fi

