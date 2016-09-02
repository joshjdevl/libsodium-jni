#!/bin/bash

set -ev

. ./setenv.sh

rm -rf libsodium

git submodule init
git submodule sync
#git submodule update --remote --merge
git submodule update

pushd libsodium

git fetch && git checkout stable
git reset --hard origin/stable
git pull
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
./dist-build/android-x86_64.sh
#folder is being named westmere for the x86-64 architecture
mv libsodium-android-westmere libsodium-android-x86-64

popd

