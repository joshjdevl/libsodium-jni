#!/bin/bash

pushd jni
./installswig.sh
./compile.sh
popd

mvn -q clean install
./singleTest.sh
ndk-build
