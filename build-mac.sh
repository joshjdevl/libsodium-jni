#!/bin/bash

##
# Steps:
#
#   1. Build libsodium shared libraries for Android
#
#   2. Run swig to create sodium_wrap.c 
#
#   3. Run ndk-build to build our sodiumjni shared libraries for android
#      and use GCC to build for osx/linux
#
#   4. Run gradle build script

# Fail if anything returns non-zero
set -e

require_env_var() {
    if [ -z "$1" ]; then
        echo "build-libsodium.sh: ERROR: Required env variable '$2' not set."
        echo "build-libsodium.sh: Exiting!"
        exit 1
    fi
}

require_env_var "$JAVA_HOME" "JAVA_HOME"
require_env_var "$ANDROID_HOME" "ANDROID_HOME"
# export ANDROID_HOME=~/Library/Android/sdk/
require_env_var "$ANDROID_NDK_HOME" "ANDROID_NDK_HOME"

# Root location of the sodium-jni project
SODIUMJNI_HOME=$(pwd)

# Location of the sodiumJNI java classes (where SWIG should put the generated files)
SODIUMJNI_SRC_ROOT="${SODIUMJNI_HOME}/app/src"

# libsodium build location
LIBSODIUM_JNI_HOME="${SODIUMJNI_HOME}/jni"

##
# Step 0
#
echo 'Step 0: installing required libs'
brew install swig automake autoconf libtool maven pcre
# TODO: apt-get instead for debian/ubuntu


##
#   Step 1
#
echo 'Step 1: Building libsodium'
# first test if libsodium submodule was imported, if not then:
# git clone https://github.com/jedisct1/libsodium.git
cd libsodium
# ./autogen.sh
# echo "android-arm"
# ./dist-build/android-arm.sh
# echo "android-armv7-a"
# ./dist-build/android-armv7-a.sh
# echo "android-armv8-a"
# ./dist-build/android-armv8-a.sh
# echo "android-mips32"
# ./dist-build/android-mips32.sh
# echo "android-mips64"
# ./dist-build/android-mips64.sh
# echo "android-x86"
# ./dist-build/android-x86.sh
# echo "android-x86-64"
# ./dist-build/android-x86-64.sh
cd ..

##
#   Step 2 
#
echo 'Step 2: Swig-ing libsodium'
cd $LIBSODIUM_JNI_HOME
SODIUMJNI_JAVA_PACKAGE_ROOT=$LIBSODIUM_JNI_HOME/../src/main/java/org/abstractj/kalium
rm -rf $SODIUMJNI_JAVA_PACKAGE_ROOT
mkdir -p $SODIUMJNI_JAVA_PACKAGE_ROOT
export C_INCLUDE_PATH="${JAVA_HOME}/include:${JAVA_HOME}/include/linux:/System/Library/Frameworks/JavaVM.framework/Headers"

rm -f *.c
swig -java -package org.abstractj.kalium -outdir $SODIUMJNI_JAVA_PACKAGE_ROOT sodium.i

##
#   Step 3
#
echo 'Step 3: Creating shared library'
cd $LIBSODIUM_JNI_HOME

# For linux, we want to create a shared library for running tests on the local jvm
jnilib=libsodiumjni.so
LIBRARY_INCLUDE_PATH=/usr/lib
destlib=$LIBRARY_INCLUDE_PATH
JAVA_LIB_INCLUDE_PATH=$JAVA_HOME/include/linux
if uname -a | grep -q -i darwin; then
    # For OSX java requires some different lib locations/names 
    jnilib=libsodiumjni.jnilib
	LIBRARY_INCLUDE_PATH=/usr/local/lib
    destlib=$LIBRARY_INCLUDE_PATH/java
	JAVA_LIB_INCLUDE_PATH=$JAVA_HOME/include/darwin
fi
echo " jnilib: $jnilib"
echo " destlib: $destlib"
LIBSODIUM_LOCAL_INCLUDE=$LIBSODIUM_JNI_HOME/../libsodium/src/libsodium/include
echo " include: $LIBSODIUM_LOCAL_INCLUDE"
# Local JVM build (OSX/Linux)
echo 'Local JVM build'
gcc -I${JAVA_HOME}/include -IJAVA_LIB_INCLUDE_PATH -I${LIBSODIUM_LOCAL_INCLUDE} sodium_wrap.c -shared -fPIC -L${LIBRARY_INCLUDE_PATH} -lsodium -o $jnilib

sudo rm -f "$destlib/$jnilib" 
sudo mv $jnilib $destlib

# Android build
pwd
echo 'Android build'
PATH=$PATH:$ANDROID_NDK_HOME
ndk-build

# do some cleanup
echo 'Cleaning up'
rm -rf $SODIUMJNI_HOME/obj
rm -rf $SODIUMJNI_SRC_ROOT/main/lib
cp $SODIUMJNI_HOME/libs $SODIUMJNI_SRC_ROOT/main/lib

##
#   Step 4
#

echo 'Step 4: maven build'
mvn clean install


# echo 'Step 4: gradle build'
# cd $SODIUMJNI_HOME
# ./gradlew build
# 
# SKIP_TEST="skip-test"
# if [ "$1" != "$SKIP_TEST" ]; then
# ./gradlew connectedCheck 
# fi
# 
# rm -rf $SODIUMJNI_HOME/build 
# rm -rf $SODIUMJNI_HOME/sodiumjni-androidlib
# mv $SODIUMJNI_HOME/app/build/outputs/aar $SODIUMJNI_HOME/sodiumjni-androidlib
# rm -rf $SODIUMJNI_HOME/app/build
