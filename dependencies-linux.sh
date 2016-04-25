#!/bin/bash

set -ev

. ./setenv.sh

sudo apt-get -qq update && sudo apt-get -y -qq install python-software-properties software-properties-common
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get update -qq

sudo add-apt-repository ppa:saiarcot895/myppa
sudo apt-get update
sudo apt-get -y -qq install apt-fast

sudo apt-fast update

sudo apt-fast install -y -qq wget git autoconf autoconf automake build-essential autogen libtool gettext-base gettext vim bzip2 libpcre3-dev libpcre++-dev pkg-config
#gradle building issues
sudo apt-fast install -y -qq gcc-multilib lib32z1
sudo add-apt-repository ppa:webupd8team/java -y 
sudo apt-fast update -qq
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-fast install -y -qq oracle-java8-installer maven

mkdir -p ./installs
pushd ./installs
wget http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip
chmod 755 android-ndk-r11c-linux-x86_64.zip
unzip android-ndk-r11c-linux-x86_64.zip
${NDK_ROOT}/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=`pwd`/installs/android-toolchain --ndk-dir=${NDK_ROOT}

popd

pushd jni
./installswig.sh
popd

./download-gradle.sh 

./update-android.sh
