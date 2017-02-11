#!/bin/bash

set -ev

. ./setenv.sh

rm -rf libsodium

git submodule init
git submodule sync
#git submodule update --remote --merge
git submodule update

pushd libsodium

git fetch && git checkout 64e7da2c69ece12060ccfc333482dbabc68476ba
#git reset --hard origin/64e7da2c69ece12060ccfc333482dbabc68476ba
#git pull
./autogen.sh
./configure --quiet
make --quiet && make --quiet check 
sudo make --quiet install

date
./dist-build/android-arm.sh 
date
./dist-build/android-armv7-a.sh 
date
./dist-build/android-armv8-a.sh
date
./dist-build/android-mips32.sh
date
./dist-build/android-mips64.sh
date
./dist-build/android-x86.sh 
date
./dist-build/android-x86_64.sh
date
#folder is being named westmere for the x86-64 architecture
ln -sn libsodium-android-westmere libsodium-android-x86-64

popd

