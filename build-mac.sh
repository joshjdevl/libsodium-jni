#!/bin/bash -ev

brew install libtool autoconf automake swig android-sdk android-ndk gradle libsodium maven

./build.sh

./build-kaliumjni.sh
