#!/bin/bash -ev

. ./setenv.sh

./dependencies-linux.sh
./submodule-update.sh
#./build.sh

#./build-kaliumjni.sh
#./build-libsodiumjni.sh

gradle build --full-stacktrace
./build-kaliumjni.sh
./build-libsodiumjni.sh
