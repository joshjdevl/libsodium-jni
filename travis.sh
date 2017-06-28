#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    true
else
    gradle build --full-stacktrace
    ./build-kaliumjni.sh
    ./build-libsodiumjni.sh
    #gradle connectedCheck --full-stacktrace
fi

