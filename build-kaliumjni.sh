#!/bin/bash

pushd jni
./installswig.sh
./compile.sh
mvn -q clean install
./singleTest.sh
ndk-build
