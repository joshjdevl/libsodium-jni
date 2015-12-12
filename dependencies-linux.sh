#!/usr/bin/bash

set -ev

. ./setenv.sh

apt-get update && apt-get -y install python-software-properties software-properties-common
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
apt-get update

add-apt-repository ppa:apt-fast/stable
apt-get update
apt-get -y install apt-fast

apt-fast update

apt-fast install -y wget git autoconf autoconf automake build-essential autogen libtool gettext-base gettext vim bzip2 libpcre3-dev libpcre++-dev
add-apt-repository ppa:webupd8team/java -y
apt-fast update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-fast install -y oracle-java7-installer maven

mkdir -p /installs
pushd /installs
wget --quiet https://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
chmod 755 android-ndk-r10e-linux-x86_64.bin
./android-ndk-r10e-linux-x86_64.bin
${NDK_ROOT}/build/tools/make-standalone-toolchain.sh --platform=android-14 --arch=arm --install-dir=/installs/android-toolchain --system=linux-x86_64 --ndk-dir=${NDK_ROOT}

popd
