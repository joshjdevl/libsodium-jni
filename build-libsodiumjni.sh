#!/bin/bash -ev

ndk-build
rm -rf src/main/jniLibs/
cp -R libs src/main/jniLibs
gradle build
