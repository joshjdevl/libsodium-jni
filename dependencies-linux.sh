#!/bin/bash

set -ev

. ./setenv.sh

sudo apt-get -qq update && sudo apt-get -y -qq install python-software-properties software-properties-common
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get -qq update

sudo add-apt-repository -y ppa:saiarcot895/myppa
sudo apt-get -qq update
sudo apt-get -y -qq install apt-fast

sudo apt-fast -qq update

sudo apt-fast -y -qq install wget git autoconf autoconf automake build-essential autogen libtool gettext-base gettext vim bzip2 libpcre3-dev libpcre++-dev pkg-config
#gradle building issues
sudo apt-fast -y -qq install gcc-multilib lib32z1
sudo add-apt-repository ppa:webupd8team/java -y 
sudo apt-fast -qq update 
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-fast -y -qq install oracle-java8-installer maven 

#http://apt.llvm.org/
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-${CLANG_VERSION} main"
#sudo apt-add-repository "deb-src http://apt.llvm.org/$(lsb_release -sc)/ llvm-toolchain-$(lsb_release -sc)-${CLANG_VERSION} main"
sudo apt-fast -qq update
sudo apt-fast -y install clang-${CLANG_VERSION} lldb-${CLANG_VERSION}

mkdir -p ./installs
pushd ./installs
wget --quiet http://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip
chmod 755 android-ndk-${NDK_VERSION}-linux-x86_64.zip
test -e "android-ndk-${NDK_VERSION}" || unzip -qq "android-ndk-${NDK_VERSION}"-linux-x86_64.zip
test -e `pwd`/installs/android-toolchain || ${NDK_ROOT}/build/tools/make_standalone_toolchain.py -v --api=${NDK_TOOLCHAIN_PLATFORM} --arch=${NDK_TOOLCHAIN_ARCHITECTURE} --install-dir=`pwd`/installs/android-toolchain 
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
