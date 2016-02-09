#!/bin/bash

. ./setenv.sh

pushd jni
./installswig.sh
./compile.sh
popd

mvn -q clean install
./singleTest.sh
ndk-build
rm -rf src/main/jniLibs/
cp -R libs src/main/jniLibs
gradle build
