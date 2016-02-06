#!/bin/bash

set -ev

. ./setenv.sh

apt-get install -y sudo

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
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
sudo apt-fast install -y -qq oracle-java7-installer maven

mkdir -p /installs
pushd /installs
wget --quiet https://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
chmod 755 android-ndk-r10e-linux-x86_64.bin
./android-ndk-r10e-linux-x86_64.bin &> extract.log
${NDK_ROOT}/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=/installs/android-toolchain --system=linux-x86_64 --ndk-dir=${NDK_ROOT}

popd
