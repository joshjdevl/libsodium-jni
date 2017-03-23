#!/bin/bash -ev

. ./setenv.sh

pushd ./installs
wget --quiet https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
test -e "gradle-${GRADLE_VERSION}" || unzip -qq "gradle-${GRADLE_VERSION}"-bin.zip

wget --quiet https://dl.google.com/android/repository/tools_${ANDROID_SDK_VERSION}-linux.zip
test -e "tools" || unzip -qq tools_${ANDROID_SDK_VERSION}-linux.zip # Do not overwrite an installed Android SDK, because overwriting it may corrupt it.
popd

mkdir -p ${ANDROID_HOME}/licenses
echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > ${ANDROID_HOME}/licenses/android-sdk-license
