#!/bin/bash -v

. ./setenv.sh

./submodule-update.sh

gradle build --full-stacktrace --debug
./build-kaliumjni.sh
./build-libsodiumjni.sh
