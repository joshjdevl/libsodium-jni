#!/bin/bash -ev

brew upgrade libtool autoconf automake swig android-sdk android-ndk gradle libsodium maven

./update-android.sh
