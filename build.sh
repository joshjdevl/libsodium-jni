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
./configure --quiet
make --quiet && make --quiet check 
sudo make --quiet install

date
./dist-build/android-arm.sh > /dev/null
date
./dist-build/android-armv7-a.sh > /dev/null
date
./dist-build/android-armv8-a.sh > /dev/null 
date
./dist-build/android-mips32.sh > /dev/null
date
./dist-build/android-mips64.sh > /dev/null
date
./dist-build/android-x86.sh > /dev/null
date
./dist-build/android-x86_64.sh > /dev/null
date
#folder is being named westmere for the x86-64 architecture
mv libsodium-android-westmere libsodium-android-x86-64

popd

