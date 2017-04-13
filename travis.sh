#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    true
else
    #true # Building for Linux is now fully implemented by "gradle build". 
    gradle build --full-stacktrace
    ./build-kaliumjni.sh
    ./build-libsodiumjni.sh
    #gradle connectedCheck --full-stacktrace
    #./build.sh
fi

