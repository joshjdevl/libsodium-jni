#!/bin/bash -ev

set -ev

. ./setenv.sh

mkdir -p ./installs
pushd ./installs
wget --quiet http://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip
chmod 755 android-ndk-${NDK_VERSION}-linux-x86_64.zip
test -e "android-ndk-${NDK_VERSION}" || unzip -qq "android-ndk-${NDK_VERSION}"-linux-x86_64.zip
test -e `pwd`/android-toolchain || ${NDK_ROOT}/build/tools/make_standalone_toolchain.py -v --api=${NDK_TOOLCHAIN_PLATFORM} --arch=${NDK_TOOLCHAIN_ARCHITECTURE} --install-dir=`pwd`/android-toolchain 
popd

pushd ./installs
wget --quiet http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
tar -xf apache-maven-${MAVEN_VERSION}-bin.tar.gz
popd

pushd jni
./installswig.sh
popd

./download-gradle.sh 

./update-android.sh
