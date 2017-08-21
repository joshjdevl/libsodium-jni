#!/bin/bash -ev

. ./setenv.sh

./submodule-update.sh

gradle generateSWIGsource --full-stacktrace
gradle build --full-stacktrace
./build-kaliumjni.sh
./build-libsodiumjni.sh
