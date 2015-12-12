#!/usr/bin/bash`

set -ev

. ./setenv.sh

pushd /installs

rm -rf libsodium
git submodule init
git submodule update
pushd libsodium 
./autogen.sh
./configure && make && make check && make install

pushd dist-build 
./android-arm.sh
./android-build.sh
./android-arm.sh
./android-x86.sh
popd

popd

pushd jni
./installswig.sh
./compile.sh
mvn -q clean install
./singleTest.sh
ndk-build

