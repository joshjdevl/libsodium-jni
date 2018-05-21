#!/bin/bash

set -ev

. ./setenv.sh

./submodule-update.sh

pushd libsodium

./autogen.sh
./configure --disable-soname-versions --prefix="$PWD/libsodium-host" --libdir="$PWD/libsodium-host/lib"
make --quiet
make --quiet check 
make -j3 install

date
./dist-build/android-arm.sh 
date
./dist-build/android-armv7-a.sh 
date
./dist-build/android-armv8-a.sh
date
./dist-build/android-x86.sh 
date
./dist-build/android-x86_64.sh
date
#folder is being named westmere for the x86-64 architecture
ln -sn libsodium-android-westmere libsodium-android-x86-64

popd

