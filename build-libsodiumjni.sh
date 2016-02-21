#!/bin/bash -ev

if uname -a | grep -q -i darwin; then
    echo "do nothing"
else
    . ./setenv.sh
fi

ndk-build
rm -rf src/main/jniLibs/
cp -R libs src/main/jniLibs
gradle build
