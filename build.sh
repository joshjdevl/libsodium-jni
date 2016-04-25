#!/bin/bash

set -ev

. ./setenv.sh

rm -rf libsodium

git clone -b Androidx64 https://github.com/alexkeramidas/libsodium.git

pushd libsodium

git fetch && git checkout stable
./autogen.sh
./configure 
make && make check 
sudo make install

./dist-build/android-arm.sh
./dist-build/android-armv7-a.sh
./dist-build/android-armv8-a.sh
./dist-build/android-mips32.sh
./dist-build/android-mips64.sh
./dist-build/android-x86.sh
./dist-build/android-x86-64.sh

popd

