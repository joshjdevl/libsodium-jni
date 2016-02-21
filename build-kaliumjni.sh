#!/bin/bash

if uname -a | grep -q -i darwin; then
    echo "do nothing"
else
    . ./setenv.sh
fi

pushd jni
./compile.sh
popd

mvn -q clean install
./singleTest.sh
ndk-build
rm -rf src/main/jniLibs/
cp -R libs src/main/jniLibs
gradle build
