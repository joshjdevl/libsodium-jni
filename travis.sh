#!/bin/bash -ev

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    #./build-mac.sh > /dev/null
    ./dependencies-mac.sh
    #./build.sh
    #./build-kaliumjni.sh
else
    #true # Building for Linux is now fully implemented by "gradle build". 
    gradle build --full-stacktrace
    gradle connectedCheck --full-stacktrace
fi

